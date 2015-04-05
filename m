From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Sun, 05 Apr 2015 10:23:26 +0300
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
References: <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com> <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
Message-ID: <5520E2EE.4080302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On  5.04.2015 07:13, Matthijs van Duin wrote:
> I would actually suggest clearing IBE if it set on Cortex-A8 r2 or
> later processors and a secure monitor call is available to do so
> (there is on the DM814x and AM335x, dunno about the 37xx), also for
> performance reasons: BTB invalidates are quite expensive instructions
> (when enabled).

There is (or should be) SM call, it is explained in 36xx TRM(SWPU177AA) 
as well, 26.4.1, "Booting Overview". Though I wonder why SMC is needed 
to write ACR on non-HS devices. A simple MRC should suffice, unless I 
miss something.

Clearing the IBE bit on devices that don't need erratum 430973 
workaround, along with enabling that workaround in kernel is the best 
approach IMO. That way we will gain both stability on cores that need 
the workaround (like on N900 and the other devices with p1) and won't 
lose performance on cores that are not affected.

>
> Matthijs
>

Regards,
Ivo
