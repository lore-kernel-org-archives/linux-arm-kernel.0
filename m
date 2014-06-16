From: john.stultz@linaro.org (John Stultz)
Date: Mon, 16 Jun 2014 11:58:02 -0700
Subject: [PATCH V2 3/3] mmc: mmci: Reverse IRQ handling for the arm_variant
In-Reply-To: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
References: <1402906147-26596-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CALAqxLWs5HLhLo+BspcgyJe0O++PB1HU2G1GpsoQ=cVP34=v=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 1:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Commit "mmc: mmci: Handle CMD irq before DATA irq", caused an issue
> when using the ARM model of the PL181 and running QEMU.
>
> The bug was reported for the following QEMU version:
> $ qemu-system-arm -version
> QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.1), Copyright
> (c) 2003-2008 Fabrice Bellard
>
> To resolve the problem, let's restore the old behavior were the DATA
> irq is handled prior the CMD irq, but only for the arm_variant, which
> the problem was reported for.
>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hey Ulf,
  Thanks for sending these out (though I wasn't cc'ed on this 3'rd
patch). The first two apply for me, but this one doesn't. What should
I be basing this off of?

thanks
-john
