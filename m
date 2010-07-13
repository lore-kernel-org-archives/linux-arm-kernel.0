From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 15:17:10 +0100
Subject: [PATCH v2 1/2] regulator: add support for regulators on the
	ab8500 MFD
In-Reply-To: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20100713141709.GA24260@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 07:39:32PM +0530, Sundar Iyer wrote:

> + * @mask: mask to enable/disable regulator
> + * @enable: bits to enable the regulator in normal(high power) mode

Have you addressed my comments here?

> +	ret = ab8500_get_best_voltage_index(rdev, min_uV, max_uV);
> +	if (ret < 0) {
> +		dev_dbg(rdev_get_dev(rdev),
> +				"coudlnt get best voltage for regulator\n");

Typo here.  Also, shouldn't your error messages be errors rather than
debug output?
