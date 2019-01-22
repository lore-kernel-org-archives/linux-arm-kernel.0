Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55884C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169F4217F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HYm7qjdo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apr1Ap8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169F4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gmqylqTS5wrvUmd/upo3SOQhNNmoG+UuYQHkcJopp90=; b=HYm7qjdoVdJgkI
	2PihxxJUaEtJYZoV4QOAeNV0fpOpA+fPzDcQcptQaZ70FVOCXtFN+7zBIK5Un5l2xvp9+fOUiciqt
	L+79Z9bJikYRvWk0meUyL9LAtkwrpmWRURa10eFUmLkaZ74WkneD0m6/EwRpMryI+CITwJlolH/km
	GSwDrVZlMOVHfGK3MOZmHAws958edlbfjUkev+JdEGIvskMIc3u/L5H/v4D2EeKAnqeMW6UwDSJWM
	dTCbBcOl26ejtkoyLwhO6mHJoGa5iMU/HHsLrwgGve8uMsit1xOnMQti9PbvYInahZo2LFgTj60kf
	HZK6wb66fMHLUKpm33uA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glyAP-00068E-HA; Tue, 22 Jan 2019 15:40:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glyAL-00066t-3K
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 15:40:43 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96902217F5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548171640;
 bh=B2XFXAWSrodLlyMYuL3pcYBGQlu1ddIEURSRi5qMhME=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Apr1Ap8Fw0l8pFNdSLb7Unhsmb3eWCvuQcCQfFTqBKtaD1CvRYyOjt35xS/nwUVXi
 l59l2E1UBkhg099+ZQhABVVH7zSaVV2/I9mi+CbtcaJdsO4UWBdBoIk0GNfJHPmhhg
 EUJCLaJ3I4iKWykBtOXWxIN+72X08dpXRAbk74vQ=
Received: by mail-qt1-f173.google.com with SMTP id i7so27993702qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 07:40:40 -0800 (PST)
X-Gm-Message-State: AJcUukeXI0LjmSK2CdgUcuYE9IrqAvPGZ1naygfAWs4n0jfLv/xd4m0N
 1588EdhPDXTiNQ/4khanXb425589S/IWPoW1xQ==
X-Google-Smtp-Source: ALg8bN7u9VzInwA+up54dRdt1EDxNbFttwJEDD4AxCVTSRhzj835gxCLUeBq6LeajKuGVRcdcdOgkwzjzmFvdA9PfK0=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr30675063qvl.77.1548171639855; 
 Tue, 22 Jan 2019 07:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
 <20190122042147.5424-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190122042147.5424-5-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 22 Jan 2019 09:40:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_bG5=LA0FedY9EAgP=4hww-JJ06XwqTrj3mTOyN9Xwg@mail.gmail.com>
Message-ID: <CAL_JsqJ_bG5=LA0FedY9EAgP=4hww-JJ06XwqTrj3mTOyN9Xwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: arm: fsl: Add devicetree binding for
 Oxalis
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_074041_186782_BD4E7397 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 10:22 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree binding for LS1012A SoC based Oxalis board.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
