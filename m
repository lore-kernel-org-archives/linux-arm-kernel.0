From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Dec 2014 17:33:09 +0100
Subject: [PATCH 5/5] ARM: dts: sun6i: Add dts file for CSQ CS908 board
In-Reply-To: <5475962A.4090508@redhat.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
 <1416747283-13489-6-git-send-email-hdegoede@redhat.com>
 <20141125182147.GD25249@lukather> <5475962A.4090508@redhat.com>
Message-ID: <20141204163309.GS30256@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 26, 2014 at 09:58:18AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/25/2014 07:21 PM, Maxime Ripard wrote:
> >On Sun, Nov 23, 2014 at 01:54:43PM +0100, Hans de Goede wrote:
> >>The CSQ CS908 is an A31s based top-set box, with 1G RAM, 8G NAND,
> >>rtl8188etv usb wifi, 2 USB A receptacles (1 connected through the OTG
> >>controller), ethernet, 3.5 mm jack with a/v out and hdmi out:
> >>
> >>http://www.geekbuying.com/item/CS908-Allwinner-A31S-Quad-Core-1-2GHz-Android-4-4-Mini-TV-Box-HDMI-HDD-Player-1G-8G-WIFI-Miracast---Black-333395.html
> >>
> >>Note it has no sdcard slot and therefore can only be fel booted.
> >
> >Thanks a lot for working on this!
> >
> >I also bought another board with an A31s, but it ended up having
> >neither USB OTG or MMC, which rendered it pretty useless.
> 
> Are you sure ? The cs908 also does not have an otg connector,
> as said it has 2 usb-a receptacles, with the following usb "routing":
> 
> usb0 (otg): usb-a receptacle 1 (labeled 1 on the box, 0 on the print)
> usb1 (ehci): routed to internal wifi
> usb2 (ehci): usb-a receptacle 2 (labeled 2 on both the box and the print)
> 
> I'm using fel mode with an usb-a <-> usb-a cable connected to usb0 on
> the cs908. The cs908 has no fel button, so I've hooked up the serial console,
> and then keep 2 pressed on the serial console while inserting the usb-a into
> the PC (which will also power the board). boot0 from the nand will then jump
> into fel mode when it sees the 2 keypress.
> 
> This was an interesting exercise to confirm that everything on the A31s just
> works with A31 code, but now that is confirms A31s devices are not all that
> interesting anymore :)

Ah, that's very interesting... I'll dig this board out then, and try
both USB-A connector. It might very well be just that.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/c7df56da/attachment.sig>
