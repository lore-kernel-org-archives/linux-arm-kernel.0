From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Mar 2018 15:00:38 +0000
Subject: arm64 kvm built with clang doesn't boot
In-Reply-To: <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
 <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
Message-ID: <2e84a842-96e8-aec4-8b85-9ee879bb323a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/18 14:53, Andrey Konovalov wrote:
> On Fri, Mar 16, 2018 at 3:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> I wasn't aware of that discussion, but this is indeed quite annoying.
>> Note that you should be able to restrict this to arch/arm64/kvm/hyp/*
>> and virt/kvm/arm/hyp/*.
> 
> That works as well (tried it, the kernel boots). I've also tried
> compiling without the flag for virt/kvm/arm/hyp/*, it boots as well.

That's just luck. Anything in a hyp/ directory has the potential to be
executed at EL2, and thus could be generating these jump tables. It
could blow up at a later time, once you start running VMs...

	M.
-- 
Jazz is not dead. It just smells funny...
