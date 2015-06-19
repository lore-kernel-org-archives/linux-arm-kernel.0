From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 19 Jun 2015 09:34:33 +0200
Subject: [PATCH v2 2/2] mfd: flexcom: add a driver for Atmel Flexible
 Serial Communication Unit
In-Reply-To: <bc25d9365ba31f987437ff4f0f2ee60c19639270.1434632230.git.cyrille.pitchen@atmel.com>
References: <cover.1434632230.git.cyrille.pitchen@atmel.com>
 <bc25d9365ba31f987437ff4f0f2ee60c19639270.1434632230.git.cyrille.pitchen@atmel.com>
Message-ID: <1434699273.2385.139.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-18 at 15:05 +0200, Cyrille Pitchen wrote:
> --- /dev/null
> +++ b/drivers/mfd/atmel-flexcom.c

> +MODULE_ALIAS("platform:atmel_flexcom");

(The day before yesterday and yesterday I had a, well, lively
conversation regarding this macro. The interesting bits start at
https://lkml.org/lkml/2015/6/17/383 . Let's see how things go here.)

As I understand it, this alias is only useful if there's a corresponding
struct platform_device, somewhere. Ie, this alias implies a
platform_device that will fire of a "MODALIAS=platform:atmel_flexcom"
uevent when it's created. That would be a platform_device using a
"atmel_flexcom" name.

If that's correct, then I think this MODULE_ALIAS macro isn't needed
here, as I couldn't find a platform_device using that name. (But perhaps
a patch that adds it is pending, somewhere.)

Thanks,


Paul Bolle
