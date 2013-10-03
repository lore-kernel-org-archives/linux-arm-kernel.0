From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 2 Oct 2013 23:21:56 -0300
Subject: device tree binding documentation outdated
In-Reply-To: <20131002234911.GD12758@n2100.arm.linux.org.uk>
References: <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
 <20130927190546.GG12758@n2100.arm.linux.org.uk>
 <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
 <CAHCPf3sv3wSbUc9QFVhmYsPc1kqiWYRuOMO7rreuiGSrwyepBQ@mail.gmail.com>
 <20130927202110.GI12758@n2100.arm.linux.org.uk>
 <20130928083859.GQ12758@n2100.arm.linux.org.uk>
 <20130929061303.GB26156@S2101-09.ap.freescale.net>
 <20131002193316.GR12758@n2100.arm.linux.org.uk>
 <20131002234911.GD12758@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5BjUryA2XYzyjFoCbGqwRNRhA6QUohy8v6o+rPd__qaCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 2, 2013 at 8:49 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This apparantly is done by configuring the PLL on the IMX6 to 25MHz and
> getting it to output it on this pin, and that is done in the freescale
> BSP by this pin control setting:
>
>         MX6DL_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT
>
> Now, if you look up that in the 4.1.0 BSP:
>
> #define MX6DL_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT                        \
>                 IOMUX_PAD(0x05E4, 0x0214, 0x12, 0x080C, 0, NO_PAD_CTRL)
>
> and that says to write 0x12 to 0x20e0000 + 0x214 - the
> IOMUXC_SW_MUX_CTL_PAD_GPIO16 register.  This name clearly implies that
> the IMX6 is _outputting_ the reference clock.  The register values here
> selects MUX_MODE 2 (ENET_REF_CLK) _with_ SION set.  There is no
> configuration in this BSP for GPIO 16 in mux mode 2 without SION set.

SION bit is set for this pad in mainline as well:

MX6QDL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8

(bit 30 is set, which indicates SION).
