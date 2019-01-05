Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:34:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A5020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wnrq6/X5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8GTCkj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A5020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P5hejxxhKZYfyKNmAUh6aqPDcPM462XYdGsdNuTWDeY=; b=Wnrq6/X5jGjmRY
	r4v3fJK8SRPNh96VZWXQWNGUggdvqeAmcYBHujAJi7uFTJm4VaLJ55lYPubOeOaMxt/s+/7DZ4z5h
	LMUtTzI7wROScHnbHUK5WJOS/GaUqwfmEILqnHq2h0B/66e5EFiDIXvTRUQIp+Sp2xqHkCcCp58ku
	MQggrG3H72hyiYNGQkSQn9nDOXjfaLqCDGdExItwf0e8HbYNLp8bHuL/+UEjRUZPs20+T9Xbee1IH
	rhdEHkb9yHdKEqodQ7p/375e2NqatAzMAYRGSXD+ydXtEzLn9xr/VjfMNI0v/mQfN0MWqgBXIMn/G
	+Z4whTldGGNt01uLQJiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfdfI-0006ab-56; Sat, 05 Jan 2019 04:34:28 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfdfE-0006a2-MH
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 04:34:26 +0000
Received: by mail-wr1-x441.google.com with SMTP id p4so38239298wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 20:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQBlCadZCOotC7WcWUZWM/qHn03LQdG+fqIY9Ks3MnU=;
 b=K8GTCkj75/GqtULaOsxpp+gENtKPSfr/Y/tfM9cobdIs/fZlwWGQydpeyE3fRcYqhR
 P5PNy/OjWenoLv+Lria3qNVncmHLQwuh7oLRdk0IjTuaqtzqPtvBLUoxvAbNhH0aOZyd
 7RHu76+IqsRdbeNWL3p9bm9SiGr7Nq6PqurAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQBlCadZCOotC7WcWUZWM/qHn03LQdG+fqIY9Ks3MnU=;
 b=aNWebI5G05XfreezlRNali00HZQYER4lXTgUK2lDPnUxBBz77JYwZtjh3HOi9w3DP9
 ysxhCQ8smmzNJktKdjouDoPktS8BZ5GHg1TyoEpGVxgJdgXwsakM84hpQmPKcvjqcEp+
 pSai2A304GZKDCCxWtv0x5Ln5WYopHGYaUtIVcKxhkJTvTOCfTZEQEbmAMuxS+B/ymxu
 WOH7z8JIfHIydDwbZyyt00k0a34yiwm6SFrGfBiWbNMWEoP5Ta0Kbd+hgaIf8kz/wxtC
 HydHpeanVXo29s0E7eqn3ympy/mgK34z6N8uvo7WdIUU9J09c3atHIhzND/ltS2I/iNp
 zbaA==
X-Gm-Message-State: AJcUuker4/W2pDfDvTbdLgMEu8LoMc08j7vmKoW25RBLVHLXvHZE0IWf
 biAJL5G2AoLAeMsmMK4uNj6yQKecAtcj5ZNFN+nLcg==
X-Google-Smtp-Source: ALg8bN5uj/KAjavJwr/gTLPWp3pYg7X5NMl4VgeSAD26OrEIEX+1Yw9SC74EOHKzblMNyp6Gef4Lwfh/T8wE3QN7+rk=
X-Received: by 2002:adf:c108:: with SMTP id r8mr47951498wre.233.1546662862430; 
 Fri, 04 Jan 2019 20:34:22 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
 <20190105034904.GD2477@Mani-XPS-13-9360>
In-Reply-To: <20190105034904.GD2477@Mani-XPS-13-9360>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 4 Jan 2019 20:34:09 -0800
Message-ID: <CALAqxLVGznbM8+rHHn8j_+m1P-E9+_jJNfRZKPVqF+pTQWG_Mg@mail.gmail.com>
Subject: Re: [PATCH 6/8 v2] arm64: dts: hi3660: Add dma to uart nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_203424_739011_042803BE 
X-CRM114-Status: GOOD (  16.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 7:49 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi John,
>
> On Fri, Jan 04, 2019 at 12:56:26PM -0800, John Stultz wrote:
> > Try to add DMA support to the uart nodes following
> > the assignments made in the dts from the victoria vendor kernel
> > here:
> > https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1
> >
> > Cc: Tanglei Han <hantanglei@huawei.com>
> > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > Cc: Ryan Grachek <ryan@edited.us>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Wei Xu <xuwei5@hisilicon.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index 20ae40d..aaa2b04 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -466,6 +466,8 @@
> >                       compatible = "arm,pl011", "arm,primecell";
> >                       reg = <0x0 0xfdf02000 0x0 0x1000>;
> >                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dma-names = "rx", "tx";
> > +                     dmas =  <&dma0 0 &dma0 1>;
>
> Usage of DMA channel 0 contradicts with the description provided in
> patch, "dma: k3dma: Add support to dma_avail_chan".

Hrm. Good point.  I'll double check w/ Dr Su on this, I'm not sure if
that inconsistency is due to the the vendor kernel (where these came
from) having different reserved channels or just something overlooked
if the uart0 is not actually being used (as we find on hikey960 as
well).

thanks
-john

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
