Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D045C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59F02082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t76LKiFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59F02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=abatec.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uC0ZcPKWO6AG2sA/m2Uq5T+M4a9WPt/0eRMbZ3Mltj8=; b=t76LKiFAPo631L
	xtx51xsUHFPPmjeHB8v7Hdnp6a5gA8ToU5nYTOvY2oyHqPNWRHAl34mwHzpj1khs8PMSrsUekKMpF
	Vj+svjChyAORwBkyg8pLJEZ4nh3j3nInOn+7LKsTPxFHnEspNxSu989xcI/QaqFRBfe7ICO8OeIL5
	rrfTiLTxV9Gf9IdTDmBRiOsleEm6IqOe81nnU+GRecwowLuoGzxmN5o3+gMoYNZQHmsDRPPrlbdam
	0MGvTEuzvIgTYlrsbC51snlPdO2PT3QRHGwnIe5DPA8nd6pW9VDuhzWr6EWvz+uAYAVQfQHIB6UIF
	F7meMH0Yl02cLm95OjXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqc83-000821-Jk; Mon, 04 Feb 2019 11:09:31 +0000
Received: from mail1.abatec.at ([81.10.186.19])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqc7y-00081J-Vd
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:09:29 +0000
Received: from exchange02.regau.abatec.at (192.168.100.22) by
 exchange02.regau.abatec.at (192.168.100.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 4 Feb 2019 12:09:25 +0100
Received: from exchange02.regau.abatec.at ([::1]) by
 exchange02.regau.abatec.at ([::1]) with mapi id 15.01.1415.002; Mon, 4 Feb
 2019 12:09:25 +0100
From: Georg Ottinger <g.ottinger@abatec.at>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: AW: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Thread-Topic: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Thread-Index: AQHUuKGafWrpkxg4ckeOny6mkh/hBaXMP+cAgAMB7lCAABjqAIAAJ52w
Date: Mon, 4 Feb 2019 11:09:25 +0000
Message-ID: <28fa70e41bad4a9f814683c078e89a12@abatec.at>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
 <20190202102021.12bb0a72@archlinux>
 <0974ce54b3da4d82b6bd3026a3de5ff3@abatec.at>
 <20190204094540.00003072@huawei.com>
In-Reply-To: <20190204094540.00003072@huawei.com>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.115.56]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_030927_365509_E7873AE7 
X-CRM114-Status: GOOD (  27.96  )
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
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
 Stefan Etzlstorfer <s.etzlstorfer@abatec.at>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following is the patch that we are using internally to workaround the i=
ssues - I first wanted to publish the timeout/systemhang patch, because I d=
on't have the feeling that our workaround is suitable to be mainlined:

