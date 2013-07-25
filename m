From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Jul 2013 11:05:48 -0700
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
Message-ID: <51F168FC.9070906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2013 10:57 AM, Mark Rutland wrote:
> On Thu, Jul 25, 2013 at 05:09:19PM +0100, Olof Johansson wrote:
...
>> So, there really seems to be a need for a layered approach, one in
>> which a binding "graduates" from being tentative to being locked in.
>> I'm refraining from using the terms "staging" and "stable" here, since
>> they have overloaded meaning in the kernel world that doesn't apply
>> here.
> 
> I'm not sure how realistic it is to have drivers in the kernel using
> unstable bindings, and expect people to not rely on them, but I don't
> have a better option to give. We need a big fat warning that an unstable
> binding is in use.

I don't think having people "rely" on the bindings is the issue so much
as the awareness that if they do, there will be compatibility issues for
unstable bindings.

>> One problem that needs to be solved is obviously how a binding
>> graduates from tentative to locked. This work isn't going to be very
>> interesting to most people, I suspect. Think standards committee type
>> work.
>>
>> A possible way to handle this is to have exactly that: A group of
>> people that essentially constitute the "standards committee" that meet
>> on a regular basis to review and approve new bindings. They should be
>> people not just doing ARM Linux work, but other stakeholders in these
>> bindings too. One of the things they should probably do is sift
>> through our current in-kernel bindings and select those who seem ready
>> to be locked in, review/discuss/decide upon that and once the decision
>> is made, that specific binding does become part of the static,
>> never-ever-change ABI of firmware-to-kernel interfaces.   That might
>> also be the time that the binding is moved from the kernel to a
>> separate repo, but that's a technicality that we'll let the DT
>> maintainers decide among themselves, IMHO.
> 
> We're going to need input from other OSs too, or the bindings will
> remain Linux-specific regardless of how far away the bindings and dts
> repo(s) is/are.

And bootloaders too. Some U-Boot platforms are starting to use DT for
exactly the same reason that the kernel does; to allow a single
bootloader binary to run on a variety of different boards, with all
configuration coming from DT.

On another related topic, something that may be useful for the DT
bindings reviewer team is a basic checklist for new DT bindings.
Something similar to Fedora's package review checklist. Perhaps also
(yet another?) document on a bit of DT philosophy. If this sounds
useful, I could try and take a stab at some basic initial version.

We also need to decide (or just document) exactly what "describes the
HW" means; see the thread on thermal limits, and consider the extension
of describing hard/absolute thermal limits to describing use-cased base
thermal profiles using the same schema, or not allowing that.
