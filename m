From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Jun 2017 00:29:46 -0700
Subject: [PATCH] ARM: dts: Add am335x-boneblue
In-Reply-To: <CA+T6QPngRrST_T5HcTXxiGnBq6ba+txocaxrW-QVTuqxzogYuw@mail.gmail.com>
References: <20170530162023.20391-1-robertcnelson@gmail.com>
 <CA+T6QPngRrST_T5HcTXxiGnBq6ba+txocaxrW-QVTuqxzogYuw@mail.gmail.com>
Message-ID: <20170606072945.GU3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jason Kridner <jkridner@beagleboard.org> [170601 00:43]:
> On Tue, May 30, 2017 at 12:20 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
> > BeagleBone Blue is robotics-oriented version of the BeagleBone Black (BBB).
> >
> > This board can be indentified by the BLAx value after A335BNLT (BBB)
> > in the at24 eeprom:
> > BLAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 4c 41 30 |.U3.A335BNLTBLA2|]
> >
> > http://beagleboard.org/blue
> > https://github.com/beagleboard/beaglebone-blue
> >
> > firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/master/firmware
> > wl18xx mac address: /proc/device-tree/ocp/ethernet at 4a100000/slave at 4a100200/mac-address
> >
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Jason Kridner <jkridner@beagleboard.org>
> 
> Acked-by: Jason Kridner <jkridner@beagleboard.org>

Applying into omap-for-v4.13/dt.

> Discussed offline the fact that the couple of connectors where we'd
> like to support dynamic pinmuxing that the required pinmux helper code
> is not upstream.

Hmm do you have some link for that? We do have dynamic muxing
working with mainline tree using the named pinctrl modes. At
least omap_hsmmc.c is doing it for am335x SDIO interrupt pin.

Regards,

Tony
