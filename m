From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jun 2016 21:30:23 +0200
Subject: [PATCH v3 4/4] musb: sunxi: Simplify dr_mode handling
In-Reply-To: <08af737c-f1f1-0966-0eca-24d4daa7423b@redhat.com>
References: <1465138776-6003-1-git-send-email-hdegoede@redhat.com>
 <1465138776-6003-4-git-send-email-hdegoede@redhat.com>
 <20160608102325.GI14179@lukather>
 <08af737c-f1f1-0966-0eca-24d4daa7423b@redhat.com>
Message-ID: <20160615193023.GB5144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 08, 2016 at 12:30:20PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08-06-16 12:23, Maxime Ripard wrote:
> >Hi,
> >
> >On Sun, Jun 05, 2016 at 04:59:36PM +0200, Hans de Goede wrote:
> >>phy-sun4i-usb now has proper dr_mode handling, it always registers an
> >>extcon, and sends a notify with the mode (even when in peripheral- /
> >>host-only mode) at least once.
> >>
> >>So we can simply the sunxi musb glue by always registering its extcon
> >>notifier and relying on sunxi_musb_work() to enable vbus when in
> >>host-only mode.
> >>
> >>This also enables host- and peripheral-only mode with vbus monitoring.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >It's been a bit painful to track all the patches needed so that it
> >applies properly, but I've finally been able to test it on a Sinlinx
> >SinA33 with peripheral-only mUSB, and it works like a charm.
> >
> >You can add my Tested-by.
> 
> Great, thanks for testing.
> 
> This is the board which has an otg connector with vbus not connected,
> right? Yet it does have a functional id-pin, right ?

It's that one, yes.

> In that case you should be able to put it in dual-role mode (only
> specify the id-pin in the phy dts node, no vbus / vbus-monitoring)
> and then it _should_ work in host mode if you use a powered hub.
> 
> I'm fine with putting in peripheral-only mode, but as said
> dual-role might work with a powered hub.

Good point, I'll test that.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/4ee36279/attachment-0001.sig>
