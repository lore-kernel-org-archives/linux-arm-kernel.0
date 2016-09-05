From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:33:01 +0200
Subject: [PATCH v4 07/17] pwm: sti: Rename channel => device
In-Reply-To: <20160816093508.28307-8-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-8-lee.jones@linaro.org>
Message-ID: <20160905103301.GG31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:34:58AM +0100, Lee Jones wrote:
> This is to bring the terminology used in the STi PWM driver more
> into line with the PWM subsystem.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Note that it's fine if drivers use different terminology for internals.
Many manuals seem to be using the channel terminology and many drivers
use that. But if you prefer devices that's fine with me.

I've applied this with a minor change, see below.

> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> -	of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
> -	if (num_chan)
> -		cdata->num_chan = num_chan;
> +	of_property_read_u32(np, "st,pwm-num-chans", &num_devs);
> +	if (num_devs)
> +		cdata->num_devs = num_devs;

I kept the "st,pwm-num-chan" as property name here to avoid breaking
backwards compatiblity. This series changes it back to "st,pwm-num-chan"
sometime later in this series anyway.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/ad659acd/attachment.sig>
