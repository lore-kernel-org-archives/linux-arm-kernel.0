From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 17:06:41 +0200
Subject: [PATCH 5/6] ARM: integrator: move CM base into device tree
In-Reply-To: <20131008095639.GE28972@e106331-lin.cambridge.arm.com>
References: <1380816228-3209-1-git-send-email-linus.walleij@linaro.org>
 <20131008095639.GE28972@e106331-lin.cambridge.arm.com>
Message-ID: <CACRpkdY4Ao64nfppsU5HV-c41ci1Wei9T=LUvXvs3Lbwqfgp7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 11:56 AM, Mark Rutland <mark.rutland@arm.com> wrote:

>>  Required nodes:
>> +- core-module: the root node to the Integrator platforms must have
>> +  a core-module with regs and the compatible-string
>> +  "arm,core-module-integrator"
>
> s/compatible-string/compatible string/
>
> What are the regs -- one entry, or several?
>
> What do they correspond to?
>
> How big are they?

OK, sent a revised patch clarifying and extending the documentation.

>> +- cpcon/syscon: the root node the Integrator/CP must have a /cpcon
>> +  node pointing to the CP control registers, and the Integrator/AP
>> +  must have a /syscon node pointing to the Integrator/AP system
>> +  controller. The AP syscon node must include the logical module
>> +  interrupts.
>
> It's a shame we can't fix this up to have a compatible string...

Who says we can't ;-)

I feel a bit guilty for this since it's my invention (I was young, I
needed the DT support so badly) so now I feel I need to go in
and write a patch for this.

In this patch it is just documenting the state of things so this
needs to be a separate cleanup.

Yours,
Linus Walleij
