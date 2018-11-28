From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 21:17:03 +0800
Subject: [PATCH 53/77] ARM: dts: sun8i: a23/a33: Fix Display Engine DTC
 warnings
In-Reply-To: <3aa2981b56cd9f875b9a576d6a3b6c982a832780.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <3aa2981b56cd9f875b9a576d6a3b6c982a832780.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65v9Z1CEdxWJvY-+XMPbDN42hmSFHzoFxzRpuquLYHqQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our display engine endpoints trigger some DTC warnings due to the fact that
> we're having a single endpoint that doesn't need any reg property, and
> since we don't have a reg property, we don't need the address-cells and
> size-cells properties anymore.
>
> Fix those
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

[...]

> @@ -370,12 +358,9 @@
>                                 #size-cells = <0>;
>
>                                 fe0_out: port at 1 {
> -                                       #address-cells = <1>;
> -                                       #size-cells = <0>;
>                                         reg = <1>;
>
> -                                       fe0_out_be0: endpoint at 0 {
> -                                               reg = <0>;

The backend driver gets its ID from here. We need to teach it about missing reg
properties where reg was 0, otherwise the driver will refuse to bind.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
