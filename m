From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 23 Oct 2013 12:48:48 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023100456.GE11954@ulmo.nvidia.com>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef> <alpine.LFD.2.03.1310221333300.1951@syhkavp.arg>
 <20131022201228.GB8037@mithrandir> <20131022204238.GG29341@beef>
 <20131023100456.GE11954@ulmo.nvidia.com>
Message-ID: <CAFEAcA9MiK3cnxnrd3bOygXMeEAu9_sO20+CMCsYKNEJEuRxOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 11:04, Thierry Reding <thierry.reding@gmail.com> wrote:
> I think there's some broad agreement about what stable bindings entail.
> Essentially it means at no point in the future a new kernel is allowed
> to stop working with an old binding.
>
> It also entails that bindings can change, but only in ways that don't
> break backwards-compatibility.

In my opinion it should also mean that all the same functionality
you got with the old kernel remains enabled. In other words,
if the old kernel could drive the framebuffer because the framebuffer
was still handled by platform data, then you can't break this when
you introduce a new dt binding for the framebuffer; you have to
cope with "dt blob has no node for this device because it's old".
"The kernel boots but it doesn't find half the devices" is just as broken
as "the kernel doesn't boot" if you're an end user trying to use the
old device tree blob with a new kernel...

thanks
-- PMM
