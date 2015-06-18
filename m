From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Jun 2015 12:24:28 -0500
Subject: [PATCH] i2c: omap: improve duty cycle on SCL
In-Reply-To: <5582678F.4010505@gmx.de>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
 <55815581.80807@gmx.de> <20150617153812.GB18421@saruman.tx.rr.com>
 <5582678F.4010505@gmx.de>
Message-ID: <20150618172428.GB27790@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 08:39:11AM +0200, Michael Lawnick wrote:
> Am 17.06.2015 um 17:38 schrieb Felipe Balbi:
> >Hi,
> >
> >On Wed, Jun 17, 2015 at 01:09:53PM +0200, Michael Lawnick wrote:
> >>Am 16.06.2015 um 21:17 schrieb Felipe Balbi:
> >>>With this patch we try to be as close to 50%
> >>>duty cycle as possible. The reason for this
> >>>is that some devices present an erratic behavior
> >>>with certain duty cycles.
> >>>
> >>>One such example is TPS65218 PMIC which fails
> >>>to change voltages when running @ 400kHz and
> >>>duty cycle is lower than 34%.
> >>>
> >>>The idea of the patch is simple:
> >>>
> >>>calculate desired scl_period from requested scl
> >>>and use 50% for tLow and 50% for tHigh.
> >>...
> >>Hmm, and what's about  Philips I2C specification 2.1, Jan 2000, Table 5?
> >>
> >>>PARAMETER                       SYMBOL  STANDARD-MODE   FAST-MODE     UNIT
> >>>                                          MIN. MAX.     MIN. MAX.
> >>>LOW period of the SCL clock     tLOW      4.7   ?       1.3   ?       ?s
> >>>HIGH period of the SCL clock    tHIGH     4.0   ?       0.6   ?       ?s
> >>
> >>Your signal is in spec (0.85 ?s high, 1,65 low).
> >>Maybe your TPS65218 is just buggy or signals are bad?
> >
> >yes, tps is buggy, it's written in the commit log itself.
> >
> 
> So I think it is unacceptable to change the adapters code violating
> specification because some buggy device doesn't work properly.

read the other thread and you'll see that it's not violating jack

> This change for your device has chance to blow up many correctly
> working ones.

How ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150618/2359f2bf/attachment.sig>
