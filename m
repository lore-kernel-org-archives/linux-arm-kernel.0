Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37514C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:13:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22392086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sEI2OOdg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="syBJRFhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22392086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OMh5zvyOKaVlGFX9sfya65lmi+znp6R1/qOQwBW6pOg=; b=sEI2OOdgvXMxlM
	8LjJKJINbIxNx/2WtyxhXk7FhQV+MlGDbEuaJ1voTC1ygV6auK0bITJqjMrRu9YfZ98SUEfUN+tjd
	8DKAICAaKRzpJbLUL0Z77CD9gHiNEDyC1AZryx6Owzr3LpT3JXQ4bCRFih5Ub3AA/XQ1xjlC9dAEq
	kcvmOkT3PYHZoW1t2fO58JSmxx/Bx1f/nYoVw4jKXwtRo8qKhQoreHmCchLmHJtYMqoCDWoEseu7M
	ZabvKAKdPp5AeSDIsXLbn14u7aEkbUQRXYz9Y4P5j4nB1JycJ9DnLL2H6EAG7elPVA1TeIvpDBJqG
	Smi4un8LL3ZDy/BzViSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXc2g-00081X-3m; Fri, 14 Dec 2018 01:13:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXc2c-00080j-Lf
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:13:24 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B876A2086D;
 Fri, 14 Dec 2018 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544749992;
 bh=kWN4p+VyR38OOySBnD3pOw0g5JOZk1nwfMiBgOWd6w4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=syBJRFhf29yt6g88NnAumeFUqsGsJpnxduVywB5JZr7K92Qrs5Hj/rsyejPEQrY8F
 66FC8ToVka+Ye9G3gyRySmqgFtWEiRidiRYPxbeqv2DXX2Z5A4DUH/IB+xBCg//EG3
 RqhWy99glvoyXlCWPtgebjH8s3UDeTmhtkCqCbaA=
Date: Fri, 14 Dec 2018 09:12:09 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Message-ID: <20181214011207.GB13243@dragon>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
 <1544711727.3137.32.camel@pengutronix.de>
 <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_171322_728565_31BBFEAB 
X-CRM114-Status: GOOD (  17.68  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 02:51:50PM +0000, Abel Vesa wrote:
...
> > > diff --git a/arch/arm64/Kconfig.platforms
> > > b/arch/arm64/Kconfig.platforms
> > > index 7e1545a..318dbb9 100644
> > > --- a/arch/arm64/Kconfig.platforms
> > > +++ b/arch/arm64/Kconfig.platforms
> > > @@ -148,14 +148,6 @@ config ARCH_MXC
> > > =A0	=A0=A0This enables support for the ARMv8 based SoCs in the
> > > =A0	=A0=A0NXP i.MX family.
> > > =A0
> > > -config SOC_IMX8MQ
> > > -	bool "i.MX8MQ support"
> > > -	depends on ARCH_MXC
> > > -	select ARM64_ERRATUM_843419
> > > -	select ARM64_ERRATUM_845719
> > > -	help
> > > -	=A0=A0This enables support for the i.MX8MQ SoC.
> > > -
> > =

> > NACK on this one. Having a single place where stuff that is absolutely
> > critical for proper SoC operation can be selected is very useful and
> > avoids hard to debug issues due to slightly wrong configs in the long
> > run.
> =

> As mentioned in the cover letter, please ignore this patch set entirely.
> The ARCH_MXC is actually used on arm32 too, so it won't work.
> =

> I'm working on a patchset that will add the Kconfig into =

> drivers/clk/imx/ and in it will add CLK_IMX8MQ. That will
> fix the clock dependency since the CLK_IMX8MQ will depend on
> ARCH_MXC and ARM64. I believe the CLK_IMX8QXP will follow
> the same pattern.
> =

> As for the SOC_IMX8MQ, all the other vendors have one single
> config for all the arm64 platforms. TBH, to control every SoC
> independently it's a little bit of an overkill.

Lucas,

We are still waiting for further comments from Olof [1].  But it sounds
like SoC specific option is not welcomed on ARM64.

Shawn

[1] https://patchwork.kernel.org/patch/10727453/#22378669

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