----
static int at91_adc_read_raw(struct iio_dev *idev,
			     struct iio_chan_spec const *chan,
			     int *val, int *val2, long mask)
{
	struct at91_adc_state *st =3D iio_priv(idev);
	const int retry_timeouts[ADC_READ_RAW_RETRIES] =3D {200,300,500}; /* split=
 1 second timeout into retry intervals 200ms, 300ms, 500ms */
	int retries;
	int ret;

	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		mutex_lock(&st->lock);

		st->chnb =3D chan->channel;
		at91_adc_writel(st, AT91_ADC_CHER,
				AT91_ADC_CH(chan->channel));
		at91_adc_writel(st, AT91_ADC_IER, BIT(chan->channel));
		=

		retries =3D 0;
		do {
			/* In some situations with high NOPEN/PEN Interrupt load, a started ADC =
conversion
                           might get smashed by the periodic trigger enable=
/disable procedure. As a workaround
                           we are allowing the at91_adc_read_raw() function=
 to restart the ADC conversion. */
	=

			at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_START);
			ret =3D wait_event_interruptible_timeout(st->wq_data_avail,
							       st->done,
							       msecs_to_jiffies(retry_timeouts[retries]));

		} while ((++retries < ADC_READ_RAW_RETRIES) && (ret <=3D 0));


		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
		at91_adc_writel(st, AT91_ADC_CHDR,
				AT91_ADC_CH(chan->channel));
		=

		/* if touch is enabled (TSMODE) a delay time between channel disable and =
channel enable is needed =

		otherwise the following conversion will fail. This time needs to be aroun=
d 42 ADC cycles.
		The needed delay time increases further according to the transfer time se=
tting (TRANSFER) by 0, 2, 4
		or 8 ADC cycles */
 =

		usleep_range(st->channel_disable_wait_us, (st->channel_disable_wait_us * =
3) / 2);
 =


	=

		if (ret > 0) {
			/* A valid conversion took place. */
			*val =3D st->last_value;
			st->last_value =3D 0;
			st->done =3D false;
			ret =3D IIO_VAL_INT;
		} else if (ret =3D=3D 0) {
			dev_err(&idev->dev, "ADC channel %d timeout.\n", chan->channel);
			ret =3D -ETIMEDOUT;

		}

		mutex_unlock(&st->lock);
		return ret;

	case IIO_CHAN_INFO_SCALE:
		*val =3D st->vref_mv;
		*val2 =3D chan->scan_type.realbits;
		return IIO_VAL_FRACTIONAL_LOG2;
	default:
		break;
	}
	return -EINVAL;
}
---

Best wishes, Georg

-----Urspr=FCngliche Nachricht-----
Von: Jonathan Cameron [mailto:jonathan.cameron@huawei.com] =

Gesendet: Montag, 04. Februar 2019 10:46
An: Georg Ottinger <g.ottinger@abatec.at>
Cc: Jonathan Cameron <jic23@kernel.org>; eugen.hristev@microchip.com; Stefa=
n Etzlstorfer <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw=
.net>; Nicolas Ferre <nicolas.ferre@microchip.com>; Alexandre Belloni <alex=
andre.belloni@bootlin.com>; Ludovic Desroches <ludovic.desroches@microchip.=
com>; David S. Miller <davem@davemloft.net>; Ard Biesheuvel <ard.biesheuvel=
@linaro.org>; Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.org;=
 linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Maxime=
 Ripard <maxime.ripard@bootlin.com>
Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in timeo=
ut case

On Mon, 4 Feb 2019 07:17:07 +0000
Georg Ottinger <g.ottinger@abatec.at> wrote:

> Actually this issue occurred to us with an concrete product, where we exp=
erienced a system hang at -20 =B0C.
> It was triggered by a race condition between the Touch Trigger and the Ch=
annel Trigger of the ADC. Once triggered we got in to the situation where a=
n ongoing Channel Conversion was lost (Timeout case).When we queried a seco=
nd channel than we got a system hang. Investigating this issue we developed=
 an error demonstrator - reading alternating two channels as fast as possib=
le (when Touch is enabled). This also provokes this issue at room temperatu=
re.
> =

> For the error demonstrator use following commandline to compile:
> =

> $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o =

> adc_demo_error2
> =

> -------------
> // adc_demo_error.c
> #include <unistd.h>
> #include <fcntl.h>
> =

> #define VLEN 10
> =

> int main()
> {
>   int fd_adc,fd_adc2;
>   int ret;
>   char dummy[VLEN];
>   =

>   fd_adc =3D open =

> ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltag
> e4_raw",O_RDONLY);
> #ifdef 2ND_CHANNEL
>   fd_adc2 =3D open =

> ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltag
> e5_raw",O_RDONLY);
> #endif
> =

>   while(1) {
> =

>     lseek(fd_adc, 0, SEEK_SET);
>     ret =3D read(fd_adc, dummy, VLEN);
> #ifdef 2ND_CHANNEL
>     lseek(fd_adc2, 0, SEEK_SET);
>     ret =3D read(fd_adc2, dummy, VLEN);
> #endif
> =

>   }
> }
> =

