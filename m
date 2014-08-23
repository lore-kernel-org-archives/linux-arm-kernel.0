From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Aug 2014 15:33:05 +0100
Subject: [PATCH 6/6] ARM: dts: hummingboard: gpio-ir on gpio 3,5
In-Reply-To: <CAOMZO5DrtrEJxmCZSO6RVZom8kzZhu2dikntRwYZeq5j_QZ9sw@mail.gmail.com>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
 <CAOMZO5C=xyYLLBX1PDsJQ9NwzXZxCWTvPMTUWzYcoohOOvA_qA@mail.gmail.com>
 <20140823133649.GP30401@n2100.arm.linux.org.uk>
 <CAOMZO5DrtrEJxmCZSO6RVZom8kzZhu2dikntRwYZeq5j_QZ9sw@mail.gmail.com>
Message-ID: <20140823143305.GQ30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 10:56:37AM -0300, Fabio Estevam wrote:
> On Sat, Aug 23, 2014 at 10:36 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Aug 23, 2014 at 10:32:23AM -0300, Fabio Estevam wrote:
> >> On Sat, Aug 23, 2014 at 6:11 AM, Russell King
> >> <rmk+kernel@arm.linux.org.uk> wrote:
> >>
> >> > -                               MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
> >> > +                               MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x80000000
> >>
> >> It would be better to replace the '0x80000000' with the real iomux
> >> value (like 0x1b0b0 for example), so that we do not need to rely on
> >> the bootloader doing the correct configuration for us.
> >
> > I'd just end up choosing something which appears to work - I've no idea
> > at present what an appropriate value should be here.
> 
> In the working system, you could read the register:
> 
> IOMUXC_SW_PAD_CTL_PAD_EIM_AD05 (address: 0x20E043C)
> 
> Most likely it will return the default value of 0xb0b1 if the
> bootloader has not re-configured it.

Most of the pins not associated with booting the kernel are left
unconfigured by the boot loader - that's because uboot SPL has very
little space for such things.

Rabeeh has just told me that 0x1b0b1 would be a better value for it.
I'll add an additional patch to the series for that, rather than
modifying Rabeeh's original patch.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
