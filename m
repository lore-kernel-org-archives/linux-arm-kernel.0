From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Mar 2014 22:22:45 +0100
Subject: [PATCH 04/20] mmc: mmci: Move signal directions bits into DT
 include file
In-Reply-To: <1395404057-27835-5-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdZSr380FVHkx3uOMFKxKYsExoL-1WYhxVpirFMVc+T3Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 1:14 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> These bits is currently used from platform data, but will be needed
> from DT as well, so let's make them available.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(...)
> +#define MCI_ST_DATA31DIREN     (1 << 5)
> +#define MCI_ST_FBCLKEN         (1 << 7)
> +#define MCI_ST_DATA74DIREN     (1 << 8)

Isn't MCI_ST_FBCLKEN = feedback clock enable and nothing
to do with directions really?

Or can you convince me ...

Maybe we should just have single strings for these
things in the binding instead, like:

@@ -118,6 +119,10 @@
                        bus-width = <4>;
                        mmc-cap-sd-highspeed;
                        mmc-cap-mmc-highspeed;
+                       st,signal-direction-data2;
+                       st,signal-direction-cmd;
+                       st,signal-direction-data0;
+                       st,feedback-clock-enable;
                        vmmc-supply = <&ab8500_ldo_aux3_reg>;
                        vqmmc-supply = <&vmmci>;
                        pinctrl-names = "default", "sleep";

And for FBCLKEN is that really something that should
be configured... in the device tree after all?

Yours,
Linus Walleij
