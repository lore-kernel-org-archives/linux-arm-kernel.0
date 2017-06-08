From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jun 2017 17:09:41 +0100
Subject: [PATCH] ARM/Kconfig: make VMSPLIT_3G_OPT depends on !ARM_LPAE
In-Reply-To: <1496901944-42140-1-git-send-email-xieyisheng1@huawei.com>
References: <1496901944-42140-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20170608160941.GN4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 02:05:44PM +0800, Yisheng Xie wrote:
> When both enable CONFIG_ARM_LPAE=y and CONFIG_VMSPLIT_3G_OPT=y, which
> means use PAGE_OFFSET=0xB0000000 with ARM_LPAE, the kernel will boot
> fail and stop after uncompressed:
> 
>    Starting kernel ...
> 
>    Uart base = 0x20001000
>    watchdog reg = 0x20013000
>    dtb addr = 0x80840308
>    Uncompressing Linux... done, booting the kernel.
> 
> For ARM_LPAE only support 3:1, 2:2, 1:3 split of TTBR1, which mention in:
>    http://elinux.org/images/6/6a/Elce11_marinas.pdf - p16
> 
> So we should make VMSPLIT_3G_OPT depends on !ARM_LPAE to avoid trigger
> this bug.

Yes, this is much more preferable.  Please drop it into the patch system,
thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
