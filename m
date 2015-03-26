From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 26 Mar 2015 17:11:17 +0000
Subject: [linux-sunxi] [PATCH resend v2 1/2] ARM: dts: sun4i: a10-lime:
 Override and remove 1008MHz OPP setting
In-Reply-To: <1427216007-9185-2-git-send-email-wens@csie.org>
References: <1427216007-9185-1-git-send-email-wens@csie.org>
 <1427216007-9185-2-git-send-email-wens@csie.org>
Message-ID: <55143DB5.5050108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/15 16:53, Chen-Yu Tsai wrote:
> The Olimex A10-Lime is known to be unstable when running at 1008MHz.

> +			operating-points = <
> +				/* kHz    uV */
> +				912000  1350000
> +				864000  1300000

If we're dropping the top speed to 912 in the kernel, should we do the 
same in u-boot?

I was already planning on sending a patch to add the 912MHz setting to 
u-boot due to sun7i requesting CONFIG_CLK_FULL_SPEED of 912 but getting 
overclocked to 960 instead. I can easily do this at the same time.

Rgds,
Iain
