From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Mon, 06 Apr 2015 00:08:08 +0300
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
References: <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth> <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com> <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
Message-ID: <5521A438.1070008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On  5.04.2015 19:50, Matthijs van Duin wrote:
> On 5 April 2015 at 09:23, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
>> Though I wonder why SMC is needed to write ACR on non-HS devices. A simple
>> MRC should suffice, unless I miss something.
>
> Public-world access to ACR varies per bit:
> bit 1 (L2EN) is documented as banked, but at least on r3p2 turns out
> to be common r/w.
> bits 30-31 are secure read-only and public RAZ.
> remaining bits are secure read/write and public read-only.
>
> The net effect is that doing an MRC from public world will only modify
> the L2EN bit.
>
> There's no bit in the non-secure access control register to affect all
> of this, so GP vs HS doesn't matter here (from a CPU point of view; it
> may matter for the availability of SM calls obviously).
>
> Matthijs
>

But then the first part(setting the IBE bit in ACR to 1) of the errata 
workaround is wrong, as it uses a plain MCR to set the IBE bit, see 
http://lxr.free-electrons.com/source/arch/arm/mm/proc-v7.S#L340. Which 
is weird, given that the workaround was posted by ARM iirc.

Ivo
