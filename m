From: rob.herring@linaro.org (Rob Herring)
Date: Wed, 27 Jun 2018 15:40:23 -0600
Subject: [PATCH v4 2/2] ARM: dts: pxa: fix the rtc controller
In-Reply-To: <20180627194124.26366-2-robert.jarzmik@free.fr>
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
 <20180627194124.26366-2-robert.jarzmik@free.fr>
Message-ID: <CABGGisxeC=1Lc+ZKpR=Uzy75BQ8k=Tah4cYmZDnc_mdJWiCD1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 1:41 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> The RTC controller is fed by an external fixed 32kHz clock. Yet the
> driver wants to acquire this clock, even though it doesn't make any use
> of it, ie. doesn't get the rate to make calculation.
>
> Therefore, use the exported 32.768kHz clock in the PXA clock tree to
> make the driver happy and working.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: change the dummy clock by the actual 32.768kHz
> Since v3: remove spurious bracket
> ---
>  arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
>  arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
