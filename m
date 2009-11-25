From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 17:07:26 +0000
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <1259145751-3331-13-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-13-git-send-email-daniel@caiaq.de>
Message-ID: <20091125170726.GH5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:42:26AM +0100, Daniel Mack wrote:
> +	if (en) {
> +		gpio_set_value(mfp_to_gpio(GPIO_AUDIO_VA_ENABLE), 1);
> +		gpio_set_value(mfp_to_gpio(GPIO_MCLK_RESET), 1);
> +
> +		/* wait some time to let VA and the clocks become stable */
> +		schedule_timeout(HZ/10);

Again, msleep() preferred.
