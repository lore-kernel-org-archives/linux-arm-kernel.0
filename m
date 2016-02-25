From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Feb 2016 09:09:27 +0100
Subject: [PATCH 1/3] dt-bindings: arm/marvell: ABI unstability warning
 about Marvell 7K/8K
In-Reply-To: <CAL_JsqLevrujSeYNBvSJA-5T0Ho8y7c0fKid7QvVm8LLvYLotw@mail.gmail.com>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1456327007-31008-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160224172545.GC9137@leverpostej>
 <20160224211045.379352d3@free-electrons.com>
 <CAL_JsqLevrujSeYNBvSJA-5T0Ho8y7c0fKid7QvVm8LLvYLotw@mail.gmail.com>
Message-ID: <20160225090927.13492cfb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

On Wed, 24 Feb 2016 16:07:04 -0600, Rob Herring wrote:

> You should fix the incomplete information problem. I pushed back on
> this, you got more information and already the binding is closer to
> reality.

"You should fix the incomplete information problem". You seem to think
that it is a simple thing that can be fixed with a magic wand. But it's
not.

Either because the internal processes are complicated, or simply
because the Linux kernel support is done without cooperation from the
HW vendor (it's not the case of this Marvell platform, but it's the
case of many other platforms).

> Mark didn't say don't submit. First, there is value in submitting even
> if not accepted immediately and you have to carry some patches for
> some time. It was also suggested that you err on the side of less
> information in DT if things are uncertain and you have not done that.

Submitting without merging is useless. The point of submitting is to
get the code merged, to reduce the amount of out-of-tree patches we
have to carry, and to allow users of the platform to simply run
mainline on their platform.

So this proposal really doesn't make any sense. Just like Mark initial
statement of not submitting code so early.

> > So please get to an agreement between DT binding maintainers. And stop
> > saying this ridiculous statement that HW vendors should stop submitting
> > their code to the mainline.
> 
> You want us to agree, then you won't like the answer. Bindings must be
> stable. I'll allow exceptions to that, but not without push back.
> 
> In general, if there is disagreement about whether stability is
> required, then it is required. See the recent sunxi discussion. That's
> more between users and platform maintainers though.

Do you realize that this all DT binding stuff is today the *biggest* to
getting HW support in the Linux kernel? It has become more complicated
to merge a 4 properties DT binding than to merge multiple thousands of
lines of driver code. Simply because of this DT stability fairy tale.

In the mean time, I'm withdrawing this patch. I'll let Mark and you in
your Alice in Wonderland world, where you believe that DT bindings are
stable while the reality is that they are not and that their stability
is actually unneeded for most platforms.

Gregory, can you skip patch 1/3, and merge patches 2/3 and 3/3, once
the new clock DT binding has been approved.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
