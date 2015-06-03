From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Jun 2015 11:45:35 +0200
Subject: [PATCH v2 6/6] ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33 and
 1024x600 lcd support
In-Reply-To: <556D6955.8030708@redhat.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-7-git-send-email-hdegoede@redhat.com>
 <20150602081459.GO23777@lukather> <556D6955.8030708@redhat.com>
Message-ID: <20150603094535.GI23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:29:09AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 02-06-15 10:14, Maxime Ripard wrote:
> >On Sat, May 30, 2015 at 04:55:06PM +0200, Hans de Goede wrote:
> >>The Ippo-q8h is a tablet circuit board commonly found in cheap Android
> >>tablets. The v1.2 version can be used with either an A23 or A33 SoC.
> >>
> >>This adds a dts file for the v1.2 board with an A33 SoC and a 1024x600
> >>LCD screen (most of these tablets have a 800x480 screen).
> >
> >I think the difference between the resolution here is more of a case
> >for the DT quirks interface:
> >https://lkml.org/lkml/2015/2/18/258
> 
> I would expect the only difference between the 2 dts files to be the
> node describing the lcd panel, so yes that makes somewhat sense.
> 
> >Do you know if there's some way to autodetect the two board versions
> >(like a board id somewhere in an EEPROM)?
> 
> No, AFAIK there is no way to tell the difference. There is no eeprom no
> the board, and we really cannot rely on the nand contents.

Ok.

> >If not, then maybe u-boot can simply add that board compatible to the
> >list, and we'll base our logic on that when we'll need it.
> 
> That means extra logic in u-boot, and on the kernel side, for what
> benefit exactly? Such logic would make sense if there was one u-boot
> image which runtime adjusted itself, but that is not an option.

For what benefit? One kernel image which runtime adjusts itself. It's
especially possible if u-boot's image is not, which seems to be what
you're saying.

> And we can avoid copy and paste on the dts side by putting all
> the common stuff in a common file and including that, I believe
> that that is better (KISS = better) since we've no way to runtime
> do the right thing AFAICT.

My concern is about the ever-growing number of DTS that just are small
variations of one or the other. What about the time when we'll
discover that this board has a variant that has an emmc, and some that
don't have any button, or the i2c bus 2 not wired, and one other that
doesn't have any HDMI?

Do we really want to have a dts called
sun8i-a33-q8h-emmc-lcd800x600-nohdmi-noi2c2-nobuttons.dts?

Especially when we will have the one that we include here that will
not have followed this convention because it was introduced before
that, and that we have a way to deal with this nicely?

You chose to consider the DTS names an ABI, the best way to handle
this is to have a DTS as generic as possible, and leave all these
small variations outside of the name.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/cf19263b/attachment.sig>
