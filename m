Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8045BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50931217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lmcjmqh+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2bZLGxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50931217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ROjVcVDqMChM16asDSWUSMy0jB9XL3rHLV1U4Ltalrk=; b=Lmcjmqh+E5OMQR
	nRVVfeAglmbmS0rqGwZw5HXyuQbGJ9HMSC/1pAbn3zXxA1maqZHHvYxNJes6eehItIf0Krlxkqg/O
	A7IjC0UmLN+hLQfsjvJ1vhFnW1Uw8vWPEs5AoUXxnDHRPZWKtJOyMQ1d6mhABKOUhdbphORij13Yh
	IFl2thsMEIIlrdAwicErjCYRHDkohFi+MVN2GaLe0LoIcp/UcIE+VxyvteY2cTjX1w/kAeGBh5lBY
	0lhfaFSzAsSPRafpj2wnI+hZtvTtroSqktxDsDWPlihftBop3SF5Cmq3R/OakwhBkKOI6xX0dFLjY
	Kf7p+Mf6KFL+iF2UTMvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpsQ0-00073i-HP; Sat, 02 Feb 2019 10:21:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpsPw-00073M-HK
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 10:20:58 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B247020870;
 Sat,  2 Feb 2019 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549102855;
 bh=+fdH/w2zAugmHdwEMMQcXoW9UFPDCuiV2igdmI2iw1I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=i2bZLGxzujncRYN/k8bXege1x2mJt3q3jmNUPvLeKJc6HDt+ixFcXRK1iouTUsjZE
 H4JcxMZMFuSjj/da+1GyIWu8+6qtY7QkABU+rToJefd5jmUkKvpm6IUMQduWFeJXkN
 co9qcgROXoXKQljTiJtyNSKa2zSTzJ7SzRjw+ISM=
Date: Sat, 2 Feb 2019 10:20:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <g.ottinger@abatec.at>
Subject: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in
 timeout case
Message-ID: <20190202102021.12bb0a72@archlinux>
In-Reply-To: <20190130134202.5831-1-g.ottinger@abatec.at>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_022056_612280_E65241F0 
X-CRM114-Status: GOOD (  20.90  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 eugen.hristev@microchip.com, s.etzlstorfer@abatec.at,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 14:42:02 +0100
<g.ottinger@abatec.at> wrote:

> From: Georg Ottinger <g.ottinger@abatec.at>
> 
> Having a brief look at at91_adc_read_raw() it is obvious that in the case
> of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is
> omitted. If 2 different channels are queried we can end up with a
> situation where two interrupts are enabled, but only one interrupt is
> cleared in the interrupt handler. Resulting in a interrupt loop and a
> system hang.
> 
> Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>

Whilst I agree this looks like a correct change, I would like Maxime
to take a look as he is obviously much more familiar with the driver
than I am.

I suspect you can only actually get there in the event of a hardware
failure as that isn't actually a timeout you should ever see.
Could be wrong though!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 75d2f7358..596841a3c 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
>  						       st->done,
>  						       msecs_to_jiffies(1000));
> -		if (ret == 0)
> -			ret = -ETIMEDOUT;
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> -		}
> -
> -		*val = st->last_value;
>  
> +		/* Disable interrupts, regardless if adc conversion was
> +		 * successful or not
> +		 */
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
>  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>  
> -		st->last_value = 0;
> -		st->done = false;
> +		if (ret > 0) {
> +			/* a valid conversion took place */
> +			*val = st->last_value;
> +			st->last_value = 0;
> +			st->done = false;
> +			ret = IIO_VAL_INT;
> +		} else if (ret == 0) {
> +			/* conversion timeout */
> +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> +				chan->channel);
> +			ret = -ETIMEDOUT;
> +		}
> +
>  		mutex_unlock(&st->lock);
> -		return IIO_VAL_INT;
> +		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_mv;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
