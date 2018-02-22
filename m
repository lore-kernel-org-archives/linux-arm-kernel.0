From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 22 Feb 2018 14:14:18 +0900
Subject: [PATCH] PM / devfreq: exynos-ppmu: Delete an error message
 for a failed memory allocation in exynos_ppmu_probe()
In-Reply-To: <5A8364F8.8050801@samsung.com>
References: <5A8364F8.8050801@samsung.com>
 <e4d3a870-f420-5a06-1665-59152c1924a3@users.sourceforge.net>
 <CGME20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78@epcms1p5>
Message-ID: <20180222051418epcms1p515085d1b1fabaf50983ff2ecb3442c02@epcms1p5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 2018? 02? 14? 06:17, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 13 Feb 2018 22:10:42 +0100
> > 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/devfreq/event/exynos-ppmu.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> > index d96e3dc71cf8..72ac9113500d 100644
> > --- a/drivers/devfreq/event/exynos-ppmu.c
> > +++ b/drivers/devfreq/event/exynos-ppmu.c
> > @@ -627,11 +627,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
> >  
> >  	size = sizeof(struct devfreq_event_dev *) * info->num_events;
> >  	info->edev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> > -	if (!info->edev) {
> > -		dev_err(&pdev->dev,
> > -			"failed to allocate memory devfreq-event devices\n");
> > +	if (!info->edev)
> >  		return -ENOMEM;
> > -	}
> > +
> >  	edev = info->edev;
> >  	platform_set_drvdata(pdev, info);
> >  
> > 
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
