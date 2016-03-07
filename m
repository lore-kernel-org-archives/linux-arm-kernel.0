From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Mar 2016 21:10:16 +0100
Subject: [PATCH 0/3] video: fbdev: imxfb: make it work again
In-Reply-To: <CAOMZO5BxrVHNq8BdOqAqkaOqC905+AOSkFtsrWFHbz4cfN=Kaw@mail.gmail.com>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOMZO5BxrVHNq8BdOqAqkaOqC905+AOSkFtsrWFHbz4cfN=Kaw@mail.gmail.com>
Message-ID: <20160307201016.GB31868@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 05:03:53PM -0300, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Mon, Mar 7, 2016 at 4:53 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello,
> >
> > it seems the imxfb driver stopped working quite some time ago. Here come
> 
> Yes, I noticed it has been broken for a long time.
> 
> After this fix I managed to get it working again:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/video/fbdev/imxfb.c?id=b82fe6ddd782f847332aeabf8cab980852f61629

I missed this one, but it works for me also without this patch (maybe
because my bootloader is aware of the display?).

My problem was that the handling for the optional regulator was
wrong/nonexistent. imx25-pdk.dts doesn't use it and so doesn't suffer
the corresponding problems.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
