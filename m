Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBCC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:15:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315822082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzRxu2Mj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MX7j765x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315822082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Og0STf7cZt4a+22HejIZkALey7Iboh8Gnb51a9uIzTc=; b=tzRxu2Mj5Fqqv1
	JJv0b/sLOmarHqI2KYTPsNDgKkiFN8K4ii2ds3i+cVO3Ej6HabRVe0iCnKT5Vbb1HywBnBHgT26eV
	fpvdD43Ky6KYeN6o3K4s3uLe4RPQcaJhTX17ohFMQlZe1EM/99imLzrrKmdcf2UxpWMezLw1eybjl
	XzwNEa1gDNDqEurdNW9+XbSXQ6MXyUP/Qf7vmUm9qBl7ZGdO2NgecaN3+fss8pEany5eCdEc/a2jc
	BID8L35eHumCpt4Uod5mGPa5DPzkRlO7fUN/ZgRf8pYPGhnHsJNj+BRZQhOt0x5zczcSyAXelAkSQ
	7Jfpn6GAXUHoaiO59KGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goAVJ-0003J1-8X; Mon, 28 Jan 2019 17:15:25 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goAVF-0003Ia-80
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 17:15:22 +0000
Received: by mail-io1-xd2d.google.com with SMTP id s8so14060760iob.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 09:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GJcn9kYU/AQaSnYIJH1yOu/x3oyA8p3f6PabnA3K9Go=;
 b=MX7j765xGygoNiqtKATWq2ZZO8g0fkTuLtxFcXKEAxmwz2hl070/FOUsdikcWeVL+f
 R6d30vCgyPqDIso+pHRJ6dIYavigaLSVjHZalE47QAX6QIdfaXpLf19QYW+zVj2GqEB2
 SdF/2gPsacj9TKRNKOGUIVgIYOIeY4KDYopa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GJcn9kYU/AQaSnYIJH1yOu/x3oyA8p3f6PabnA3K9Go=;
 b=ccF3Thiqu5h5+RCRJsLlihMpC8P8UE3+ugH1XED5l1MHunhjt5K50UPCPUa1x7zjp7
 Gh+qtpQv4hTxNtxzUit1smH2+efVaoA4L/oo7a//jY/5mkPQAwkU4gn902VzmsZzae31
 kBrykCZINF46ExxDL+O8oi0nhlsuKJi9OD6bjceaPu4kwSpZXMCYLh+dVSm0KW6cS5/a
 EXKk+W0/3pUFSnEnZ1Y52a+XihsrWN3stVba1xBxkYStTqVrgbuhP4+0KsbnsaRfwkBF
 9TqzV/ST0Gfam78SavDq/Rsx83jr0hyey9yGZZCf2uj8PE15cbnQSKcHgMxvjn+8j4d9
 M0nQ==
X-Gm-Message-State: AHQUAuZphO/oARIzhrGFn72WjVzNa0O1Uve9/eya5VO5l84LgWuAnBVh
 hd/QR+MHZYyoAAYQ/A0SsRChsv7FOXLbtURx5ZtE9Q==
X-Google-Smtp-Source: ALg8bN5VQS/ag0QJRXz//V3QknxsXh6P9sw/Mk6J5kcq9gldc5/lkq9bzSb2+CeaNsm4DmTCOHS4AkK510SnHwP6tDI=
X-Received: by 2002:a5d:960e:: with SMTP id w14mr12108243iol.86.1548695719439; 
 Mon, 28 Jan 2019 09:15:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
 <18b70426-60fe-4871-6388-6e09fd5feb37@arm.com>
 <de6e021a-4f9a-8e2e-dff0-1e7c61ad8b2b@codeaurora.org>
In-Reply-To: <de6e021a-4f9a-8e2e-dff0-1e7c61ad8b2b@codeaurora.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 28 Jan 2019 10:15:08 -0700
Message-ID: <CANLsYkxkTTfTMNNZZ1tmS=cjakcfveMDrW6wxXPXie8M9_VDOg@mail.gmail.com>
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_091521_341019_7E3A5CCF 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 John Horley <John.Horley@arm.com>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 11:21, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Suzuki,
>
> On 1/24/2019 4:49 PM, Suzuki K Poulose wrote:
> > Hi Sai,
> >
> >
> > That looks fine with me. But as Mathieu said, this needs to be a separate
> > patch. But before all that please could you provide me the PIDR4 value for
> > the Kryo A75 and A55 please ?
> >
>
> Sure.
>
> PIDR4 value is 0x4.
>
> I get it now. So we are looking for JEP106 identification(PIDR1[7:4] and
> PIDR2[2:0]) and continuation code(PIDR4[3:0]).
>
>  From ARM Coresight Spec:
>
> DES_0, PIDR1 bits[7:4] JEP106 identification code bits[3:0].
> DES_1, PIDR2 bits[2:0] JEP106 identification code bits[6:4].
> DES_2, PIDR4 bits[3:0] JEP106 continuation code.
>
> For SDM845(A75 based):
>
> *0xB_B8_03* does indicate that the JEP106 identification
> code is 0x3B and continuation code is 0x4 which is of ARM and not
> QCOM(JEP106 ID is 0x70) which is expected.
>
> And the other values of PIDR0[0:7] and PIDR1[3:0] are *Implementation
> defined part numbers* and can be different from ARM A75/A55.
>
> I think this clears up case for SDM845.
>
> As for MSM8996, it is not based on any ARM derivative and hence the
> JEP106 ID is of QCOM(0x70) from the value of pid = *0xF_02_11*
> based on PIDR1[7:4] and PIDR2[2:0]. This clears this as well.
>
> Please correct me if I am wrong and also let me know if I can
> continue with PID addition to table.

Please proceed.

>
> Thanks,
> Sai
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
