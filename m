From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jan 2012 11:26:12 +0100
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <20120105011704.GA8870@codeaurora.org>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk>
 <4F048EC4.40900@arm.com> <20120105011704.GA8870@codeaurora.org>
Message-ID: <CACRpkdYjQPoY60XdhTwgLYbTrQMhC=Wxk5Y=hP2Vr0DngUJbxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 2:17 AM, David Brown <davidb@codeaurora.org> wrote:
> On Wed, Jan 04, 2012 at 05:39:16PM +0000, Marc Zyngier wrote:
>> I do. But on some non-SMP platforms, the local timer and the global
>> timer can actually be the same (MSM is one example of this, and the UP
>> version of the Cortex A15 is another).
>
> On SMP MSM, we use the CPU0 local timer as the global timer. ?They are
> the same on non-SMP as well,

Does this mean your CPU0 local timer is always on, always clocked?
And do you use ARMs SMP TWD IP block for that?

> I guess, but as Russell says, I'm not
> sure what the concept of a local timer would mean on non-SMP.

I think this looks like one big misunderstanding. I understood it as
the SMP TWD block is synthesized also on UP silicon, i.e. same
hardware, and so it will need to use the driver from
arch/arm/kernel/smp_twd.c, however there is nothing local
about that apart from being in close locality of the CPU.

Let us talk about the SMP TWD timer block for A8/A9 systems if
that is what it's all about (is it? maybe I'm confused too...)
and architectured timers for A15.

Linus Walleij
