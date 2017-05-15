From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 15 May 2017 13:08:25 +0200
Subject: [PATCH 1/8] mmc: dt: pwrseq-simple: Invent power-off-delay-us
In-Reply-To: <20170512200300.a2hq546ra42ptlz5@rob-hp-laptop>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-2-git-send-email-ulf.hansson@linaro.org>
 <20170512200300.a2hq546ra42ptlz5@rob-hp-laptop>
Message-ID: <CAPDyKFqhbGqanoQqFsLrLaBXsQ5WdFrrunkvB2eOoJqH+W6jdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2017 at 22:03, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 08, 2017 at 06:21:10PM +0200, Ulf Hansson wrote:
>> During power off, after the GPIO pin has been asserted, some devices like
>> the Wifi chip from TI, Wl18xx, needs a delay before the host continues with
>> clock gating and turning off regulators as to follow a graceful shutdown
>> sequence.
>>
>> Therefore invent an optional power-off-delay-us DT binding for
>> mmc-pwrseq-simple, to allow us to support this constraint.
>
> Do you really need this to be programmable per device. A delay is not
> going to hurt devices that don't need it.

Well, that depends on what "hurt" means. The device would still be
properly shut down, only that it would take unnecessary longer to do
so.

I think the problem here, is that this delay may also affect system
suspend/resume time of the device, if the device powers off/on in this
sequence.

>
> Sorry, but this is exactly what I don't like about "simple" bindings:
> adding one property at a time.

I understand you opinion, which in the end is a matter of taste/flavor.

However, for me this just follows the existing approach - and suddenly
say no to this, doesn't really seems right either.

Kind regards
Uffe
