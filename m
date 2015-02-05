From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 5 Feb 2015 19:39:14 +0100
Subject: [RFC/PATCH 2/2] of: allow for boolean flags to have value
In-Reply-To: <1423159266-25561-2-git-send-email-balbi@ti.com>
References: <1423159266-25561-1-git-send-email-balbi@ti.com>
 <1423159266-25561-2-git-send-email-balbi@ti.com>
Message-ID: <20150205183914.GV10842@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 12:01:06PM -0600, Felipe Balbi wrote:
> allowing values to boolean flags lets us setup
> defaults on DTSI which can get disabled later
> at board DTS if, for whatever reason, board can't
> use that default.
> 
> One such example is DM81xx EVM where we can't use
> MUSB's multipoint feature even though SoC supports
> it. Something at the board level prevents us from
> using the feature.
> 
> Instead of removing "multipoint;" from DTSI and
> adding it to all board DTS just so we can remove
> it from our quirky board seems like overkill when
> we could just add:
> 
> 	multipoint = <0>;
> 
> to that quirky board's DTS.
> 
> Note that the description here is but one example
> and it's likely many others have faced something
> similar.
And others even came up with solutions, too: The right thing to do in
this case is

	/delete-property/ multipoint;

This works since

	cd296721a964 (dtc: import latest upstream dtc)

which is in 3.7-rc1. See

http://permalink.gmane.org/gmane.linux.drivers.devicetree/19170

for the related discussion.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
