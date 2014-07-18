From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Jul 2014 11:42:35 +0200
Subject: [PATCHv6 1/4] iio: adc: exynos_adc: Add exynos_adc_data structure
 to improve readability
In-Reply-To: <1405663186-26464-2-git-send-email-cw00.choi@samsung.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <1405663186-26464-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <6186153.TIYp5NXPIq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 July 2014 14:59:43 Chanwoo Choi wrote:
> This patchset add 'exynos_adc_data' structure which includes some functions
> to control ADC operation and specific data according to ADC version (v1 or v2).
> 

This new structure makes a lot of sense for covering the exynos specific
versions, but it will likely give a little more complexity for the
older models. We'll have to deal with that later then, no need to
hold up your patch. Interestingly, the version numbers seem weird. The
old driver uses

	{
                .name           = "s3c24xx-adc",
                .driver_data    = TYPE_ADCV1,
        }, {
                .name           = "s3c2443-adc",
                .driver_data    = TYPE_ADCV11,
        }, {
                .name           = "s3c2416-adc",
                .driver_data    = TYPE_ADCV12,
        }, {
                .name           = "s3c64xx-adc",
                .driver_data    = TYPE_ADCV2,
        }, {
                .name           = "samsung-adc-v3",
                .driver_data    = TYPE_ADCV3,
	}

Where TYPE_ADCV3 seems to be the same as the new ADC_V1 used in this
driver. Do you have an explanation for that?

	Arnd
