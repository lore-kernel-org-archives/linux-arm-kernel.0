From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 15 Apr 2014 17:29:56 -0700
Subject: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
In-Reply-To: <1397526163-20126-5-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397526163-20126-5-git-send-email-abrestic@chromium.org>
Message-ID: <CAL1qeaGGSs5fpqrKWA4u4+RXRy9Ko2pN=s9QQdbXAfLG3ujR8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>         sdhci at 0,700b0600 {
>                 status = "okay";
>                 bus-width = <8>;
> +               vqmmc-supply = <&vddio_1v8>;

It turns out this bit isn't needed as the initialization failures are
instead due to +3V3_RUN toggling, which Stephen has fixed:
http://patchwork.ozlabs.org/patch/339386/
