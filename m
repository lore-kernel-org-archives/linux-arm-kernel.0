From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 5 Apr 2013 18:32:23 +0200
Subject: [PATCH v10 03/12] mfd: palmas add variant and OTP detection
In-Reply-To: <1363964122-19201-4-git-send-email-ian@slimlogic.co.uk>
References: <1363964122-19201-1-git-send-email-ian@slimlogic.co.uk>
 <1363964122-19201-4-git-send-email-ian@slimlogic.co.uk>
Message-ID: <20130405163223.GO17363@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Fri, Mar 22, 2013 at 02:55:13PM +0000, Ian Lartey wrote:
> @@ -278,20 +329,20 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
>  	int ret;
>  	u32 prop;
>  
> -	ret = of_property_read_u32(node, "ti,mux_pad1", &prop);
> +	ret = of_property_read_u32(node, "ti,mux-pad1", &prop);
>  	if (!ret) {
>  		pdata->mux_from_pdata = 1;
>  		pdata->pad1 = prop;
>  	}
>  
> -	ret = of_property_read_u32(node, "ti,mux_pad2", &prop);
> +	ret = of_property_read_u32(node, "ti,mux-pad2", &prop);
>  	if (!ret) {
>  		pdata->mux_from_pdata = 1;
>  		pdata->pad2 = prop;
>  	}
>  
>  	/* The default for this register is all masked */
> -	ret = of_property_read_u32(node, "ti,power_ctrl", &prop);
> +	ret = of_property_read_u32(node, "ti,power-ctrl", &prop);
>  	if (!ret)
>  		pdata->power_ctrl = prop;
>  	else
> @@ -309,7 +360,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	struct palmas_platform_data *pdata;
>  	struct device_node *node = i2c->dev.of_node;
>  	int ret = 0, i;
> -	unsigned int reg, addr;
> +	unsigned int reg;
>  	int slave;
>  	struct mfd_cell *children;
The '-' to '_' fix has been sent by J Keerthy and is on my mfd-next tree
aready. Would you mind removing it from this patch ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