> ------------
> =

> =

> Greeting, Georg
Hi Georg,

Thanks for the detailed error report and reproducer.

What has me wondering now is where the race is that is triggering this?
Could you talk us through it?  I don't know this driver that well so probab=
ly much quicker for you to fill in the gaps rather than me try to figure ou=
t the race path!

I have no problem with defense in depth (with appropriate comments) but I'd=
 like to close that down as well.  If it really is unsolvable I'd like at l=
east to have some clear comments in the code explaining why.

Thanks,

Jonathan

> =

> -----Urspr=FCngliche Nachricht-----
> Von: Jonathan Cameron [mailto:jic23@kernel.org]
> Gesendet: Samstag, 02. Februar 2019 11:21
> An: Georg Ottinger <g.ottinger@abatec.at>
> Cc: eugen.hristev@microchip.com; Stefan Etzlstorfer =

> <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.de>; =

> Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler =

> <pmeerw@pmeerw.net>; Nicolas Ferre <nicolas.ferre@microchip.com>; =

> Alexandre Belloni <alexandre.belloni@bootlin.com>; Ludovic Desroches =

> <ludovic.desroches@microchip.com>; David S. Miller =

> <davem@davemloft.net>; Ard Biesheuvel <ard.biesheuvel@linaro.org>; =

> Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.org; =

> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; =

> Maxime Ripard <maxime.ripard@bootlin.com>
> Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in =

> timeout case
> =

> On Wed, 30 Jan 2019 14:42:02 +0100
> <g.ottinger@abatec.at> wrote:
> =

> > From: Georg Ottinger <g.ottinger@abatec.at>
> > =

> > Having a brief look at at91_adc_read_raw() it is obvious that in the =

> > case of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR =

> > registers is omitted. If 2 different channels are queried we can end =

> > up with a situation where two interrupts are enabled, but only one =

> > interrupt is cleared in the interrupt handler. Resulting in a =

> > interrupt loop and a system hang.
> > =

> > Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>
> =

> Whilst I agree this looks like a correct change, I would like Maxime to t=
ake a look as he is obviously much more familiar with the driver than I am.
> =

> I suspect you can only actually get there in the event of a hardware fail=
ure as that isn't actually a timeout you should ever see.
> Could be wrong though!
> =

> Thanks,
> =

> Jonathan
> =

> > ---
> >  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > =

> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c =

> > index 75d2f7358..596841a3c 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *idev,
> >  		ret =3D wait_event_interruptible_timeout(st->wq_data_avail,
> >  						       st->done,
> >  						       msecs_to_jiffies(1000));
> > -		if (ret =3D=3D 0)
> > -			ret =3D -ETIMEDOUT;
> > -		if (ret < 0) {
> > -			mutex_unlock(&st->lock);
> > -			return ret;
> > -		}
> > -
> > -		*val =3D st->last_value;
> >  =

> > +		/* Disable interrupts, regardless if adc conversion was
> > +		 * successful or not
> > +		 */
> >  		at91_adc_writel(st, AT91_ADC_CHDR,
> >  				AT91_ADC_CH(chan->channel));
> >  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
> >  =

> > -		st->last_value =3D 0;
> > -		st->done =3D false;
> > +		if (ret > 0) {
> > +			/* a valid conversion took place */
> > +			*val =3D st->last_value;
> > +			st->last_value =3D 0;
> > +			st->done =3D false;
> > +			ret =3D IIO_VAL_INT;
> > +		} else if (ret =3D=3D 0) {
> > +			/* conversion timeout */
> > +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> > +				chan->channel);
> > +			ret =3D -ETIMEDOUT;
> > +		}
> > +
> >  		mutex_unlock(&st->lock);
> > -		return IIO_VAL_INT;
> > +		return ret;
> >  =

> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D st->vref_mv;
> =




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
