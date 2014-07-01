From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Wed, 02 Jul 2014 02:47:58 +0300
Subject: [PATCH 6/6] thermal: Add Tegra SOCTHERM thermal management driver
In-Reply-To: <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
Message-ID: <53B348AE.20605@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/14 11:11, Mikko Perttunen wrote:
> +	/* Sign extend from 6 bits to 32 bits */
> +	shifted_cp = (s32)((val & 0x1f) | ((val & 0x20) ? 0xffffffe0 : 0x0));
> +	val = ((val & (0x1f << 21)) >> 21);
> +	/* Sign extend from 5 bits to 32 bits */
> +	shifted_ft = (s32)((val & 0xf) | ((val & 0x10) ? 0xfffffff0 : 0x0));

There's sign_extend32 in bitops.h
