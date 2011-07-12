From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 12 Jul 2011 07:32:18 +0000 (UTC)
Subject: [PATCH 3.1 3/4] ARM:simpad: add GPIO based device definitions.
References: <1310453186-22518-1-git-send-email-jochen@scram.de>
	<1310453186-22518-4-git-send-email-jochen@scram.de>
Message-ID: <ivgta2$vvj$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jochen Friedrich wrote:

> Register keyboard, polled keyboard and I2C platform
> devices based on GPIOs.
>
> V3: Split LED changes into seperate patch.
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/arm/mach-sa1100/simpad.c |   67 ++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 66 insertions(+), 1 deletions(-)

[skip]

> @@ -259,7 +321,10 @@ static struct platform_device simpad_mq200fb = {
>  };
>  
>  static struct platform_device *devices[] __initdata = {
> -	&simpad_mq200fb

Are you sure this is correct?

> +	&simpad_keys,
> +	&simpad_polled_keys,
> +	&simpad_mq200fb,
> +	&simpad_i2c,
>  };
>  
>  

-- 
With best wishes
Dmitry
