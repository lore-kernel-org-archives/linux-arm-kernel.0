From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Jan 2013 10:11:05 -0600
Subject: [RFC PATCH 0/2] ARM: update cpuinfo to print CPU model name
In-Reply-To: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
References: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <5107F499.2050608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 09:54 AM, Ruslan Bilovol wrote:
> Hi,
> 
> The following patches update cpuinfo to print CPU
> model name for ARM. First patch exactly makes needed
> changes for ARM architecture.
> Second patch adds this ability to OMAP4 SoCs.
> 
> This adds a common approach to show SoC name.
> 
> Looks like there were few attempts to do similar
> changes to cpuinfo without any luck.

Care to point out how your solution is different from those or addresses
the issues with them.

Assuming we want to do this, I think this information should come from
DeviceTree. OMAP may have this in a register, but others don't.

Rob

> 
> So - comments are welcome
> 
> Ruslan Bilovol (2):
>   ARM: kernel: update cpuinfo to print CPU model name
>   ARM: OMAP4: setup CPU model name during ID initialisation
> 
>  arch/arm/include/asm/setup.h |    1 +
>  arch/arm/kernel/setup.c      |   10 ++++++++++
>  arch/arm/mach-omap2/id.c     |   18 ++++++++++++++++--
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
