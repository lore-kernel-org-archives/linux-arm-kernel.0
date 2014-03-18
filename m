From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Mar 2014 10:48:55 +0000
Subject: [PATCH] ARM: kdump: Avoid overflow when converting pfn to physaddr
In-Reply-To: <1395138042-62364-1-git-send-email-sdu.liu@huawei.com>
References: <1395138042-62364-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <20140318104855.GU21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 06:20:42PM +0800, Liu Hua wrote:
> When we configure CONFIG_LPAE=y, pfn << PAGE_SHIFT will
> overflow if pfn >= 0x100000 in copy_oldmem_page.
> 
> So use __pfn_to_phys for converting.

Yes.  The sad thing is that if you grep the kernel for similar things,
it's littered with this problem.  I'm not sure whether anyone
particularly "owns" the crash_dump.c file - Mika Westerberg and
Olaf Hering were the last two to touch it... I guess put this in my
patch system please.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
