From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 9 Nov 2017 10:05:14 +0000
Subject: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with
 DT bindings
In-Reply-To: <20171109004604.vkrpyrxbogx7r4td@xps13.dannf>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
 <20171109004604.vkrpyrxbogx7r4td@xps13.dannf>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC7ED0@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Dann

[...]

> > +
> > +#define START_WORK		0x01
> 
> Any reason not to put this in the LPC_ namespace as well?

No, not really. We'll make it consistent in the next patchset 

> 
> > +/* The minimal nanosecond interval for each query on LPC cycle
> status. */

[...]

> > + * hisilpc_target_in - trigger a series of lpc cycles to read
> required data
> > + *		       from target peripheral.
> > + * @pdev: pointer to hisi lpc device
> 
> It's now lpcdev
> 

Thanks, we'll change it.

> > + * @para: some parameters used to control the lpc I/O operations

[...]

> > + * @pio: the target I/O port address.
> 
> @outval & @pio are in the opposite order of the actual function

Thanks, we'll change it.

> 

[...]

> > +		lpcdev->io_host->devpara = NULL;
> > +		dev_err(dev, "OF: scan hisilpc children got failed(%d)\n",
> > +			ret);
> 
> nit: Maybe "OF: scanning hisilpc children failed(%d)" ?
> 

Yes, thanks we'll change it.

> > +		return ret;
> > +	}
> > +
> > +	dev_info(dev, "hslpc end probing. range[%pa - sz:%pa]\n",
> > +		&lpcdev->io_host->io_start,
> > +		&lpcdev->io_host->size);
> > +
> > +	return ret;
> > +}
> 
> 
>  -dann
