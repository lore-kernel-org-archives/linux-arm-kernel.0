Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:59:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D90020700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D5iit4V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D90020700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=znkfVh51quPhenhGp0cRH/zGs1Nn7jvfHeeYw+NBl7E=; b=D5iit4V/cnbjyE
	tfWvuHDIBJ/htx0NhgvL1wfe4G6KCQb7yTUa+gnlEw9oLCnJEGWwHjMf3oD0jxUdDmLf2KTO1o0RT
	p0gvw33YS/eSpdnpD0VVU4ff41Uu2wzDuteM7TphSwKO+Y7AOlXYAE5ibVUKltgq2aRIpUsRlEMSu
	DceorUvj+OBGoPwNMx/5qRLZqIs3cRCtDypg3u4tBDnBmcZ1NRyGoC76BR+GGXtcIpNpA9Jj3rtaR
	ZgCmCQFx+wyZaO03szpz06e4iZVpbO3s+diL6h0HgYxi6+fT3vyBqWbWBp8vE/UAepoOMeWHIuJR3
	RMP0K9I2IBLQX7wctuqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7cT-0002mG-WC; Fri, 22 Feb 2019 09:59:50 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7cP-0002la-FO
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:59:47 +0000
X-IronPort-AV: E=Sophos;i="5.58,399,1544511600"; d="scan'208";a="25064377"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 22 Feb 2019 02:59:43 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Fri, 22 Feb 2019
 02:59:41 -0700
Date: Fri, 22 Feb 2019 10:59:24 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Georg Ottinger <g.ottinger@abatec.at>
Subject: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in timeout
 case
Message-ID: <20190222095924.ald66pmei3erur2e@M43218.corp.atmel.com>
Mail-Followup-To: Georg Ottinger <g.ottinger@abatec.at>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
 Stefan Etzlstorfer <s.etzlstorfer@abatec.at>,
 Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Kees Cook <keescook@chromium.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190130134202.5831-1-g.ottinger@abatec.at>
 <20190202102021.12bb0a72@archlinux>
 <0974ce54b3da4d82b6bd3026a3de5ff3@abatec.at>
 <20190204094540.00003072@huawei.com>
 <040567eeda7b40b38816da2df354386f@abatec.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <040567eeda7b40b38816da2df354386f@abatec.at>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_015945_682848_46FD4E3D 
X-CRM114-Status: GOOD (  42.89  )
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
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
 Stefan Etzlstorfer <s.etzlstorfer@abatec.at>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 11:03:18AM +0000, Georg Ottinger wrote:
> I don't know how the race condition is triggered in detail.  All I know i=
s that if Touch Acquisition is enabled the adc_demo_error2 will provoke a s=
ystemhang. If Touch is disabled the issue goes away. The architecture of at=
91_adc.c uses (at least) two trigger mechanisms of the ADC peripheral: Touc=
h Trigger and Channel Trigger (started by at91_adc_read_raw() ). In my theo=
ry the following happens:

I think you trigger this race condition because when a touchscreen
conversion is done, it performs a conversion on *all active channels*.

Regards

Ludovic

> =

> 1.) at91_adc_read_raw is called, a ADC conversation gets started
> 2.) Touch trigger initiates a new conversation (killing the first convers=
ation)
> =

> .... the conversation started from  at91_adc_read_raw() never finishes ->=
 TIMEOUT!
> =

> The following Email is a summary of our findings (I mailed to the microch=
ip people):
> =

> -----
> =

> I want to let you know our findings of our ADC bughunting marathon. We pu=
t around 100 hours of work to identify this issues and I think we found 4  =
of them (one of them is more hardware related). Although we could develop w=
orkarounds for this issues - not all of them are fully understood - so if p=
ossible including someone experienced with the ADC peripheral (maybe from t=
he hardware team) should be considered.
> =

> Attached you will find our version of at91_adc.c together with a simple e=
rror demonstrator program called adc_demo_error.c
> =

> * 1st issue: Unwanted PEN/NOPEN Interrupts at low temperatures
> =

