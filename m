From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Aug 2013 12:19:43 +0100
Subject: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1 CPU
 devices
In-Reply-To: <52092AA5.3090005@ti.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
 <51FBC610.9030900@arm.com> <51FBCEC3.4030207@ti.com>
 <51FBD42A.9040901@arm.com>
 <20130802154857.GD5292@mudshark.cambridge.arm.com>
 <52092AA5.3090005@ti.com>
Message-ID: <20130813111943.GE30280@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 07:34:13PM +0100, Santosh Shilimkar wrote:
> On Friday 02 August 2013 11:48 AM, Will Deacon wrote:
> > I think this an A9-specific register, which reads as 0 on UP A9 and reads as
> > some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
> > is zero.
> > 
> What do we do here ? Should we document this in the code and proceed ?
> Mostly there is no platform with PERIPH_BASE = 0, so its should be fine but
> I am open for any other alternative.

The only other alternative I can think of is forcing people to have
CONFIG_SMP=n, but that blows away single zImage for your platform.

Will
