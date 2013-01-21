From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 21 Jan 2013 10:37:06 +0000
Subject: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <87ip6vlwaf.fsf@dell.be.48ers.dk>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 <87ip6vlwaf.fsf@dell.be.48ers.dk>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECF118E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Jan 17, 2013 at 19:57:20, Peter Korsgaard wrote:
> >>>>> "V" == Vaibhav Bedia <vaibhav.bedia@ti.com> writes:
> 
> Hi,
> 
>  V> +static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
>  V> +{
>  V> +	struct wkup_m3_context *wkup_m3_context = context;
>  V> +	struct platform_device *pdev = to_platform_device(wkup_m3_context->dev);
>  V> +	int ret = 0;
>  V> +
>  V> +	/* no firmware found */
>  V> +	if (!fw) {
>  V> +		dev_err(wkup_m3_context->dev, "request_firmware failed\n");
>  V> +		goto err;
>  V> +	}
>  V> +
>  V> +	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);
> 
> A size check would be good. I don't know much about the finer details
> about the m3 and how it is connected, but don't you need to ensure data
> is flushed before resetting the m3?
> 

Will add the reg property in the next version. The wkup-m3 memory is coming via
ioremap() so AFAIK it should be ok. I realized that I do need to replace the memcpy()
with memcpy_toio() here.

Thanks,
Vaibhav
