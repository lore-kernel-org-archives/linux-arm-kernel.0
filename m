From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 29 Nov 2016 16:53:25 +0000
Subject: [PATCH] KVM: arm/arm64: Access CNTHCTL_EL2 bit fields correctly
In-Reply-To: <0a475329-6f50-42ae-3244-f0767c56ce09@arm.com>
References: <1480351570-11648-1-git-send-email-jintack@cs.columbia.edu>
 <d04fd17e-9157-07fe-4daa-9dbab149b5e6@arm.com>
 <799d03f5-a929-9547-1ae7-94026b76f116@arm.com>
 <CAHyh4xhXoFWsbnNNePthWp2-ZAOtCuUVmLn-JKRe4sc=nqrYNw@mail.gmail.com>
 <0a475329-6f50-42ae-3244-f0767c56ce09@arm.com>
Message-ID: <ee2dacff-691c-7548-ff71-3a992f399333@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/16 09:36, Marc Zyngier wrote:
> On 29/11/16 03:28, Jintack Lim wrote:
>> On Mon, Nov 28, 2016 at 1:39 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 28/11/16 17:43, Marc Zyngier wrote:
>> This looks much cleaner than my patch.
>> While we are at it, is it worth to consider that we just need to set
>> those bits once for VHE case, not for every world switch as an
>> optimization?
>
> Ah! That's a much better idea indeed! And we could stop messing with
> cntvoff_el2 as well, as it doesn't need to be restored to zero on exit.
> Could you try and respin something along those lines?
>

fyi, we have a static_key based cpus_have_const_cap() for Constant cap
checking (like this case) available in linux-next. May be you could make use
of that instead of alternatives.


Cheers
Suzuki
