From: ben@simtec.co.uk (Ben Dooks)
Date: Sun, 26 Sep 2010 00:48:57 +0100
Subject: [PATCH v2 1/3] rx1950: add battery device
In-Reply-To: <1283936292-10429-1-git-send-email-anarsoul@gmail.com>
References: <4C86C56B.7090204@fluff.org>
	<1283936292-10429-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4C9E8A69.8020000@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/10 09:58, Vasily Khoruzhick wrote:
> v2: don't force usage of battery driver,
> use named initialisers in LUTs.

Any chance of more description here?


> +
> +static const struct s3c_adc_bat_thresh bat_lut_noac[] = {
> +	{
> +		.volt = 4100,
> +		.cur = 156,
> +		.level = 100
> +	},

In this case I'd say we may as well do the following
	{ .volt = 4100, .cur = 156, .level = 100 },

given there so many of them.

-- 
Ben
