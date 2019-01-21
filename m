Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DBFC636D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:50:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1797620861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0M69COB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1797620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5KtejuhObudMXaKLv5smYTk9EWzQ//Erl1Lc8aj1YN8=; b=L0M69COB809n6h
	BnhbpWT7Wn6OKkCk4zWeaMw1rtugqNGQMlf4fOtkvCjEy8R6CXUQOiWaiy1tQuIkETM+oHm1nEcmA
	nLQaQpzTK9Z0KrLVDg6gROwM/MFkZ5Kp1WhSPiC81QN+EpXPdBwy9GgYm0Z47K1++irywg36WEb7S
	m5wCTZqRucnP2l2YRkRAQeTcagQc4ajoohcOyeWjtbPwlPtjReJHT/c8okkDjeWgVMhjGcZOiSvKE
	EW8tPjOGvyO2mA9q6hli6KeyjgQo23KjVWLI1Im9rifjtLlkZjNhZWA1U8BduGq0fKZ/DU0+whDBX
	O6njkRUNE7RziwvTvqsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVHO-0000E1-Rn; Mon, 21 Jan 2019 08:50:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVHK-00009R-Na
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:50:00 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1glVHB-0003tK-74; Mon, 21 Jan 2019 09:49:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1glVHA-0000YN-GN; Mon, 21 Jan 2019 09:49:48 +0100
Date: Mon, 21 Jan 2019 09:49:48 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v1 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Message-ID: <20190121084948.frpcgg6wkdjxkl7k@pengutronix.de>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <c007d399-af86-98d3-94f9-b9762efdc219@gmail.com>
 <1547866487.14213.10.camel@mtkswgap22>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547866487.14213.10.camel@mtkswgap22>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_004958_919713_C56ADDB1 
X-CRM114-Status: GOOD (  27.26  )
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

On Sat, Jan 19, 2019 at 10:54:47AM +0800, Ryder Lee wrote:
> On Fri, 2019-01-18 at 09:43 +0100, Matthias Brugger wrote:
> > =

> > On 18/01/2019 04:24, Ryder Lee wrote:
> > > This adds a property "mediatek,num-pwms" to avoid having an endless
> > > list of compatibles with no differences for the same driver.
> > > =

> > > Thus, the driver should have backwards compatibility to older DTs.
> > > =

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
> > > -	unsigned int num_pwms;
> > > +	unsigned int num_pwms;	/* it should not be used in the future SoCs =
*/
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
> > >  =

> > >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	pc->regs =3D devm_ioremap_resource(&pdev->dev, res);
> > >  	if (IS_ERR(pc->regs))
> > >  		return PTR_ERR(pc->regs);
> > >  =

> > > -	for (i =3D 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> > > +	/* Check if we have set 'num-pwms' in DTs. */
> > > +	ret =3D of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> > > +	if (ret < 0) {
> > > +		/* If no, fallback to use SoC data for backwards compatibility. */
> > > +		if (pc->soc->num_pwms) {
> > > +			num_pwms =3D pc->soc->num_pwms;
> > =

> > Maybe that's bike shedding, but I think it would be better to carve out=
 the
> > num_pwms from the mtk_pwm_platform_data and check against the compatibl=
e here.
> =

> I'm not sure how to properly curve it out? I think we still need this
> variable to save the specific value for some legacy SoCs (with older
> DTs).

I guess he means  something like:

	if (is_compatible_to_variant_A(dev))
		num_pwms =3D 12;
	else if (is_compatible_to_variant_B(dev))
		num_pwms =3D 2;

. In my eyes the bike shed should be light red and I prefer to collect
the fallback num_pwms in the compatible_data as is to keep the code
simpler. Maybe rename the member from num_pwms to fallback_num_pwms to
make it more obvious that it doesn't represent the actually used value.

> > With a expressive comment it will help other driver developers to not s=
tart
> > adding num_pwms in the platform data in their first attempt.
> =

> Definitely.

My suggestion was to add a dev_warn, which IMHO is still better than a
comment.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
