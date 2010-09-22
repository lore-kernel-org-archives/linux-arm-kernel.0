From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Sep 2010 16:58:04 +0100
Subject: [PATCH v2 3/3] mfd: regulator: max8998: mfd code
In-Reply-To: <1285169410-22343-4-git-send-email-l.majewski@samsung.com>
References: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
	<1285169410-22343-4-git-send-email-l.majewski@samsung.com>
Message-ID: <20100922155804.GK26395@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 05:30:10PM +0200, Lukasz Majewski wrote:

Please provide a more descriptive changelog which says what the
functional changes are; it's clear that the changes are in MFD but what
do they do?

> +	max8998->type = id->driver_data;

This needs to be the first patch in the series, I think - the others
won't build without this.  Each patch in the series should leave the
kernel buildable, partly for review (so we see things added before they
are used) and partly so that things like git bisect work well.

> +/* MAX8998 output voltages */
> +enum {
> +	MAX8998_DVS_750mV = 0,
> +	MAX8998_DVS_775mV,

My previous comments about this being better as a value than an
enumerated type still apply.

> + * @buck1_vol: BUCK1 voltage levels
> + * @buck2_vol: BUCK2 voltage levels

So as far as I can tell (and I may be missing something since "voltage
levels" and code is all I have) these are the voltages programmed for
the various voltage selections at system startup?  I would very strongly
expect these to be read back from the chip when the driver starts when.

> + * @buck1_init_idx: BUCK1 initial voltage index
> + * @buck2_init_idx: BUCK2 initial voltage index

It'd be clearer to describe these as the initial GPIO setting.
