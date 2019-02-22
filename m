Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF42C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEC42086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i8TH6a2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEC42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t9XnDGKBkOb2B/zK+m4aTtVXDBnZHkr1ItQsyWPrig4=; b=i8TH6a2aP87XBR
	nN9/pMdAAG4MlcA2J4QHHw+sW7JuC26gkHBS+aQQ4pzsRE1vPFO+jGCz6CEdYyFL1hUQ/Na1vAUYP
	iojloHD8MtXOnsHabCuCgRJvR1bpttIAVrfw3+nqC3XXFXX97eFUsjStCdTX9x9Ac712SFvQ20+Le
	p7iPSQALPUxLpGViL0hWJkYovIqXwEW6sOmqX1c3OtWePQSmQzbyEbhh4Td7lqGzas4NVDLXBYl2t
	NpBTcU4+y4ukbM/XHebzmDNYpwm+Fah7rKem0SC826Mvtl504pyUPBZBoGDEi9FA0UQTlD8FeATjs
	7LFcAxC+bE46DJnmnb7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7a6-0002Q4-PG; Fri, 22 Feb 2019 09:57:22 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7a2-0002PU-Dn
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:57:20 +0000
X-IronPort-AV: E=Sophos;i="5.58,399,1544511600"; d="scan'208";a="26982101"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 22 Feb 2019 02:57:16 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Fri, 22 Feb 2019
 02:57:15 -0700
Date: Fri, 22 Feb 2019 10:56:56 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <g.ottinger@abatec.at>
Subject: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Message-ID: <20190222095656.gl3j46tqtlinhfbr@M43218.corp.atmel.com>
Mail-Followup-To: g.ottinger@abatec.at,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>, eugen.hristev@microchip.com,
 s.etzlstorfer@abatec.at, "David S. Miller" <davem@davemloft.net>,
 Jonathan Cameron <jic23@kernel.org>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130134202.5831-1-g.ottinger@abatec.at>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_015718_501116_BB19A120 
X-CRM114-Status: GOOD (  18.94  )
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
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 eugen.hristev@microchip.com, s.etzlstorfer@abatec.at,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 02:42:02PM +0100, g.ottinger@abatec.at wrote:
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
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

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
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
