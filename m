From: smuckle@codeaurora.org (smuckle at codeaurora.org)
Date: Mon, 21 Jun 2010 17:47:17 -0700 (PDT)
Subject: [RFC PATCH] smp: parallel smp boot option
In-Reply-To: <20100621223146.GE13624@n2100.arm.linux.org.uk>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
	<20100621220030.GC13624@n2100.arm.linux.org.uk>
	<1277158949.17092.61.camel@c-dwalke-linux.qualcomm.com>
	<20100621223146.GE13624@n2100.arm.linux.org.uk>
Message-ID: <ec4622af344be763d55b91bc867f3330.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Your OK with this hook? I was thinking it might be better to check if
>> it's the book cpu or the secondary here instead of in
>> arch/arm/mach-msm .
>
> Not entirely.  It would appear that it means you can never used a
> compressed kernel on MSM, since if you do, you'll have all CPUs in
> the system decompressing the kernel simultaneously.
>
> If we have to have this hook, how about making it a weak reference
> rather than something dealt with by the configuration system?

This is something we're using until we get a more complex/featureful
bootchain in place. It probably only has value in development
platforms/early enablement. A weak reference seems fine or we could drop
it alltogether.

thanks,
Steve

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
