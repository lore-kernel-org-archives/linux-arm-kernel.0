From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 19:54:26 +0100
Subject: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
In-Reply-To: <CAPDyKFqxvTi9caXC=XwVTmwMS0-48movLeATnxMmXCsHVoDbUw@mail.gmail.com>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
 <20121211145243.GQ14363@n2100.arm.linux.org.uk>
 <CACRpkdbZSFQ1HvXZ3Op093CediAm9rPHwHX38h_sxwE9ARSe5A@mail.gmail.com>
 <CAPDyKFqxvTi9caXC=XwVTmwMS0-48movLeATnxMmXCsHVoDbUw@mail.gmail.com>
Message-ID: <CACRpkdYy0kDzJKtQJ3g0E0RHw7syw-y=rfNMi0BhAywdtSnq3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 12:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 December 2012 07:53, Linus Walleij <linus.walleij@linaro.org> wrote:

>> 1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
>> which means that the ios will be called with f=0 whenever
>> the card is unused, taking into account the required number
>> of clocks to the card.
>
> I think MMC_CLKGATE was a good initiative in the past. But that was
> before runtime pm was there to use. Runtime pm suits much better for
> handling clock gating and other runtime power save actions that could
> be possible for a host driver to do.
>
> I would even suggest the MMC_CLKGATE should be removed from the
> protocol layer, once we see that all host drivers that used it has
> switch to runtime pm.

Ah now I remember that you've actually even explained this to me ...
memory is too short sometimes. But I follow this idea.

Then we have only the coordination between runtime suspend
and suspend proper to iron out.

Russell's concern is valid if suspend() will not wait for runtime_suspend()
to complete the last cycle before suspending.

Hm this sounds scaringly familiar to what we've discussed with
Kevin Hilman et al recently...

Yours,
Linus Walleij
