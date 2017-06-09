From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 10 Jun 2017 00:16:11 +0200
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <81f270ba-6f3c-7759-789b-181203efb7b7@ti.com>
References: <1496716596-45414-1-git-send-email-bo.zhang@nxp.com>
 <20170606192554.GA32171@amd>
 <1a14165d-2976-50df-18d6-74e5fdec2913@gmail.com>
 <8afffd09-cb1f-d080-ef4a-ecaa089ad470@ti.com>
 <20170606203813.GD32171@amd>
 <AM3PR04MB4044D34CA2E85B0CE70ED778AC80@AM3PR04MB404.eurprd04.prod.outlook.com>
 <81f270ba-6f3c-7759-789b-181203efb7b7@ti.com>
Message-ID: <20170609221611.GD28596@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-06-07 10:38:47, Grygorii Strashko wrote:
> 
> 
> On 06/06/2017 11:24 PM, Bruce Zhang wrote:
> > Hi Pavel,
> > 
> > It can also fix my issue by reverting  the commit 5ab92a7cb. But this action only does not make led_set_brightness_nosleep function to set brightness. The heartbeat trigger timer is still running even though it is not harmful.
> 
> Unfortunately, this is sort of design issue of leds triggers framework as it
> doesn't have Suspend related interfaces, so triggers continue running 
> even if led, by it self, is suspended from led_classdev_suspend().
> For example, heartbeat trigger timer can be source of spurious wake-ups 
> in some cases.

Yes, trigger keeps running. It should not be a problem... right?

									Pavel
							

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170610/bcd6e3f4/attachment.sig>
