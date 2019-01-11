Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F51C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:48:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8012133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DSWqBuzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8012133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OdJwPMdaRhU6JAFyVEYCi4PC3J3PBdw+MF3mxlPrH8k=; b=DSWqBuzIKT7c8O
	+Qyok4//6653sYaMSjuace/8KK9Uz2coVS5cacOTF75DQl+Tpo50jj+xgr++Or663/84Vp3tUCPPu
	a2MtAV7pdzINEddrFzPUR6aCpASpgTU2jul42a28e4+RotLwlo69CHfAgBFJR+05Hi768aJM/7nZr
	l4x3JULmhJsD8YgVqzVsVXrntJpuqyT8cnuJECkFTYckxOrtGCjFmg/XZNBJD5FZonMbqRUSAC9Vr
	a1UJE6RJfqIS5fF+N9VurK2Hf8UXjmxTHhWz0VvG/kYaFrGFDHFANpdDmL3KdhY3rvWJhKbyvCwmS
	Lv1vJmK7onynv5qeQcXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi3iv-0004l6-M8; Fri, 11 Jan 2019 20:48:13 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi3ir-0004k8-UJ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:48:11 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gi3ik-0006Vu-2w; Fri, 11 Jan 2019 21:48:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gi3ij-0002lq-3t; Fri, 11 Jan 2019 21:48:01 +0100
Date: Fri, 11 Jan 2019 21:48:01 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Message-ID: <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_124810_132093_6AF58D91 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> From: Praveen Kumar B <praveen.b@broadcom.com>
> =

> Add new compatible string for new version of pwm-kona
> =

> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Do=
cumentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> index 8eae9fe..d37f697 100644
> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
>  This controller has 6 channels.
>  =

>  Required Properties :
> -- compatible: should contain "brcm,kona-pwm"
> +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"

Is v2 used on a newer generation of kona SoCs? On i.MX these variants
are usually named after the first SoC that came with the new variant. Is
this sensible here, too?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
