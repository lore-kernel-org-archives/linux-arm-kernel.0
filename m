From: peter.senna@collabora.co.uk (Peter Senna Tschudin)
Date: Mon, 02 Jan 2017 11:26:36 +0000
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?= V7 =?utf-8?q?3=2F4=5D?=
 =?utf-8?q?_drm=2Fbridge=3A?= Add driver for GE B850v3
 =?utf-8?q?LVDS=2FDP++?= Bridge
In-Reply-To: <4232c88a99f44a24287d04d74b891e2eb139864c.1483301745.git.peter.senna@collabora.com>
Message-ID: <6187-586a3900-3-4c1baf00@27351102>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
On 01 January, 2017 21:24 CET, Peter Senna Tschudin <peter.senna@collabora.com> wrote: 

[ ... ] 

> +static void ge_b850v3_lvds_dp_detach(struct drm_bridge *bridge)
> +{
> +	struct ge_b850v3_lvds_dp *ptn_bridge
> +			= bridge_to_ge_b850v3_lvds_dp(bridge);
> +	struct i2c_client *ge_b850v3_lvds_dp_i2c
> +			= ptn_bridge->ge_b850v3_lvds_dp_i2c;
> +
> +	/* Disable interrupts */
> +	i2c_smbus_write_word_data(ge_b850v3_lvds_dp_i2c,
> +			STDP4028_DPTX_IRQ_EN_REG, ~STDP4028_DPTX_IRQ_CONFIG);

 ~STDP4028_DPTX_IRQ_CONFIG? Argh! Will fix this and resend after reviews...

[ ... ] 
 
 
