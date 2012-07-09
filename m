From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 09 Jul 2012 10:29:53 +0200
Subject: [PATCH 2/3] media: coda: Add driver for Coda video codec.
In-Reply-To: <CACKLOr0UrZ2bi01L+xub7ARwfnoN7kriGpwWfwWzx-MYgS-H8w@mail.gmail.com>
References: <1341579471-25208-1-git-send-email-javier.martin@vista-silicon.com>
 <1341579471-25208-3-git-send-email-javier.martin@vista-silicon.com>
 <1341816350.2489.1.camel@pizza.hi.pengutronix.de>
 <CACKLOr0UrZ2bi01L+xub7ARwfnoN7kriGpwWfwWzx-MYgS-H8w@mail.gmail.com>
Message-ID: <1341822593.2489.26.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 09.07.2012, 10:14 +0200 schrieb javier Martin:
[...]
> >> +enum coda_platform {
> >> +     CODA_INVALID = 0,
> >
> > I don't think CODA_INVALID is useful.
> 
> It is, otherwise the following will fail since CODA_IMX27 is 0:
> 
> 	if (of_id)
> 		dev->devtype = of_id->data;
> 	else if (pdev_id && pdev_id->driver_data)  <-----
> pdev_id->driver_data = CODA_IMX27 = 0
> 		dev->devtype = &coda_devdata[pdev_id->driver_data];
> 	else
> 		return -EINVAL;

Oh, right. I think it should be ok to just remove the
pdev_id->driver_data check.
Since it's all in the same source file, it's unlikely that somebody adds
a platform_device_id to coda_platform_ids array but forgets to set
the .driver_data field.

regards
Philipp
