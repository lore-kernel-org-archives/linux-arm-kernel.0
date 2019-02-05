Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22125C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:24:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A2D2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XVvYwLSA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwfMNv/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A2D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U2HvM14/8o2SnO6gbRnt1y0tbW6bS5RIYTdtxWlYoaw=; b=XVvYwLSAoQchRj
	+Wqax3UniHLWQ78TdqFF/no1D6jk0M4m/Hiyv6Ugz6o182mTVSFuB8ZWS+NXipaQetEAYeeUdvNIx
	tTkAgK0JKswTO7yJHyCwBmQOTg1GctpwlXmc5xRH1v/wpZ+NJcaYojs9UmxN8HbfZRVgTAnTdmWqJ
	bBMHWZjkRdPDgAUQHAubdRJSPxVZtP4Z4JvBOiWJwEpdn/EHBikU9oNiEloIsZJGpPOvnxt8UWA2P
	VaFV3QwazbjrExj9dL0LxWBDVgNUvdlWD6TW/GNMxSHkJ/HbcGXghrBZ+wPKtqtNnDv9597J43O5c
	CzsdW8xpIusqMyljK3GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr6KS-0008HO-Tg; Tue, 05 Feb 2019 19:24:20 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr6KO-0008G5-HI
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 19:24:18 +0000
Received: by mail-pl1-x643.google.com with SMTP id e5so1938409plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0IpBC4OloPlMLmUVkvUYfF8AnMCmz/A1YcJcCSC31cA=;
 b=kwfMNv/G/JGCA2aAGP/lKCLGziS7+iyMxXgbHWYnfOnKG7DfHlVMyRXp8TKmMgs5rn
 41vHiQ6QydH/yRbWd+Aq4w0fQpeugdrv6llBv3SSTXW1ajA+VB4s7nqrv/f03C/Zpgx5
 ZAmZa6hlowBe+Gl1RMGKMrfVxyNksXos4tq8KrxQQp/EV2/9dVXaqvCrfkGWL+CC98I5
 EKaxQ6F+87lAlPSqnuAVm9mVjpiPne2YL3bSd9uV+Y3NMq9V3rRUNtOkK/ZJQojRhGl/
 SG6ObbutF6r1ivexqaB1/xyb1VYY+x04K4UwnrrW58TV8DlUk+I7LTABwJWmbACZgMg/
 WFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0IpBC4OloPlMLmUVkvUYfF8AnMCmz/A1YcJcCSC31cA=;
 b=j3ksQsRI+iNW/LdauJ1wqWYHqpUkkp7fLjTGsp8s4mdBRuc8BA10dDqhHvU6dm5v57
 18h4UytbG8hRmyWWz/wHm203AeZ9FBk0Hs/q9krhpz4ttSXYVt8Lc/mcJ0RD4zEn5wtv
 o9tGu1aIZ6ZIhFwYTL0iQaFPAcEoLOF0lBqW8SDERhChNQ7j6tCbAhIH5HfcYFVHPRMg
 EGSPmD35FOvxV4DW9Pag5Ze1MxqLOz0crvZQUfFNSDpQa6EWqLKiA2aZ+RHVdJBK6UhW
 nYMrfb0m6YskBEn0R9d0DZ4kLBPKYxroQgCidtxmTvHLn+davNQCJ5JX9qoaol/ZPoOt
 399Q==
X-Gm-Message-State: AHQUAuZUZMBZgeydwuuUpv+wkmBNsaJ9dVizmkIpPPoYjFhIbNZU5ntL
 8TLyHA3vJ4UXTQTtxjwx5Yz8dA==
X-Google-Smtp-Source: AHgI3IYBIFeXO4IjapHd9eSoVRE5BNWG2bXKQ6dEz3Nf0WFzp3jYwOJio9Nr6P3C93299yNBhPap4w==
X-Received: by 2002:a17:902:2c83:: with SMTP id
 n3mr6765446plb.104.1549394655485; 
 Tue, 05 Feb 2019 11:24:15 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id z1sm5401719pfi.155.2019.02.05.11.24.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 11:24:14 -0800 (PST)
Date: Tue, 5 Feb 2019 11:24:12 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED
 labels
Message-ID: <20190205192412.GG31919@minitux>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-8-manivannan.sadhasivam@linaro.org>
 <20181221023554.GB3233@Mani-XPS-13-9360>
 <CAP71WjzWiCg-NXDnh58N-5O7kvNj+DDndSK04DeoPxFE2L8W0g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAP71WjzWiCg-NXDnh58N-5O7kvNj+DDndSK04DeoPxFE2L8W0g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_112416_582411_CA47A119 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, linux-rockchip@lists.infradead.org,
 Koen Kooi <koen.kooi@linaro.org>, linux-leds@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue 05 Feb 11:00 PST 2019, Nicolas Dechesne wrote:

> Hey Mani,
> 
> thanks for sending this out, it should have been just like that in the
> first place ;)
> 

Thanks Nico for the confirmation, I will queue this for v5.2

Regards,
Bjorn

> On Fri, Dec 21, 2018 at 3:36 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Oct 29, 2018 at 03:12:45PM +0530, Manivannan Sadhasivam wrote:
> > > For all 96Boards, the following standard is used for onboard LEDs.
> > >
> > > green:user1  default-trigger: heartbeat
> > > green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> > > green:user3  default-trigger: mmc1 (SD-card)
> > > green:user4  default-trigger: none, panic-indicator
> > > yellow:wlan  default-trigger: phy0tx
> > > blue:bt      default-trigger: hci0-power
> > >
> > > So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> > > one of the 96Boards CE platform.
> > >
> >
> > Hello,
> >
> > Any update on this patch?
> 
> Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> 
> >
> > Regards,
> > Mani
> >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > index 46feedf7c989..35f95154316b 100644
> > > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > > @@ -300,28 +300,28 @@
> > >                       compatible = "gpio-leds";
> > >
> > >                       led@1 {
> > > -                             label = "apq8016-sbc:green:user1";
> > > +                             label = "green:user1";
> > >                               gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "heartbeat";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@2 {
> > > -                             label = "apq8016-sbc:green:user2";
> > > +                             label = "green:user2";
> > >                               gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "mmc0";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@3 {
> > > -                             label = "apq8016-sbc:green:user3";
> > > +                             label = "green:user3";
> > >                               gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "mmc1";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@4 {
> > > -                             label = "apq8016-sbc:green:user4";
> > > +                             label = "green:user4";
> > >                               gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "none";
> > >                               panic-indicator;
> > > @@ -329,14 +329,14 @@
> > >                       };
> > >
> > >                       led@5 {
> > > -                             label = "apq8016-sbc:yellow:wlan";
> > > +                             label = "yellow:wlan";
> > >                               gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "phy0tx";
> > >                               default-state = "off";
> > >                       };
> > >
> > >                       led@6 {
> > > -                             label = "apq8016-sbc:blue:bt";
> > > +                             label = "blue:bt";
> > >                               gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> > >                               linux,default-trigger = "bluetooth-power";
> > >                               default-state = "off";
> > > --
> > > 2.17.1
> > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
