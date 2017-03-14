From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 22:41:10 +0100
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
Message-ID: <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 10:52 PM, Timur Tabi <timur@codeaurora.org> wrote:

> On ACPI platforms, the kernel has no control over the muxing (aka function)
> of the various pins.  Firmware configures the TLMM controller for all pins,
> and configures them for whatever functions they're supposed to be.

I think it would be better if pin control and ACPI play along, and I bet that
will happen in the future. This is I guess a question for ACPI standardization
work.

> Therefore, on ACPI, the driver should never change the function of any pin.
> If it's set to something other than 0, then it should never touch that pin.
> Don't write to it, don't change the direction, and definitely don't change
> the function.

Does that mean that pins with 0 are free to play around with?

> So would it be acceptable, for example, to change msm_gpio_set() such that
> if the function of that pin is non-zero, just return an error?

I would ask the driver maintainer about his opinion, and also whoever
is an authority on ACPI for the TLMM-chips, I am no expert
in ACPI. Hell I'm not even good at device tree. Not to mention SFI.
Oh well...

> After all, if pin #17 is set to UART and not GPIO, then there's no point in
> setting that value to 1 or 0, because it's not muxed for GPIO and therefore,
> that 1/0 is not actually going anywhere.  It won't be written to the pin.
>
> I hope I'm making sense.

In a way I guess, I'm just ignorant about how current ACPI implementations
work with hardware in this case so it is likely that you know this
better than me.

Yours,
Linus Walleij