> When in Pendetect mode we received a lot of unwanted interrupts. This iss=
ue only appeared in our test settings when our board approached -20 degrees=
 Celsius. We suspect that the internal Pull-down Resistor connected before =
the Pendetect-Schmitt trigger (selected by PENDETSENS), has a negative temp=
erature coefficient and at low temperature the impedance might be too high =
and so false detects are triggered by capturing surrounding noise -> we cou=
ld solve this issue by changing the value  ts_pen_detect_sensitivity =3D 2 =
to ts_pen_detect_sensitivity =3D 3.
> =

> This issue can be considered to be related to our specific configuration,=
 nevertheless we want to mention that the current Datasheet States on Page =
1711 states the following:
> =

> "PENDETSENS: Pen Detection Sensitivity-Modifies the pen detection input p=
ull-up resistor value. See the section 'Electrical Characteristics' for fur=
ther details."
> =

> There are two issues with this description. First: This resistor is a pul=
l-down resistor (measured and logical). Second the 'Electrical Characterist=
ics' sections is lacking the detailed description of this resistor value.
> =

> * 2nd issue: at91_adc_read_raw() keeps Channel and corresponding interrup=
t enabled in case of timeout.
> =

> Having a brief look at at91_adc_read_raw() it is obvious that in the case=
 of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR registers is om=
itted.
> If 2 different channels are queried  we can end up with a situation where=
 two Interrupts are enabled - but only one Interrupt is cleared in the Inte=
rrupt handler. Resulting in a interrupt loop and a system hang.
> =

> This Issue can be reproduced by compiling and running the error demonstra=
tion with two channel support. (-D2ND_CHANNEL)
> =

> $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o adc=
_demo_error2
> =

> * 3rd issue: Race condition between PEN/NOPEN Interrupts using periodic t=
rigger and ADC_START in at91_adc_read_raw()
> =

> This issue represents one way how timeout situations are provoked. Actual=
ly we consider the architecture of at91_adc.c a bit risky because it is usi=
ng two trigger sources (periodic trigger for Touch, and ADC_START for readi=
ng raw values). We believe that changing the trigger source during an ongoi=
ng conversion can have unwanted side effects, like destroying an ongoing co=
nversion. We currently don't fully understand what is going on, but we deve=
loped a workaround that is enhancing the timeout handling in at91_adc_read_=
raw() with a simple retry mechanism. (restarting with ADC_START)
> =

> * 4th issue: when touch operation is enabled (TSMODE) a delay time betwee=
n a channel disable (AT91_ADC_CHDR) and channel enable (AT91_ADC_CHER) is n=
eeded otherwise the following conversion will fail.
> =

> This issue represents the second way how timeout situations can arise. We=
 measured around 40 to 42 ADC Cycles (at different ADC Clocks 500khz, 1mhz,=
 2mhz, 3mhz, 5mhz) of delay needed between the channel disable and the chan=
nel enable. At higher adc clock frequency (10mhz, 20 mhz) the issue doesn't=
 show up (most likely because the function calls are delaying already enoug=
h). We also observed that the need delay time increases further according t=
o the transfer time settings (TRANSFER) by 0, 2, 4 or 8  ADC cycles.
> =

> This Issue can be reproduced by compiling and running the error demonstra=
tor (single channel) and including a simple error message in the kernel mod=
ule in the timeout case.
> =

> $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -o adc_demo_error
> =

> This issue is least understood by us and I think that talking to the hard=
ware people regarding this issue can be worthwhile. =

> As a workaround we put at91_adc_read_raw() to sleep after the writing AT9=
1_ADC_CHDR for 50 to 75 ADC Cycles. =

> =

> ------------------------------------
> =

> We will run another round of tests next week - and after that I would lik=
e to prepare a pull request concerning the 2nd Issue. For the 3rd and the 4=
th Issue I would like to hear your opinion if our modifications are sound b=
efore I will write an pull request.
> =

> Thanks for your time,
> Best wishes,
> Georg Ottinger
> =

