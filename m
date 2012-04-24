From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Apr 2012 20:18:06 +0200
Subject: [PATCHv8 06/10] I2C: OMAP: Fix the crash in i2c remove
In-Reply-To: <4F96ED77.9070503@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-7-git-send-email-shubhrajyoti@ti.com>
 <20120423164944.GE27321@pengutronix.de> <4F96ED77.9070503@ti.com>
Message-ID: <20120424181806.GF9007@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 11:44:15PM +0530, Shubhrajyoti wrote:
> On Monday 23 April 2012 10:19 PM, Wolfram Sang wrote:
> >>     [  154.901153] Exception stack(0xdf9b9fb0 to 0xdf9b9ff8)
> >> >     [  154.907104] 9fa0:                                     beaf1f04 4006be00 0000000f 0000000c
> >> >     [  154.915710] 9fc0: 4006c000 00000000 00008034 ffffff40 00000007 00000000 00000000 0007b8d7
> >> >     [  154.916778] 9fe0: 00000000 beaf1b68 0000d23c 4005baf0 80000010 ffffffff
> >> >     [  154.931335]  r6:ffffffff r5:80000010 r4:4005baf0 r3:beaf1f04
> >> >     [  154.937316] ---[ end trace 1b75b31a2719ed21 ]--
> >> > 
> >> > Cc: <stable@vger.kernel.org>
> >> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Is this really the correct solution? I do wonder that every driver using
> > runtime PM should enable the clocks on their own. That should be done by
> > the core, 
> By core you don't mean the i2c core but the pm layer right?

Yes.

> > I'd say; it is not unusual that drivers need to write to
> > registers in remove(). If it is correct, can I get some acks?
> I did see the crash.

That was never a doubt. With "correct" I meant "correct solution".

> Will wait for the pm experts to comment.

Yup.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/683e5f8d/attachment.sig>
