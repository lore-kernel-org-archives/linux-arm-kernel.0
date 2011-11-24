From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 10:59:03 +0800
Subject: [RFC PATCH 0/3] Convert imx6 clock to device tree
In-Reply-To: <20111122082314.GB27267@pengutronix.de>
References: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
 <20111122082314.GB27267@pengutronix.de>
Message-ID: <20111124025902.GB17979@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 09:23:14AM +0100, Sascha Hauer wrote:
> On Tue, Nov 22, 2011 at 09:48:53AM +0800, Shawn Guo wrote:
> > As I promised to Arnd, I will convert imx6 clock code to common clock
> > framework and in turn device tree at the earliest time.  Here it is.
> 
> Very nice ;) I like the patches.
> 
> Is there a way to improve the way how the entities find their base
> addresses? Currently the C code figures out the base addresses based
> on compatible.

May I understand the problem with doing that?

> Maybe we could put the crm clocks and anatop clocks into
> two different nodes instead of putting them all directly under clocks{}.
> 
I do not quite understand this.  Are you suggesting we keep using the
static base address definition in C code for ccm and anatop rather than
retrieving them from device tree?  No, we do not want to do this.  So
if we need to get the addresses from device tree anyhow, using
compatible to find the correct node is the best way to me.

> Could you split the last patch into two, one adding new device tree
> clock support in a new file and another removing the old clock support?
> This would help reviewing.
> 
Yes, will do.  I would also rename the new file back to clock-imx6q.c
in the last patch, because I want to keep using that file name.

-- 
Regards,
Shawn
