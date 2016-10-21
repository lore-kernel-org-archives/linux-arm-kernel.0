From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Oct 2016 09:11:28 +0200
Subject: [PATCH -next] pwm: meson: Fix missing spin_lock_init()
In-Reply-To: <57D41083.3060109@baylibre.com>
References: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
 <57D41083.3060109@baylibre.com>
Message-ID: <20161021071128.GA2670@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2016 at 03:54:11PM +0200, Neil Armstrong wrote:
> Le 10/09/2016 08:38, Wei Yongjun a ?crit :
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > The driver allocates the spinlock but not initialize it.
> > Use spin_lock_init() on it to initialize it correctly.
> > 
> > This is detected by Coccinelle semantic patch.
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/pwm/pwm-meson.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index bfbbe7f..778d088 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -465,6 +465,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
> >  	if (IS_ERR(meson->base))
> >  		return PTR_ERR(meson->base);
> >  
> > +	spin_lock_init(&meson->lock);
> >  	meson->chip.dev = &pdev->dev;
> >  	meson->chip.ops = &meson_pwm_ops;
> >  	meson->chip.base = -1;
> > 
> 
> Thanks for the fix, but it was already posted earlier by Axel Lin <axel.lin@ingics.com>
> 
> Thierry will decide which one to merge.
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I've applied Axel's patch.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161021/c8c0227d/attachment.sig>
