From: dawei.chien@mediatek.com (Dawei Chien)
Date: Mon, 13 Feb 2017 17:01:58 +0800
Subject: [PATCH] thermal: mt8173: minor mtk_thermal.c cleanups
In-Reply-To: <ebdf54af-6290-9654-c475-53dd580582a0@gmail.com>
References: <1486531862-31945-1-git-send-email-dawei.chien@mediatek.com>
 <ebdf54af-6290-9654-c475-53dd580582a0@gmail.com>
Message-ID: <1486976518.24087.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Matthias,

On Thu, 2017-02-09 at 22:25 +0100, Matthias Brugger wrote:
> 
> On 02/08/2017 06:31 AM, Dawei Chien wrote:
> > Thermal driver should read TEMP_MSR3 if thermal bank with 4 sensors.
> > However, Currently thermal driver don't need read TEMP_MSR3 since
> > thermal controller only use 3 sensors for each thermal bank.
> >
> > Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > ---
> 
> Actually the commit message should state:
> Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
> 
> ...and get backported to v4.9 and v4.10.
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Regards,
> Matthias

Thank you for your review. I would add below commit message on next
version. However, currently 8173 thermal driver would not read TEMP_MSR3
since thermal driver only use 3 sensors on each bank, this patch would
not effect temperature.
Only if thermal driver use 4 sensors on any thermal bank, would read
third sensor two times, and lose fourth sensor of vale.
Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")

> >  drivers/thermal/mtk_thermal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 34169c3..c124151 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -191,7 +191,7 @@ struct mtk_thermal {
> >  };
> >
> >  const int mt8173_msr[MT8173_NUM_SENSORS_PER_ZONE] = {
> > -	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR2
> > +	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR3
> >  };
> >
> >  const int mt8173_adcpnp[MT8173_NUM_SENSORS_PER_ZONE] = {
> >
