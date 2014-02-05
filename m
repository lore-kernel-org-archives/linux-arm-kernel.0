From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 05 Feb 2014 11:41:03 +0100
Subject: [PATCH 05/18] mfd: max14577: Use of_match_ptr() in i2c_driver
In-Reply-To: <20140203093013.GG13529@lee--X1>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-6-git-send-email-k.kozlowski@samsung.com>
 <20140203093013.GG13529@lee--X1>
Message-ID: <1391596863.3726.6.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-03 at 09:30 +0000, Lee Jones wrote:
> > Use of_match_ptr() in assignment of i2c_driver.of_match_table.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/mfd/max14577.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> > index 2ac2f2d7cea6..75b37082a3fe 100644
> > --- a/drivers/mfd/max14577.c
> > +++ b/drivers/mfd/max14577.c
> > @@ -224,7 +224,7 @@ static struct i2c_driver max14577_i2c_driver = {
> >  		.name = "max14577",
> >  		.owner = THIS_MODULE,
> >  		.pm = &max14577_pm,
> > -		.of_match_table = max14577_dt_match,
> > +		.of_match_table = of_match_ptr(max14577_dt_match),
> 
> Are you sure this is required?

No, it was my mistake. Please ignore this patch.

Krzysztof
