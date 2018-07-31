From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 13:20:36 -0600
Subject: [PATCH v6 2/5] dt-bindings: thermal: qcom-spmi-temp-alarm:
 Improve thermal zone in example
In-Reply-To: <20180731185917.176074-2-mka@chromium.org>
References: <20180731185917.176074-1-mka@chromium.org>
 <20180731185917.176074-2-mka@chromium.org>
Message-ID: <20180731192036.GA3770@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 11:59:14AM -0700, Matthias Kaehlcke wrote:
> The current example for a thermal zone isn't very useful as reference
> since it would result in a hardware shutdown at 145?C, instead of
> allowing the system to try to shutdown gracefully. Without an ADC
> channel a maximum of two trip points is useful in practice for this
> sensor, with temperatures corresponding to the stage 1 and stage 2
> 'hardware trip points'. A critical trip point at stage 2 may allow the
> system to shutdown before a hardware shutdown at stage 3 kicks in. It
> should be noted though that by default the chip performs a 'partial
> shutdown' when the temperature reaches stage 2, which may prevent an
> orderly shutdown. The 'partial shutdown' can be disabled by software.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
