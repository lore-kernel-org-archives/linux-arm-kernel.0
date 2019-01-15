Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:01:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4A920656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTFvfm2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4A920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6W1uN5gfIHP0Tah+vHimGqr9j656xSnM4IMzrOZrJTw=; b=FTFvfm2y4DNSDQ
	Bd/RuuHcyr/N1lCjr7/1TpqQgzuT54lZUpXOYZI+86c3OeztzdBHn9noHmkjAvmzOAN/WRMLLFf/A
	bSniIy9zcOgm7OSUArFbeIUBa31GYSSxsYBrs4bGHtuS0fIp02J7KtwRWQFnyJ0WmJ8PmPVgYh1EV
	YGOnuYmAphLQGVckevqQGWJkgCEVWQdydee2tkuhXhGe+UhGnh0R4TlMw3H0WefeqgdOBUK+epOal
	lL6L3Ocj87l3wHlUqtTPfMbnfNnU405CXbXzKTUHZ74bDYu59mJTs9QiSBd/nwXQAOKGzuHqTFKiM
	odoDcLvPkDVfnUl67i7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjUtO-0003uj-JP; Tue, 15 Jan 2019 20:00:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjUtC-0003oc-GR
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 20:00:56 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gjUsy-0003um-L9; Tue, 15 Jan 2019 21:00:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gjUsx-0002ty-DQ; Tue, 15 Jan 2019 21:00:31 +0100
Date: Tue, 15 Jan 2019 21:00:31 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 1/5] pwm: mediatek: add a property "mediatek,num-pwms"
Message-ID: <20190115200031.7vranuo6fpcaqvce@pengutronix.de>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_120046_825543_5B2E4B98 
X-CRM114-Status: GOOD (  21.32  )
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

On Mon, Jan 14, 2019 at 04:21:20PM +0800, Ryder Lee wrote:
> This adds a property "mediatek,num-pwms" to avoid having an endless
> list of compatibles with no other differences for the same driver.

I seem to recall having said something similar before, but maybe this
was a different series (there is no v2 or higher in the Subject ...)

I think it would be sensible to drop the vendor prefix and go with plain
"num-pwms" (or "npwms" to align to "ngpios" in the gpio bindings).

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> =

> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index eb6674c..37daa84 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -55,7 +55,6 @@ enum {
>  };
>  =

>  struct mtk_pwm_platform_data {
> -	unsigned int num_pwms;
>  	bool pwm45_fixup;
>  	bool has_clks;
>  };
> @@ -226,10 +225,11 @@ static void mtk_pwm_disable(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  =

>  static int mtk_pwm_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np =3D pdev->dev.of_node;
>  	const struct mtk_pwm_platform_data *data;
>  	struct mtk_pwm_chip *pc;
>  	struct resource *res;
> -	unsigned int i;
> +	unsigned int i, num_pwms;
>  	int ret;
>  =

>  	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> @@ -246,7 +246,13 @@ static int mtk_pwm_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(pc->regs))
>  		return PTR_ERR(pc->regs);
>  =

> -	for (i =3D 0; i < data->num_pwms + 2 && pc->soc->has_clks; i++) {
> +	ret =3D of_property_read_u32(np, "mediatek,num-pwms", &num_pwms);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);

This sounds wrong. "Failed to get number of pwms" sounds better to my
(non-native) ear.

> +		return ret;
> +	}
> +
> +	for (i =3D 0; i < num_pwms + 2 && pc->soc->has_clks; i++) {
>  		pc->clks[i] =3D devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
>  		if (IS_ERR(pc->clks[i])) {
>  			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
> @@ -260,7 +266,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &mtk_pwm_ops;
>  	pc->chip.base =3D -1;
> -	pc->chip.npwm =3D data->num_pwms;
> +	pc->chip.npwm =3D num_pwms;
>  =

>  	ret =3D pwmchip_add(&pc->chip);
>  	if (ret < 0) {
> @@ -279,32 +285,23 @@ static int mtk_pwm_remove(struct platform_device *p=
dev)
>  }
>  =

>  static const struct mtk_pwm_platform_data mt2712_pwm_data =3D {
> -	.num_pwms =3D 8,
> -	.pwm45_fixup =3D false,
> -	.has_clks =3D true,
> -};
> -
> -static const struct mtk_pwm_platform_data mt7622_pwm_data =3D {
> -	.num_pwms =3D 6,
>  	.pwm45_fixup =3D false,
>  	.has_clks =3D true,

I agree with Matthias Brugger that at least for some time you should be
able to fall back to the right number of pwms if the device tree doesn't
have a num-pwms property.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