> -----
> =

> -----Urspr=FCngliche Nachricht-----
> Von: Jonathan Cameron [mailto:jonathan.cameron@huawei.com] =

> Gesendet: Montag, 04. Februar 2019 10:46
> An: Georg Ottinger <g.ottinger@abatec.at>
> Cc: Jonathan Cameron <jic23@kernel.org>; eugen.hristev@microchip.com; Ste=
fan Etzlstorfer <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.de>=
; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmee=
rw.net>; Nicolas Ferre <nicolas.ferre@microchip.com>; Alexandre Belloni <al=
exandre.belloni@bootlin.com>; Ludovic Desroches <ludovic.desroches@microchi=
p.com>; David S. Miller <davem@davemloft.net>; Ard Biesheuvel <ard.biesheuv=
el@linaro.org>; Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.or=
g; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Maxi=
me Ripard <maxime.ripard@bootlin.com>
> Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in tim=
eout case
> =

> On Mon, 4 Feb 2019 07:17:07 +0000
> Georg Ottinger <g.ottinger@abatec.at> wrote:
> =

> > Actually this issue occurred to us with an concrete product, where we e=
xperienced a system hang at -20 =B0C.
> > It was triggered by a race condition between the Touch Trigger and the =
Channel Trigger of the ADC. Once triggered we got in to the situation where=
 an ongoing Channel Conversion was lost (Timeout case).When we queried a se=
cond channel than we got a system hang. Investigating this issue we develop=
ed an error demonstrator - reading alternating two channels as fast as poss=
ible (when Touch is enabled). This also provokes this issue at room tempera=
ture.
> > =

> > For the error demonstrator use following commandline to compile:
> > =

> > $ arm-buildroot-linux-gnueabihf-gcc adc_demo_error.c -D2ND_CHANNEL -o =

> > adc_demo_error2
> > =

> > -------------
> > // adc_demo_error.c
> > #include <unistd.h>
> > #include <fcntl.h>
> > =

> > #define VLEN 10
> > =

