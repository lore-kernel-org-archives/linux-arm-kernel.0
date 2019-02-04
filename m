Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F2CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:17:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404B3217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GPkkGiay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404B3217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=abatec.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=72uWws98UZvavJ/RJxU3JaxB7xuwkZ4tGtPpqCELRsU=; b=GPkkGiayEZ3/Ui
	WvzwcZNc/9vFspZm2GPlv2CrW76EzHZ4rjC1AhUfoS+3mwrfggcGFq4gIB4+pz1F3/j25fyiUdwDf
	o1cf/qaZHRTy+qGbTjHMXt2gWZk8ge8JMCIAt7M2fD5I8YMnIfjTiuf4lTSbTSu7URSu7aDZpKk/0
	+BboLRr8qoMZz91VKK0K0EIpSMvzxyX1ygx8TvmqD4aRVTA7DlyPMc0UMEM2IEaLi9nwFqLdh6TL1
	Eja1eVKnc11BM+EOR9WqP2qGGOQV3v2vdimGgGOii0PfjeNgeCOFDv0Z++Nfb0w1SAG9Fvh32hUaw
	pmGNfzKU9BFN05ynP+pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqYVI-0007jl-Aj; Mon, 04 Feb 2019 07:17:16 +0000
Received: from mail1.abatec.at ([81.10.186.19])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqYVD-0007gx-EH
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 07:17:14 +0000
Received: from exchange02.regau.abatec.at (192.168.100.22) by
 exchange02.regau.abatec.at (192.168.100.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 4 Feb 2019 08:17:07 +0100
Received: from exchange02.regau.abatec.at ([::1]) by
 exchange02.regau.abatec.at ([::1]) with mapi id 15.01.1415.002; Mon, 4 Feb
 2019 08:17:07 +0100
From: Georg Ottinger <g.ottinger@abatec.at>
To: Jonathan Cameron <jic23@kernel.org>
Subject: AW: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Thread-Topic: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Thread-Index: AQHUuKGafWrpkxg4ckeOny6mkh/hBaXMP+cAgAMB7lA=
Date: Mon, 4 Feb 2019 07:17:07 +0000
Message-ID: <0974ce54b3da4d82b6bd3026a3de5ff3@abatec.at>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
 <20190202102021.12bb0a72@archlinux>
In-Reply-To: <20190202102021.12bb0a72@archlinux>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.115.56]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_231711_662595_EB72C8AC 
X-CRM114-Status: GOOD (  19.47  )
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
Cc: Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>, Stefan
 Etzlstorfer <s.etzlstorfer@abatec.at>, "David S. Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Actually this issue occurred to us with an concrete product, where we exper=
ienced a system hang at -20 =B0C.
It was triggered by a race condition between the Touch Trigger and the Chan=
nel Trigger of the ADC. Once triggered we got in to the situation where an =
ongoing Channel Conversion was lost (Timeout case).When we queried a second=
 channel than we got a system hang. Investigating this issue we developed a=
n error demonstrator - reading alternating two channels as fast as possible=
 (when Touch is enabled). This also provokes this issue at room temperature.

For the error demonstrator use following commandline to compile:

$ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o adc_d=
emo_error2

-------------
// adc_demo_error.c
#include <unistd.h>
#include <fcntl.h>

#define VLEN 10

int main()
{
  int fd_adc,fd_adc2;
  int ret;
  char dummy[VLEN];
  =

  fd_adc =3D open ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:devi=
ce0/in_voltage4_raw",O_RDONLY);  =

#ifdef 2ND_CHANNEL
  fd_adc2 =3D open ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:dev=
ice0/in_voltage5_raw",O_RDONLY);
#endif

  while(1) {

    lseek(fd_adc, 0, SEEK_SET);
    ret =3D read(fd_adc, dummy, VLEN);
#ifdef 2ND_CHANNEL
    lseek(fd_adc2, 0, SEEK_SET);
    ret =3D read(fd_adc2, dummy, VLEN);
#endif

  }
}

------------


Greeting, Georg

-----Urspr=FCngliche Nachricht-----
Von: Jonathan Cameron [mailto:jic23@kernel.org] =

Gesendet: Samstag, 02. Februar 2019 11:21
An: Georg Ottinger <g.ottinger@abatec.at>
Cc: eugen.hristev@microchip.com; Stefan Etzlstorfer <s.etzlstorfer@abatec.a=
t>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;=
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Nicolas Ferre <nicolas.ferre@m=
icrochip.com>; Alexandre Belloni <alexandre.belloni@bootlin.com>; Ludovic D=
esroches <ludovic.desroches@microchip.com>; David S. Miller <davem@davemlof=
t.net>; Ard Biesheuvel <ard.biesheuvel@linaro.org>; Kees Cook <keescook@chr=
omium.org>; linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org=
; linux-kernel@vger.kernel.org; Maxime Ripard <maxime.ripard@bootlin.com>
Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in timeo=
ut case

On Wed, 30 Jan 2019 14:42:02 +0100
<g.ottinger@abatec.at> wrote:

> From: Georg Ottinger <g.ottinger@abatec.at>
> =

> Having a brief look at at91_adc_read_raw() it is obvious that in the =

> case of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR =

> registers is omitted. If 2 different channels are queried we can end =

> up with a situation where two interrupts are enabled, but only one =

> interrupt is cleared in the interrupt handler. Resulting in a =

> interrupt loop and a system hang.
> =

> Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>

Whilst I agree this looks like a correct change, I would like Maxime to tak=
e a look as he is obviously much more familiar with the driver than I am.

I suspect you can only actually get there in the event of a hardware failur=
e as that isn't actually a timeout you should ever see.
Could be wrong though!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> =

> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c =

> index 75d2f7358..596841a3c 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  		ret =3D wait_event_interruptible_timeout(st->wq_data_avail,
>  						       st->done,
>  						       msecs_to_jiffies(1000));
> -		if (ret =3D=3D 0)
> -			ret =3D -ETIMEDOUT;
> -		if (ret < 0) {
> -			mutex_unlock(&st->lock);
> -			return ret;
> -		}
> -
> -		*val =3D st->last_value;
>  =

> +		/* Disable interrupts, regardless if adc conversion was
> +		 * successful or not
> +		 */
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
>  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>  =

> -		st->last_value =3D 0;
> -		st->done =3D false;
> +		if (ret > 0) {
> +			/* a valid conversion took place */
> +			*val =3D st->last_value;
> +			st->last_value =3D 0;
> +			st->done =3D false;
> +			ret =3D IIO_VAL_INT;
> +		} else if (ret =3D=3D 0) {
> +			/* conversion timeout */
> +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> +				chan->channel);
> +			ret =3D -ETIMEDOUT;
> +		}
> +
>  		mutex_unlock(&st->lock);
> -		return IIO_VAL_INT;
> +		return ret;
>  =

>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D st->vref_mv;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
