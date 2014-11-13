From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 18:41:56 +0100
Subject: [PATCH v2 13/14] ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
In-Reply-To: <20141113145419.GA30296@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1415876417-28728-1-git-send-email-peter.griffin@linaro.org>
 <3348806.YN8XP4V4uc@wuerfel>
 <20141113145419.GA30296@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <2401196.5cvW5dPSz2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 14:54:19 Peter Griffin wrote:
> 
> > 
> > It also seems that you have put the node in the wrong place, as the reg
> > property apparently refers to a different address space. Did you mean
> > to put this under the syscfg_core node?
> 
> Your correct in that it refers to the syscfg_core address space.
> However I intentionaly didn't put it under the syscfg_core node.
> 
> The phy is more unique than most other devices in that in this instance it
> is only controlled from two syscfg_core registers which happen to be in the same
> sysconf bank.
>
> However most other devices tend to have a combination of some memory mapped
> registers and also some sysconfig registers which does then create a conflict
> over where the dt node should live.
> 
> Currently I can't find an example but there is also no guarentee that a
> device will not have some configuration bits in syscfg_core and some
> other bits in syscfg_rear/front registers. The phy for example could
> have had one register in each, which would make deciding where to put
> it difficult.
> 
> So to create coherency / conformity we decided to put all the IP blocks under the soc node.
> 
> Also its worth pointing if your not already aware that sysconf_core/rear/front isn't
> really a device, it's just a regmap abstraction of some memory mapped configuration
> registers where a bunch of seemingly random control bits get stuffed.
> 
> Of course if you feel strongly about it I can of course change it like you suggested,
> but that is the reasoning / rationale of why it was done like this initially.

The problem is your use of the 'reg' property. If it doesn't refer to the
node's address space, it shouldn't be called 'reg'.

Please fix the binding.

	Arnd
