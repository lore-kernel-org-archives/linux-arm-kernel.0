From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 18 Jan 2011 16:54:58 +0900
Subject: [PATCH v4] dw_mmc: Add Synopsys DesignWare mmc host driver.
In-Reply-To: <AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTik7cMwgwXR1zK44HXC+1YtzpU3_zW2GUjcBMi8X@mail.gmail.com>
Message-ID: <4D354752.3030401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will.

I have some question...i'm testing dw_mmc in our environment.
but i didn't understand pdata->init(?)...what initialize in there?

plz let me know that..

Thanks
Jaehoon Chung

Will Newton wrote:

> +	host->pdev = pdev;
> +	host->pdata = pdata = pdev->dev.platform_data;
> +	if (!pdata || !pdata->init) {
> +		dev_err(&pdev->dev,
> +			"Platform data must supply init function\n");
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +
> +	if (!pdata->select_slot && pdata->num_slots > 1) {
> +		dev_err(&pdev->dev,
> +			"Platform data must supply select_slot function\n");
> +		ret = -ENODEV;
> +		goto err_freehost;
> +	}
> +
>
