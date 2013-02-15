From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 15 Feb 2013 06:39:43 +0100
Subject: [PATCH v6 09/10] clk: tegra: Implement clocks for Tegra114
In-Reply-To: <1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com><1360580700-10245-10-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130215.073943.1228868991272784104.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver <pdeschrijver@nvidia.com> wrote @ Mon, 11 Feb 2013 12:04:59 +0100:

> +enum tegra114_clk {
.....
> +       i2c4 = 103, sbc5 = 104, sbc6 = 105, apbif = 107, d_audio, dam0, dam1,
> +       dam2, hda2codec_2x = 111, audio0_2x = 113, audio1_2x, audio2_2x,

The above doesn't match the definition in  .../bindings/clock/nvidia,tegra114-car.txt.

....
105	sbc6
106	d_audio
107	apbif
108	dam0
109	dam1
110	dam2
111	hda2codec_2x
....

Taking a look at TRM, d_audio = 106 seems to be correct?

-       i2c4 = 103, sbc5 = 104, sbc6 = 105, apbif = 107, d_audio, dam0, dam1,
+       i2c4 = 103, sbc5 = 104, sbc6 = 105, d_audio, apbif = 107, dam0, dam1,
