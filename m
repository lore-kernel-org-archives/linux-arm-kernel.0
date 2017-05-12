From: robh@kernel.org (Rob Herring)
Date: Fri, 12 May 2017 15:03:00 -0500
Subject: [PATCH 1/8] mmc: dt: pwrseq-simple: Invent power-off-delay-us
In-Reply-To: <1494260477-25163-2-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20170512200300.a2hq546ra42ptlz5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 06:21:10PM +0200, Ulf Hansson wrote:
> During power off, after the GPIO pin has been asserted, some devices like
> the Wifi chip from TI, Wl18xx, needs a delay before the host continues with
> clock gating and turning off regulators as to follow a graceful shutdown
> sequence.
> 
> Therefore invent an optional power-off-delay-us DT binding for
> mmc-pwrseq-simple, to allow us to support this constraint.

Do you really need this to be programmable per device. A delay is not 
going to hurt devices that don't need it.

Sorry, but this is exactly what I don't like about "simple" bindings: 
adding one property at a time.

Rob
