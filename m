From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 May 2015 09:07:44 +0100
Subject: [PATCH] ARM: imx6: allow booting with old DT
In-Reply-To: <1432713148.3011.6.camel@pengutronix.de>
References: <1432658616-13733-1-git-send-email-l.stach@pengutronix.de>	
 <20150527073408.GD16165@dragon> <1432713148.3011.6.camel@pengutronix.de>
Message-ID: <55657B50.7000006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/15 08:52, Lucas Stach wrote:
> Am Mittwoch, den 27.05.2015, 15:34 +0800 schrieb Shawn Guo:
>> On Tue, May 26, 2015 at 06:43:36PM +0200, Lucas Stach wrote:
>>> The GPC rewrite to IRQ domains has been on the premise that it may break
>>> suspend/resume for new kernels on old DT, but otherwise keep things working
>>> from a user perspective. This was an accepted compromise to be able to move
>>> the GIC cleanup forward.
>>>
>>> What actually happened was that booting a new kernel on an old DT crashes
>>> before even the console is up, so the user does not even see the warning
>>> that the DT is too old. The warning message suggests that this has been
>>> known before, which is clearly unacceptable.
>>
>> To see any early message like this one, low-level debug support is
>> expected to be turned on.
>>
> Using low-level debug might be acceptable for a developer.
> 
> From a user perspective a kernel update without a corresponding DT
> update should never render the machine completely broken. Keep in mind
> that i.MX6 isn't only used in deeply embedded system, but is already in
> devices where non-developer users might update the kernel. They might
> even use prebuilt kernels where enabling low-level debug is not an
> option.

I'd imagine that whoever provides this pre-build kernel would also
deliver some form of release notes indicating the procedure. Even
better, an installation script.

> We are not free to break the existing DT stability rules in such a
> drastic way, especially if keeping things working to some extent is
> easily done.

That would be on the condition that the DT was correct the first place,
and accurately described the hardware. It didn't, breaking the contract
we have the first place.

We can argue for years about DT stability, history proves that it
doesn't lead anywhere.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
