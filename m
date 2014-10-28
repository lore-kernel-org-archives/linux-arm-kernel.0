From: brian.austin@cirrus.com (Brian Austin)
Date: Tue, 28 Oct 2014 15:09:33 -0500
Subject: [PATCH 1/6] ASoC: cs42l51: re-add of_match_table pointer
In-Reply-To: <1414512524-24466-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1410281502200.28816@heelrod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Oct 2014, Thomas Petazzoni wrote:

>  #include "cs42l51.h"
>  
> +static const struct of_device_id cs42l51_of_match[] = {
> +	{ .compatible = "cirrus,cs42l51", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs42l51_of_match);
> +

Can't this be exported in the codec driver instead of removed?
It seems like it would be duplication for a multi-bus codec to have 
to add it in the bus driver.
For example if/when we add SPI this would have to be duplicated there as 
well right?  And then if we have I2C/SPI/Slimbus/Wireless/etc we would 
have this in all those files.

I believe that is how the cs42xx8 is handled. I will have to check.

Thanks,
Brian
