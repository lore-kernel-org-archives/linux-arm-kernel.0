From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 17 Apr 2013 04:45:32 -0700
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <9EDD532A-1EEB-450A-A68C-E8EE64C2ECA6@suse.de>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAFEAcA-1HAG0pY-j-rqU=QmSoep3Di-KNPATvuou8ghRn3SaqA@mail.gmail.com>
 <516810F7.7040601@arm.com>
 <20130417101906.GX14496@n2100.arm.linux.org.uk>
 <516E7ADE.5090601@arm.com>
 <CAEDV+gK3nitpN+8ZePRY7n+bsc2t4XbWrz6fbdz0Wjq_kTgM4g@mail.gmail.com>
 <516E87D1.5000109@arm.com>
 <CAFEAcA8oE+2BRRgoeA4-0PzOQkxzGwDT5qunudzg7RBA9aWCgQ@mail.gmail.com>
 <9EDD532A-1EEB-450A-A68C-E8EE64C2ECA6@suse.de>
Message-ID: <CAEDV+g+81HwHHyneYkRTF+KV12POPuLb7OjCHA1TwcxYT_6TMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 4:42 AM, Alexander Graf <agraf@suse.de> wrote:
>
> On 17.04.2013, at 13:38, Peter Maydell wrote:
>
>> On 17 April 2013 12:30, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> By disabling the problematic configuration, we just bury our head in the
>>> sand and pretend everything is fine. Yes, this is a new feature. But by
>>> saying "not a supported configuration", while the code *should* support
>>> it, we're only fooling ourselves.
>>
>> Who says the code should support running on big.LITTLE? I think
>> it's very clear that the only thing it should support at the
>> moment is A15 guest CPUs on an all-A15 host CPU system.
>
> Is anyone going to run this code on big.LITTLE systems before 3.10 is out?
>

Apparently yes, otherwise we would not be having this discussion in
the first place.

> Just fix it for real with 3.10 and everyone's happy. If need be, you can always CC the fixes to stable to have them in 3.9.
>
>
That's really an added feature set, which I don't think is appropriate
for stable. Currently we *do not support big.little* but we pretend
that we do, and even worse, we pretend that we can emulate an A15 on
an A7 for example, which we obviously cannot, and nobody looked at
what kind of damage that can cause. Therefore, the "fix" for the
current supported features is to bail out on something as funky as a
big.little, and I honestly don't see what the big problem with that
is. And, such a fix is what should go in stable.