> > int main()
> > {
> >   int fd_adc,fd_adc2;
> >   int ret;
> >   char dummy[VLEN];
> >   =

> >   fd_adc =3D open =

> > ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltag
> > e4_raw",O_RDONLY);
> > #ifdef 2ND_CHANNEL
> >   fd_adc2 =3D open =

> > ("/sys/devices/platform/ahb/ahb:apb/f8018000.adc/iio:device0/in_voltag
> > e5_raw",O_RDONLY);
> > #endif
> > =

> >   while(1) {
> > =

> >     lseek(fd_adc, 0, SEEK_SET);
> >     ret =3D read(fd_adc, dummy, VLEN);
> > #ifdef 2ND_CHANNEL
> >     lseek(fd_adc2, 0, SEEK_SET);
> >     ret =3D read(fd_adc2, dummy, VLEN);
> > #endif
> > =

> >   }
> > }
> > =

> > ------------
> > =

> > =

> > Greeting, Georg
> Hi Georg,
> =

> Thanks for the detailed error report and reproducer.
> =

> What has me wondering now is where the race is that is triggering this?
> Could you talk us through it?  I don't know this driver that well so prob=
ably much quicker for you to fill in the gaps rather than me try to figure =
out the race path!
> =

> I have no problem with defense in depth (with appropriate comments) but I=
'd like to close that down as well.  If it really is unsolvable I'd like at=
 least to have some clear comments in the code explaining why.
> =

> Thanks,
> =

> Jonathan
> =

> > =

> > -----Urspr=FCngliche Nachricht-----
> > Von: Jonathan Cameron [mailto:jic23@kernel.org]
> > Gesendet: Samstag, 02. Februar 2019 11:21
> > An: Georg Ottinger <g.ottinger@abatec.at>
> > Cc: eugen.hristev@microchip.com; Stefan Etzlstorfer =

> > <s.etzlstorfer@abatec.at>; Hartmut Knaack <knaack.h@gmx.de>; =

> > Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler =

> > <pmeerw@pmeerw.net>; Nicolas Ferre <nicolas.ferre@microchip.com>; =

> > Alexandre Belloni <alexandre.belloni@bootlin.com>; Ludovic Desroches =

> > <ludovic.desroches@microchip.com>; David S. Miller =

> > <davem@davemloft.net>; Ard Biesheuvel <ard.biesheuvel@linaro.org>; =

> > Kees Cook <keescook@chromium.org>; linux-iio@vger.kernel.org; =

> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; =

> > Maxime Ripard <maxime.ripard@bootlin.com>
> > Betreff: Re: [PATCH] iio: adc: at91: disable adc channel interrupt in =

> > timeout case
> > =

> > On Wed, 30 Jan 2019 14:42:02 +0100
> > <g.ottinger@abatec.at> wrote:
> > =

> > > From: Georg Ottinger <g.ottinger@abatec.at>
> > > =

> > > Having a brief look at at91_adc_read_raw() it is obvious that in the =

> > > case of a timeout the setting of AT91_ADC_CHDR and AT91_ADC_IDR =

> > > registers is omitted. If 2 different channels are queried we can end =

> > > up with a situation where two interrupts are enabled, but only one =

> > > interrupt is cleared in the interrupt handler. Resulting in a =

> > > interrupt loop and a system hang.
> > > =

> > > Signed-off-by: Georg Ottinger <g.ottinger@abatec.at>
> > =

> > Whilst I agree this looks like a correct change, I would like Maxime to=
 take a look as he is obviously much more familiar with the driver than I a=
m.
> > =

> > I suspect you can only actually get there in the event of a hardware fa=
ilure as that isn't actually a timeout you should ever see.
> > Could be wrong though!
> > =

> > Thanks,
> > =

> > Jonathan
> > =

> > > ---
> > >  drivers/iio/adc/at91_adc.c | 28 +++++++++++++++++-----------
> > >  1 file changed, 17 insertions(+), 11 deletions(-)
> > > =

> > > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c =

> > > index 75d2f7358..596841a3c 100644
> > > --- a/drivers/iio/adc/at91_adc.c
> > > +++ b/drivers/iio/adc/at91_adc.c
> > > @@ -704,23 +704,29 @@ static int at91_adc_read_raw(struct iio_dev *id=
ev,
> > >  		ret =3D wait_event_interruptible_timeout(st->wq_data_avail,
> > >  						       st->done,
> > >  						       msecs_to_jiffies(1000));
> > > -		if (ret =3D=3D 0)
> > > -			ret =3D -ETIMEDOUT;
> > > -		if (ret < 0) {
> > > -			mutex_unlock(&st->lock);
> > > -			return ret;
> > > -		}
> > > -
> > > -		*val =3D st->last_value;
> > >  =

> > > +		/* Disable interrupts, regardless if adc conversion was
> > > +		 * successful or not
> > > +		 */
> > >  		at91_adc_writel(st, AT91_ADC_CHDR,
> > >  				AT91_ADC_CH(chan->channel));
> > >  		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
> > >  =

> > > -		st->last_value =3D 0;
> > > -		st->done =3D false;
> > > +		if (ret > 0) {
> > > +			/* a valid conversion took place */
> > > +			*val =3D st->last_value;
> > > +			st->last_value =3D 0;
> > > +			st->done =3D false;
> > > +			ret =3D IIO_VAL_INT;
> > > +		} else if (ret =3D=3D 0) {
> > > +			/* conversion timeout */
> > > +			dev_err(&idev->dev, "ADC Channel %d timeout.\n",
> > > +				chan->channel);
> > > +			ret =3D -ETIMEDOUT;
> > > +		}
> > > +
> > >  		mutex_unlock(&st->lock);
> > > -		return IIO_VAL_INT;
> > > +		return ret;
> > >  =

> > >  	case IIO_CHAN_INFO_SCALE:
> > >  		*val =3D st->vref_mv;
> > =

> =

> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
