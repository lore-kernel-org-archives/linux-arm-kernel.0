From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 14:18:03 +0200
Subject: [PATCH 1/3] reset: Add support for the Amlogic Meson GXBB Reset
 Controller
In-Reply-To: <1463736478.4322.31.camel@pengutronix.de>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
 <1463736478.4322.31.camel@pengutronix.de>
Message-ID: <573F007B.6030502@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 05/20/2016 11:27 AM, Philipp Zabel wrote:
> Hi Neil,
> 
> Am Freitag, den 20.05.2016, 10:27 +0200 schrieb Neil Armstrong:
>> +config MESON_GXBB_RESET
>> +	tristate "Amlogic Meson GXBB Reset Driver"
>> +	depends on (ARCH_MESON && RESET_CONTROLLER)
> 
> With the "reset: fix Kconfig menu to include reset drivers in sub-menu"
> patch [1] applied this is wrapped in "if RESET_CONTROLLER ... endif", so
> no need to depend on RESET_CONTROLLER.
> Is there a reason to have this configurable at all, though?
> 
> [1] https://patchwork.kernel.org/patch/9000591/
> 
> Or drop CONFIG_MESON_GXBB_RESET and use CONFIG_ARCH_MESON directly.

No strong reason, I will switch to CONFIG_ARCH_MESON.

> [...]
> 
> With the "reset: add devm_reset_controller_register API" patch [2]
> applied you can use devm_reset_controller_register() here and remove the
> meson_gxbb_reset_remove() function below.
> 
> [2] https://patchwork.kernel.org/patch/8988471/
> 
>> +}
>> +
>> +static int meson_gxbb_reset_remove(struct platform_device *pdev)
>> +{
>> +	struct meson_gxbb_reset *data = platform_get_drvdata(pdev);
>> +
>> +	reset_controller_unregister(&data->rcdev);
>> +
>> +	return 0;
>> +}
> 
> Could be removed, then.
> 
> regards
> Philipp

It will be for sure !

Neil
