Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A83C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D922073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t/0cOw8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D922073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eORP10v6r+ztAa3WNmmvluEEN7syz3hgDZ6l0MzfGaY=; b=t/0cOw8+1FtN3D
	QMAht+xyiQTEydJ1EiMbGpjqaZtvhqvg4+qhXUdh5ho507UqSt+jsFDaZVnuKu97ratT0ePrkyg3P
	eMOMjt6Wpel2DRq5VIHImw0P+B1rzepcYdh6juG9MP5OOK0Pbt4RZ6ghZz/zptUD6VD2rqDFYhk6v
	cWRy9zTs/bcGh26Khw71IaO+AKnWzWbuSkEHB/b7aLiBZDm2L3MYnAOMfUKcRMUqu8nrAGKCZeELN
	8R3/S3fYCZg/Z5PxmYIOYdzosBoBm2XwbqThvN6UswWlw0TNx1Sx8jbtSEs1/4eeCqHBoE1UotFtx
	oyiD2vFqqef6zaduhdcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTyE-0001O0-EL; Tue, 12 Feb 2019 09:03:14 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTyB-0001NZ-PL
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:03:13 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtTy6-0005hT-DZ; Tue, 12 Feb 2019 10:03:06 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtTy4-0001GE-Kh; Tue, 12 Feb 2019 10:03:04 +0100
Date: Tue, 12 Feb 2019 10:03:04 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Message-ID: <20190212090304.3j4iqj6sodtdvhr7@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
 <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
 <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9f1bb5c-36cd-f6e6-e6c6-a0257cf38b7e@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_010311_984152_A741F8F9 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Fabrice,

On Tue, Feb 12, 2019 at 09:31:37AM +0100, Fabrice Gasnier wrote:
> On 2/11/19 8:06 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
> >> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *=
dev, struct device_node *np,
> >>  	if (!IS_ERR(pwm)) {
> >>  		*ptr =3D pwm;
> >>  		devres_add(dev, ptr);
> >> +		device_link_add(dev, pwm->chip->dev,
> >> +				DL_FLAG_AUTOREMOVE_CONSUMER);
> > =

> > IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
> > + devres stuff. I'd put device_link_add() into of_pwm_get().
> =

> Hi Uwe,
> =

> I also agree with this. But I think this implies modifying the API for
> of_pwm_get():
>  /**
>   * of_pwm_get() - request a PWM via the PWM framework
> + * @dev: device for PWM consumer
>   * @np: device node to get the PWM from
>   * @con_id: consumer name
> =

> It seems there aren't much of_pwm_get() users currently.
> Does this look sensible ?

In my eyes this looks sensible, yes.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
