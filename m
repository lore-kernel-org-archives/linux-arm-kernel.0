From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 3 Mar 2018 15:09:39 +0000
Subject: [PATCH 5/7] iio: adc: stm32-dfsdm: misc style improvements and
 fixes
In-Reply-To: <62c19775-b013-a721-6f14-a8af88984b4b@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
 <1519390261-25453-6-git-send-email-fabrice.gasnier@st.com>
 <20180224130309.7129e79f@archlinux>
 <62c19775-b013-a721-6f14-a8af88984b4b@st.com>
Message-ID: <20180303150939.34f4bed4@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Feb 2018 09:21:00 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 02/24/2018 02:03 PM, Jonathan Cameron wrote:
> > On Fri, 23 Feb 2018 13:50:59 +0100
> > Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >   
> >> Misc fixes & style improvements:
> >> - checkpatch warns about line over 80 characters.
> >> - remove extra spaces and a blank line (e.g. checkpatch --strict)
> >> - remove bad error message always printed in probe routine.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
> > I'd have preferred this as 3 patches doing one type fo fix each.  
> 
> Hi Jonathan,
> 
> I was wondering about this as well. Do you wish I send a new series with
> this patch, split into (3 or maybe 4) separate patches ?
> 
> In this case, do I need also resend two last patches of this series ?
It's probably not worth respining given just how small this is so
don't worry about it.

Jonathan

> 
> Please let me know.
> Many thanks,
> Fabrice
> > 
> > Anyhow, I'll need to hold this until the fixes have made there
> > way upstream.  Give me a poke if I seem to have forgotten
> > and the dependencies have made it back to my togreg branch.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >>  drivers/iio/adc/stm32-dfsdm-adc.c | 9 ++++-----
> >>  1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> >> index 01422d1..57bcb45 100644
> >> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> >> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> >> @@ -253,7 +253,8 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
> >>  				  DFSDM_CR1_RSWSTART(1));
> >>  }
> >>  
> >> -static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
> >> +static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
> >> +				    unsigned int fl_id)
> >>  {
> >>  	/* Disable conversion */
> >>  	regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
> >> @@ -337,7 +338,7 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
> >>  					    "st,adc-channel-types", chan_idx,
> >>  					    &of_str);
> >>  	if (!ret) {
> >> -		val  = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
> >> +		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_type);
> >>  		if (val < 0)
> >>  			return val;
> >>  	} else {
> >> @@ -349,7 +350,7 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
> >>  					    "st,adc-channel-clk-src", chan_idx,
> >>  					    &of_str);
> >>  	if (!ret) {
> >> -		val  = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
> >> +		val = stm32_dfsdm_str2val(of_str, stm32_dfsdm_chan_src);
> >>  		if (val < 0)
> >>  			return val;
> >>  	} else {
> >> @@ -1093,7 +1094,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
> >>  	char *name;
> >>  	int ret, irq, val;
> >>  
> >> -
> >>  	dev_data = of_device_get_match_data(dev);
> >>  	iio = devm_iio_device_alloc(dev, sizeof(*adc));
> >>  	if (!iio) {
> >> @@ -1161,7 +1161,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
> >>  	if (ret < 0)
> >>  		goto err_cleanup;
> >>  
> >> -	dev_err(dev, "of_platform_populate\n");
> >>  	if (dev_data->type == DFSDM_AUDIO) {
> >>  		ret = of_platform_populate(np, NULL, NULL, dev);
> >>  		if (ret < 0) {  
> >   
