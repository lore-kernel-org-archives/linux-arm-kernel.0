From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 27 May 2018 13:40:13 -0300
Subject: [PATCH 1/3] ARM: dts: imx6 wandboard and riotboard: remove
 regulators bus node
In-Reply-To: <20180526183053.14029-2-akurz@blala.de>
References: <20180526183053.14029-1-akurz@blala.de>
 <20180526183053.14029-2-akurz@blala.de>
Message-ID: <CAOMZO5AzC1FVfwuimxnaGgsksDk6MjXpGiwwbc0Yer-fX8ZVFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

[It would be better to split this patch in two: one for wandboard and
another one for riotboard]

On Sat, May 26, 2018 at 3:30 PM, Alexander Kurz <akurz@blala.de> wrote:

> +
> +       reg_2p5v: fixedregulator at 0 {

This causes dtc warnings with W=1 as you are passing a unit address
without a corresponding reg property.

You can rewrite this as:

reg_2p5v: regulator-2p5v {

Please follow this convention in the entire series.

Thanks
