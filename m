Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B768C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4C821906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HAiSjfpM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOKUMEAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C821906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JJWrEkXs4dJ6EI2pk7pmODrojruhKrKUjZ0Nj5dngJw=; b=HAiSjfpMtWO0CY
	iKZAvK3okscINarfvHxcP9f4lib1MLPHu4OfO+wpNbRGvoyxR5ahZVhBiPr93C5xFsW2gqtEFYbn4
	CiS52hGr8+5w635Qi6yVKJUuJ8es0ZkII/dt9gZFDZtuBtx6o6gVzRKxTS91Mc/b5B7yfYC7s7inh
	+Ljy5GRtAjV7cdj9GDK8bmeFVKlc/Hd+nKE0wFC+FeknlnjhEMjk8XMmj4y+7mNINI81nbWMMQFzs
	WlYmWtGXcP6neq0P9xnX+mQQ6FvFAZw08xKPhOlyRr2w3VCa0oK/9h3UCdaVvD4vRzTn0yHGzuSB9
	H57X5z2pQcrx+4kSuy6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQTR-0004Sn-5n; Fri, 21 Dec 2018 19:28:41 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQTO-0004Rj-IJ
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:28:39 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so3037177pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/4zLhrrDI5tXqdZs1MGr4wpX9qBajD53lBxnddDIVbg=;
 b=BOKUMEAIPk1XCHxFx8C5wm4LuY4O0wV7h70hAiCXYn6ET5eMcEVpebCaycAOCblFFZ
 JNgy2qG2R9VUOZ8k6Vt+urat+15dOvg8zOEYHBhLNTFX6+wM/V/DMkkNhaP7d6p5e4Qc
 qPTEzLaQxuq7I26vMztJiwG6H36K2WQMa6+ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=/4zLhrrDI5tXqdZs1MGr4wpX9qBajD53lBxnddDIVbg=;
 b=cbBiiS6nFEU66Dzt2ygy6DnF2UM0XL0Mup8piiIUlBP916bg2A/29fuADPjrgNacBQ
 8p3wFHSHKsusQdRVPkfnn/H3F5ckEFcAs4Y1FNKqwq9b6CQlImIdSWcuyqrtaopd4bT9
 mKbm2LRkLywIPfxI2jEavez5vEdOgeeGLasZ1fy8NYcnIEqAkty6xbsxMdgB08hVXyoi
 NFC5aSO2y4GWqC6H8zJU/8IxO46ADDykwLImmArUFbQLzueR68h+/MQCSXuohUUWkgUR
 uebXu1Ea6Tf3SGlARvyhlRj+i6GSB+Dx1hQ6hOb2GqvOP3GkMH2Sg7P5qzGPAsRfX9Jx
 Zw4w==
X-Gm-Message-State: AA+aEWY1kL4fN9eQYJ8IAM09aZhQXyVB/xqvNKRupUm2Iuozvr5EAPoI
 NxlDDHENqTxiA457Zb7NtnepZQ==
X-Google-Smtp-Source: AFSGD/VuBnDH+QkDsswEVpvWSgHa7hGCdfYV5lOToWBZI3irxqoRGNebG3ierYuA7DoLeQG5lzmz1Q==
X-Received: by 2002:a62:d148:: with SMTP id t8mr3913888pfl.52.1545420507345;
 Fri, 21 Dec 2018 11:28:27 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id q195sm28046252pgq.7.2018.12.21.11.28.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 11:28:25 -0800 (PST)
Date: Fri, 21 Dec 2018 11:28:23 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
Message-ID: <20181221192823.GA9704@minitux>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_112838_603723_E4EE5D58 
X-CRM114-Status: GOOD (  27.62  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, david.brown@linaro.org, linux-clk@vger.kernel.org,
 jassisinghbrar@gmail.com, jagan@amarulasolutions.com, andy.gross@linaro.org,
 sibis@codeaurora.org, devicetree@vger.kernel.org, arnd@arndb.de,
 niklas.cassel@linaro.org, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri 21 Dec 09:58 PST 2018, Taniya Das wrote:

> Hello,
> =

> On 12/21/2018 6:06 PM, Jorge Ramirez wrote:
> > On 12/21/18 12:19, Taniya Das wrote:
> > > =

> > > =

> > > On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
> > > > Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> > > > specifications.
> > > > =

> > > > Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > > > ---
> > > > =A0 drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
> > > > =A0 1 file changed, 6 insertions(+)
> > > > =

> > > > diff --git a/drivers/clk/qcom/gcc-qcs404.c
> > > > b/drivers/clk/qcom/gcc-qcs404.c
> > > > index 64da032..833436a 100644
> > > > --- a/drivers/clk/qcom/gcc-qcs404.c
> > > > +++ b/drivers/clk/qcom/gcc-qcs404.c
> > > > @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main =
=3D {
> > > > =A0=A0=A0=A0=A0 },
> > > > =A0 };
> > > > =A0 +static const struct pll_vco gpll0_ao_out_vco[] =3D {
> > > > +=A0=A0=A0 { 800000000, 800000000, 0 },
> > > > +};
> > > > +
> > > > =A0 static struct clk_alpha_pll gpll0_ao_out_main =3D {
> > > > =A0=A0=A0=A0=A0 .offset =3D 0x21000,
> > > > =A0=A0=A0=A0=A0 .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEF=
AULT],
> > > > =A0=A0=A0=A0=A0 .flags =3D SUPPORTS_FSM_MODE,
> > > > +=A0=A0=A0 .vco_table =3D gpll0_ao_out_vco,
> > > > +=A0=A0=A0 .num_vco =3D ARRAY_SIZE(gpll0_ao_out_vco),
> > > =

> > > Could you please help as to why this is required? This is a fixed
> > > PLL and we do not require a VCO table for it.
> > =

> > Hi Taniya,
> > =

> > this patch - the additional information that it provides about the
> > hardware - helps to select the right parent clock for a given frequency.
> > =

> > On the qcs404 this clock is one of the two parent clocks of the apcs
> > clock controller (the other one being the high frequency pll)
> > When cpufreq sets a target frequency, there is an iteration through the
> > list of parents to select the one that delivers the best match.
> > =

> > When attempting to set the clock for an alpha_pll, the operation does a
> > sanity check to validate that the requested frequency is in fact
> > reachable using the vco range: trying to set a value that is not in
> > range will fail.
> > =

> > This patch makes sure that its range is explicitly defined.
> > =

> > It also helps making sure there are no rounding issues when setting its
> > value: without it the clock was being read at 799MHz
> > =

> > =

> =

> If the PLL is being read as 799MHz it would because not all the 40 bits of
> the ALPHA_VAL being programmed by the bootloaders(which are the original
> owners of this PLL). So we should go with the way they are being set by
> bootloaders and read by HLOS driver.
> =

> And a VCO range you have considered is wrong from a PLL perspective. As
> these are fixed PLLs and VCO range really does not matter here, so please
> drop this change.
> =


The problem here is that the PLL should be fixed at 800MHz, but the
alpha PLL is defined such that it can change. So when the mux-div is
looking for a suitable parent and divider for our CPU clock it concludes
that the best way to reach certain frequencies is to change the rate of
GPLL0.

Adding the vco_table limits the available frequencies for GPLL0 in
QCS404, without modifying the implementation of the alpha PLL.

Perhaps there's a better way to define that this particular clock
hardware can change rate, but in this implementation it must not?

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
