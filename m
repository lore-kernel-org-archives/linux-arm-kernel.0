From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 14 Mar 2014 13:23:55 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2N11bIDMvNV0gdmlkZW86IG14M2ZiOiBJbnRyb2R1Y2Ug?=
 =?UTF-8?B?cmVndWxhdG9yIHN1cHBvcnQu?=
In-Reply-To: <1394788369-5096-3-git-send-email-denis@eukrea.com>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
Message-ID: <1394789035.649593084@f301.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 14 ????? 2014, 10:12 +01:00 ?? Denis Carikli <denis@eukrea.com>:
> This commit is based on the following commit by Fabio Estevam:
>   4344429 video: mxsfb: Introduce regulator support
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
...
> +	if (np) {
> +		if (regulator_name)
> +			mx3fbi->reg_lcd = regulator_get(NULL, regulator_name);
> +
> +		if (IS_ERR(mx3fbi->reg_lcd))
> +			return PTR_ERR(mx3fbi->reg_lcd);
> +	} else {
> +		/* Permit that driver without a regulator in non-dt mode */
> +		mx3fbi->reg_lcd = regulator_get(dev, "lcd");
> +	}

I am still completely do not understand why do you need to have
"regulator_name" property?
Why this cannot be devm_regulator_get(dev, "lcd") in both DT and non-DT case?

---
