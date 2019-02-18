Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC29C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF1E217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HhTKppSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF1E217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2D4BVoHxuINvyvfy+zCzJw9Wd3FXdptjUxeBDcxAyt0=; b=HhTKppSut2IUGI
	+EAD7EfXNSsUeGXipa9r2cVoXVD5Huoe3PKIgZ3g0TGON0aQz1E3c+f6eZHSeAd/8tk3Vim1B/QLJ
	l1kcCbLyVaR0YVAy5zPjBJLSB3Pa2QKBgYLJ2XZUqa5kc8g4ng8PgA/F7z8AVlcczmYk60jtVZdyy
	CVs4oaEL9g9CAzOOs0M377bSjz+WLCmzygUByPFlw1wVVtVM36EWwvLB2bn5Sk7NYNqskoXZvPboG
	f6xOFXC/UQpDfXrA5cqLB1kYbkn6NJTu6ejMz/IW099m/0+ej3U7qmwdRv5Weej0+mDDj3/Is7OAw
	9Vq7irydRfRju3OGZCdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmcn-0006Ax-Ku; Mon, 18 Feb 2019 17:22:37 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmcj-0006AJ-AQ
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:22:35 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gvmcb-0003be-R1; Mon, 18 Feb 2019 18:22:25 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gvmcZ-0007Xr-PP; Mon, 18 Feb 2019 18:22:23 +0100
Date: Mon, 18 Feb 2019 18:22:23 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v4 3/3] pwm: core: add consumer device link
Message-ID: <20190218172223.lw3e5tn5hzsow6tg@pengutronix.de>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_092233_517865_EE357EDF 
X-CRM114-Status: GOOD (  19.46  )
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

Hello,

On Thu, Feb 14, 2019 at 11:25:51AM +0100, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - of_pwm_get()
> - pwm_get()
> - devm_*pwm_get() variants
> as it requires a reference to the device for the PWM consumer.
> =

> [1] https://lkml.org/lkml/2019/2/5/770
> =

> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v4:
> - rework error handling following Thierry's comments
> - turn/split pr_debug() into dev_err()/pr_warn().
> =

> Changes in v3:
> - add struct device to of_get_pwm() arguments to handle device link from
>   there as discussed with Uwe.
> ---
>  drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
---
>  include/linux/pwm.h |  6 ++++--
>  2 files changed, 51 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..64e10a6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -636,8 +636,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct de=
vice_node *np)
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
>  =

> +static struct device_link *pwm_device_link_add(struct device *dev,
> +					       struct pwm_device *pwm)
> +{
> +	struct device_link *dl;
> +
> +	if (!dev) {
> +		/*
> +		 * No device for the PWM consumer has been provided. It may
> +		 * impact the PM sequence ordering: the PWM supplier may get
> +		 * suspended before the consumer.
> +		 */
> +		pr_warn("no consumer dev, can't create device link to %s\n",
> +			dev_name(pwm->chip->dev));

Maybe use dev_warn(pwm->chip->dev, ...) ?

> +		return NULL;
> +	}
> +
> +	dl =3D device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER=
);
> +	if (!dl) {
> +		dev_err(dev, "failed to create device link to %s\n",
> +			dev_name(pwm->chip->dev));
> +			return ERR_PTR(-EINVAL);

broken indention.

> +	}
> +
> +	return dl;
> +}
> +

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
