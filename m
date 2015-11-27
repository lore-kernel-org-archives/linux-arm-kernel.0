From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 27 Nov 2015 11:18:04 +0100
Subject: [PATCH v4] pwm-backlight: Avoid backlight flicker when probed
 from DT
In-Reply-To: <20151110173257.GA21727@ulmo>
References: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de>
 <3447562.c3gSANEMio@phil> <20151110173257.GA21727@ulmo>
Message-ID: <5498492.8XSal22i1Y@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

Am Dienstag, 10. November 2015, 18:32:57 schrieb Thierry Reding:
> On Tue, Nov 10, 2015 at 03:18:10PM +0100, Heiko Stuebner wrote:
> > Hi Philipp,
> > 
> > Am Montag, 2. November 2015, 17:55:56 schrieb Philipp Zabel:
> > > If the driver is probed from the device tree, and there is a phandle
> > > property set on it, and the enable GPIO is already configured as output,
> > > and the backlight is currently disabled, keep it disabled.
> > > If all these conditions are met, assume there will be some other driver
> > > that can enable the backlight at the appropriate time.
> > > 
> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > 
> > this patch improves the white screen when booting a veyron chromebook
> > a lot. I still see a small white flash, but that can probably come from
> > the WIP edp driver.
> 
> Some panels require a couple of frames before they actually enable. You
> may want to look at the datasheet of your panel to see if it has some
> specific requirement and update the panel driver with that.
> 
> From a high-level view the way that this is supposed to work is that
> your encoder driver (e.g. eDP) "prepares" the panel, then starts sending
> frames and finally "enables" the panel. With something like the simple
> panel driver you can influence this by setting the delay.enable field in
> the panel descriptor.
> 
> See struct panel_desc in drivers/gpu/drm/panel/panel-simple.c

Thanks for the pointers :-)

Just to follow up a little bit, after moving to Yakir's Analogix-dp driver 
from the chromeos-one I was using till now, that actually works nicely for me 
and even the short flash is gone.


Heiko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151127/60d0f669/attachment.sig>
