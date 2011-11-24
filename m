From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 24 Nov 2011 13:20:30 -0200
Subject: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
In-Reply-To: <1322134040-32382-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1322134040-32382-1-git-send-email-maxime.ripard@free-electrons.com>
 <1322134040-32382-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOMZO5ADJrLCV6ohkraohqJT1aD2hC_pWEsbDezWGchGrvRYvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 9:27 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> +static struct at91_adc_data ek_adc_data = {
> + ? ? ? .channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
> + ? ? ? .vref = 3300,
> +};

Don't you need to also pass adc_clock?

Otherwise the probe code will fail:

+
+	if (!pdata->adc_clock) {
+		dev_err(&pdev->dev, "No ADCClock available.\n");
+		ret = -EINVAL;
+		goto error_free_clk;
+	}
