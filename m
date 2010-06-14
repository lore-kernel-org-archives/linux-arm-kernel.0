From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 Jun 2010 13:48:31 +0100
Subject: [PATCH v3] ISL6271A voltage regulator support.
In-Reply-To: <1276442751-3562-1-git-send-email-marek.vasut@gmail.com>
References: <1276442751-3562-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100614124831.GE14604@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 05:25:51PM +0200, Marek Vasut wrote:
> This device is very simple, it supports one buck and two LDOs. The LDOs are
> fixed-voltage. Only the buck is programable over the I2C bus to 16 possible
> voltages.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

For future reference...

> +	/* Convert the data from chip to microvolts */
> +	data = ISL6271A_VOLTAGE_MIN + (ISL6271A_VOLTAGE_STEP * (idx & 0xf));

...note that this is just list_voltage() (if you're going to fix this
please only do so with an incremental patch).
