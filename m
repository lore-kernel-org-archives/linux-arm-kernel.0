From: rabin@rab.in (Rabin Vincent)
Date: Mon, 24 Sep 2012 11:06:57 +0200
Subject: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
In-Reply-To: <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
 <1346943430-18236-3-git-send-email-kishon@ti.com>
 <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
 <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
Message-ID: <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/24 ABRAHAM, KISHON VIJAY <kishon@ti.com>:
> On Sat, Sep 22, 2012 at 3:03 AM, Rabin Vincent <rabin@rab.in> wrote:
>> USB doesn't work on pandaboard on linux-next, and bisection shows this
>> patch.  Unfortunately, I can't provide a dmesg log because USB is the
>> only way I currently have to get one out(!), but presumably it's because
>> this omap-usb2 device is never registered?  Looks like this breaks
>> non-dt USB on pandaboard; is that intended?
>
> Yes. omap-usb2 is *only* dt supported (New drivers shouldn't have the
> old non-dt support).

Well, USB used to work fine on Pandaboard without DT before the
introduction of "omap-usb2", so one would expected it to continue
working (until the board file is completely removed).

Anyway, I've moved to DT now.

> Some patches are queued only for 3.7.
>
> In case you want to use MUSB please use these patches on linux-next..
> [PATCH v2] arm: omap: hwmod: make *phy_48m* as the main_clk of ocp2scp
> [PATCH] ARM: OMAP2+: hwmod data: Fix ocp2scp_usb_phy and usb_host_hs
> entries (from Benoit)
> [PATCH 0/2] ARM: dts: Add subnode for ocp2scp (patch series)
> [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB (patch series)

I got these by merging in Benoit's for_3.7/dts_part2 on top of
next-20120921.  Thanks.
