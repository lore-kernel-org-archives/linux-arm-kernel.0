From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sun, 26 Mar 2017 23:25:24 +0200
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170326180012.3eic4bt2p6h6u3nh@kozik-lap>
References: <20170325162654.3827-1-krzk@kernel.org>
 <2736911.EcZSki4vB1@positron.chronox.de>
 <20170326180012.3eic4bt2p6h6u3nh@kozik-lap>
Message-ID: <4479175.Jfq03yCxQW@tauon.atsec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 26. M?rz 2017, 20:00:12 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> > Would it make sense to add another outer loop here to allow all of slen to
> > be injected into the DRNG? Note, in some cases, a user wants to add more
> > seed into the DRNG than the actual seed size. In this case, the DRNG acts
> > as a compression operation of entropy. This is used when the
> > entropy-to-data ratio is not 1:1. In a lot of cases, users have a seed
> > which has less entropy in bits per data bit.
> 
> Hi,
> 
> I do not know whether this would have any benefit on hardware. The
> datasheet is not describing too much here. It is actually saying only:
> 1. Write SEED to each register (five in total).
> 2. Confirm that STATUS register says seeding done.
> 3. Start RNG engine.
> 4. Wait for engine finish (another bit in STATUS - clear it then).
> 5. Read the randoms.
> 
> I would guess that the hardware will ignore all previously written seeds
> and use the last one. Maybe the hardware will use all of the seeds
> written as you imply. It is just a guessing.

Oh my, if you are right with your first guess, this is a bad DRNG design.

Just out of curiousity: what happens if a caller invokes the seed function 
twice or more times (each time with the sufficient amount of bits)? What is 
your guess here?

Ciao
Stephan
