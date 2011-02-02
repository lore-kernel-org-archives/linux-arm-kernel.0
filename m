From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Feb 2011 21:09:25 +0000
Subject: [PATCH v2] ARM: kexec: selective MMU identity mapping
In-Reply-To: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1296657809-1589-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <20110202210925.GD31043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 03:43:29PM +0100, Per Fransson wrote:
> When restarting using the kernel kexec functionality the MMU
> needs to be turned off. Any code which does this needs to use
> identity mapped addresses to get reliable results. In the ARM
> kexec case this identity mapping is done:
> 
> - using the page table of the current task
> 
> - for all addresses normally used by user space,
>   i.e. 0x00000000-PAGE_OFFSET
> 
> If kexec is used at a kernel crash to collect a core dump this
> means that we lose important information.
> 
> This is what this patches does:
> 
> * Actually turns off the MMU, which has been omitted by mistake
> 
> * Sets up a more selective identity mapping
> 
> * Restores the old mapping once the MMU is off
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> ---
> v2 changes:
> 
> * now uses (modified versions of) the identity mapping functions in idmap.c
>   as they look in 2.6.38-rc1. Some pud-level code has been added there in
>   linux-next.

Thanks.  As this been tested with ARMv4/v5 CPUs as well?
