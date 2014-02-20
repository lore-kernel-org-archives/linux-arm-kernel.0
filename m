From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Feb 2014 21:51:30 +0900
Subject: [PATCH v2 2/2] regulator: core: Replace direct ops->disable usage
In-Reply-To: <1392894472-11956-3-git-send-email-mpa@pengutronix.de>
References: <1392894472-11956-1-git-send-email-mpa@pengutronix.de>
 <1392894472-11956-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20140220125130.GQ2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 12:07:52PM +0100, Markus Pargmann wrote:

> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1908,8 +1908,6 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
>  
>  	trace_regulator_disable_complete(rdev_get_name(rdev));
>  
> -	_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> -			     NULL);
>  	return 0;
>  }
>  
> @@ -1933,6 +1931,8 @@ static int _regulator_disable(struct regulator_dev *rdev)
>  				rdev_err(rdev, "failed to disable\n");
>  				return ret;
>  			}
> +			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> +					NULL);
>  		}
>  
>  		rdev->use_count = 0;

This change doesn't seem obviously related?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/8f0705dc/attachment-0001.sig>
