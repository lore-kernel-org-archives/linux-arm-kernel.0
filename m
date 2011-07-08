From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 08 Jul 2011 16:13:23 +0100
Subject: [RFC PATCH v2 0/4] Core device subsystem
In-Reply-To: <4E170134.1020306@arm.com>
References: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>	<CAHXqBFJiovYq5x_JDAxikvFs-t1To6yC-1uajBJFRX_jwjvejA@mail.gmail.com>
	<4E170134.1020306@arm.com>
Message-ID: <4E171E93.8020608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/11 14:08, Marc Zyngier wrote:
> So you're basically folding of_core_device_populate() and
> core_driver_init_class() into one call, and generating the
> of_device_ids on the fly. If you're going down that road,
> it would be even simpler to directly use of_device_ids
> instead of core_device_ids and skip the generation altogether.
> 
> That would also remove the static declaration of devices to be
> probed in the architecture support code...
> 
> Let me think of it and prototype that.

See the attached patch against branch dt_gic_twd from
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git

It boots fine on my PB11MP.

What do you think?

	M.
-- 
Jazz is not dead. It just smells funny...
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: code_dev.patch.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110708/ff104de1/attachment.txt>
