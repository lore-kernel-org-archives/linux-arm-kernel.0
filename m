Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93024C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:53:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7C02086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JWeEUO3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7C02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N6ECcqk3XHUEHlvAeD8p++S9WHE3OxEVyqC2EK3GGc8=; b=JWeEUO3ws8UuSb
	MMZNDF8KzR33SAvurh5Pp/FbT9gJUNPmOKwhWpNMGJyj+AkSufB/ZPSVpyT2FA2uqXncqDnx9icLa
	u2fFqQRkwUaqTuoQMBLgXScDuElToUxN40ewqM2i38fV8UIKMkKpIh6W4CbbAHpvtZmOI7ilcGU04
	xliztOOW0rMWRNB0Kr/3o1xXjIn6nOwJVE72J+yhotIuQJt6vs3xKbjvcjk6ZwQuumL5NP7H3gO3a
	ipmOZh4iqOz3BmBSyKbvQ1qMeEQay9I++vcGYEJhljGtrta1K+aEeALPLW8jemjC2SZfSX0PM1BgZ
	Sm8NBrGtehR7yHmz6hbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkQq8-0008VA-Ep; Fri, 18 Jan 2019 09:53:28 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkQq3-0008TY-80
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 09:53:25 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gkQpu-00073h-0Z; Fri, 18 Jan 2019 10:53:14 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gkQpt-0006HG-KN; Fri, 18 Jan 2019 10:53:13 +0100
Date: Fri, 18 Jan 2019 10:53:13 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Message-ID: <20190118095313.pbpdn43hd76khg2x@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <20190118075925.noilab6glzm3cig6@pengutronix.de>
 <1547804574.8124.6.camel@mtkswgap22>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547804574.8124.6.camel@mtkswgap22>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_015323_480606_D49227B6 
X-CRM114-Status: GOOD (  27.78  )
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
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Ryder,

On Fri, Jan 18, 2019 at 05:42:54PM +0800, Ryder Lee wrote:
> On Fri, 2019-01-18 at 08:59 +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> > =

> > On Fri, Jan 18, 2019 at 11:24:41AM +0800, Ryder Lee wrote:
> > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > list of compatibles with no differences for the same driver.
> > > =

> > > Thus, the driver should have backwards compatibility to older DTs.
> > =

> > I still think Thierry should bless "num-pwms" without vendor prefix.
> =

> Okay.
> =

> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > ---
> > > Changes since v1: add some checks for backwards compatibility.
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > =

> > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > > index eb6674c..81b7e5e 100644
> > > --- a/drivers/pwm/pwm-mediatek.c
> > > +++ b/drivers/pwm/pwm-mediatek.c
> > > @@ -55,7 +55,7 @@ enum {
> > >  };
> > >  =

> > >  struct mtk_pwm_platform_data {
> > =

> > Unrelated to this patch: This name is bad. This struct is not used as
> > platform_data and so should better be named mtk_pwm_of_data. While at
> > criticizing existing stuff: I'd prefer pwm_mediatek as common prefix to
> > match the filename.
> =

> I think we can take care about that in another patch.

That's what I wanted to say, right. Do you follow up?

> > > -	unsigned int num_pwms;
> > > +	unsigned int num_pwms;	/* it should not be used in the future SoCs =
*/
> > =

> > I'd drop this comment in favour of a runtime warning.
> =

> Sorry, I can't get you here.

I'd do a

	dev_warn(dev, "dt didn't specify number of PWMs, falling back to %d\n", pc=
->soc->num_pwms);

to make people aware that updating the dt would be nice.

> =

> > >  	bool pwm45_fixup;
> > >  	bool has_clks;
> > >  };
> > > @@ -226,27 +226,36 @@ static void mtk_pwm_disable(struct pwm_chip *ch=
ip, struct pwm_device *pwm)
> > >  =

> > >  static int mtk_pwm_probe(struct platform_device *pdev)
> > >  {
> > > -	const struct mtk_pwm_platform_data *data;
> > > +	struct device_node *np =3D pdev->dev.of_node;
> > >  	struct mtk_pwm_chip *pc;
> > >  	struct resource *res;
> > > -	unsigned int i;
> > > +	unsigned int i, num_pwms;
> > >  	int ret;
> > >  =

> > >  	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > >  	if (!pc)
> > >  		return -ENOMEM;
> > >  =

> > > -	data =3D of_device_get_match_data(&pdev->dev);
> > > -	if (data =3D=3D NULL)
> > > -		return -EINVAL;
> > > -	pc->soc =3D data;
> > > +	pc->soc =3D of_device_get_match_data(&pdev->dev);
> > =

> > This might return NULL which ...
> =

> The only way to call probe() is to match an entry in
> mtk_pwm_of_match[], so match cannot be NULL.

(<pedantic>Theoretically the driver can be probed by device name, but
that is not what I meant here.</pedantic>).

You're right, as long as all entries in mtk_pwm_of_match have a non-NULL
.data entry, you're fine. I somehow thought there might be some without
one. I wouldn't oppose to check for that anyhow as a defensive measure.

> > > [...]
> > > +	/* Check if we have set 'num-pwms' in DTs. */
> > > +	ret =3D of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > > +	if (ret < 0) {
> > > +		/* If no, fallback to use SoC data for backwards compatibility. */
> > > +		if (pc->soc->num_pwms) {
> > =

> > ... here then results in a NULL pointer dereference. I think you want
> =

> So we have no chance to get a NULL pointer, right?

Ack.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
