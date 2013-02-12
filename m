From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Feb 2013 17:48:11 +0100
Subject: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
In-Reply-To: <511A1E39.5000304@codethink.co.uk>
References: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
 <20130210181710.GB12760@nekote.pengutronix.de>
 <511A1E39.5000304@codethink.co.uk>
Message-ID: <20130212164811.GV8668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ben,

On Tue, Feb 12, 2013 at 10:49:29AM +0000, Ben Dooks wrote:
> On 10/02/13 18:17, Wolfram Sang wrote:
> >On Mon, Feb 04, 2013 at 02:33:15PM +0530, Yuvaraj Kumar C D wrote:
> >>This RFC patch is w.r.t multimaster bus arbitration which is already
> >>being discussing in the mainline.
> >>This patch provides hooks for the i2c multimaster bus arbitration
> >>and to have the arbitration parameters.
> >
> >I still haven't understood why the arbitration specified in the I2C
> >standard is not enough for you. Or what you would need to make use of
> >it.
> 
> I am a little concerned as there is no way to actually lock a bus to
> stop another master from transmitting. You can get collisions in a
> multi-master environment. Drivers need fixing to deal with collisions
> and let the sender know the operation has failed.
In theory everything should just work. If a master send a Start, the bus
is actually locked and other masters must wait until Stop. If two
masters start concurrently one master just looses arbitration and the
winning master's transfer isn't corrupted. So client drivers don't need
adaption and master drivers "only" need to handle arbitration and
synchronization (which they should already now :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
