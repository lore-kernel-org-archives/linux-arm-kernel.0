Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35080C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:51:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0513C20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqvkMA9e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc4Oc2Pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0513C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FEqa7pP6ggD2DLrF8IMy5vbK+iCeCJfTXoyQb9wsX+A=; b=WqvkMA9e2hLs0N
	A2SaQh087Ib7b4y5aE2Lad3VBv7MsC+eBc44Sl9RZ4mWL7xVP/VU1ZiFu8ZfIGVU/H28hBpBbLHuW
	xZhrdbhWo3YLtUj6M9OTthcE+foGntyw4qtP8e5l70umc5MGEjaJytYhwnXVjpvFU0LNZcZl4HF0n
	B/eTBY4JweQj96IS6t+elUbTOgFC4QMu6RpMAJBwZMCLje9/vRDHuH7oiEfDe0QLczAbFCnWeUhuA
	0emRR0BxZ/YpfvEsxkOPavNsNXhqAtjz6RNvB00gQ7eCqPmHuvO+tdkkHUqF5UojPcmNWlw2DiMdk
	LBp9bCGUNqB9x5wJZipA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkDh2-0001Pt-Fl; Thu, 17 Jan 2019 19:51:12 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkDgz-0001PY-3s
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:51:10 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so4887501pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6DS9RQTA+4Ktfge5ckQFdetrHudMskS10urd1IsirZ8=;
 b=Pc4Oc2Pp9s7Nw6BYVsl7aeTy466/3vMUF+RtahMFXcW8B+rWX6Pi1v6wJYQ1KdwMzL
 BRcN+uubDtfqyUwxfPyOGwcjcugA015JpSvKVSkIbdp5CDQmpyWjGacMCwiWyGY6+ZLw
 nIna4elN/BRqkiH6nrQS+DL1DQ2QdqwQXO2jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6DS9RQTA+4Ktfge5ckQFdetrHudMskS10urd1IsirZ8=;
 b=sxtKO3sQRp3RJm3ZfNkyUIFRdm+I8wPP//azgAIkVbD8Ehmv2VdKDkVTebq6Nspo22
 jh0MyrQv9pgPf4kCVFfBpKPMYWrwkgboi5Op6UHuAUNwbveXSR6s5rNyKCJpBjtgh70L
 vShtABtpUMxD5DkFj2ygLWrlwGIEjijQPKU6UfZFnMjtbVCdYhkPp5yBK8SjynAYhp6o
 K7iXPAlXP3WCgRAqej22NNb5YcxG0yKaKNyur2cULY+reslvf7LNeJ14ZaAi2dIwzaVb
 xHx9Xwi0h+toCHoTc9YSeHd54LYBZthNCTkXgAsmJyX6b0HiKweXJrpGS5FCLSX4b6lu
 TfuQ==
X-Gm-Message-State: AJcUukeZaS053erBYzyqGb2nsu7Ubbcuvjp39nk/ShxJjy8h+2ZQVoer
 Z+hoEQO1cNAvgWC+cpCPNCS7kciUoWE=
X-Google-Smtp-Source: ALg8bN4yUaDo3Y1Qwr7QzVvI/i6OBW+8V9dF16/hOMTNEeu/jyDsdqx2yex9KgMtfY0hGMqSE6hzzQ==
X-Received: by 2002:a63:86c1:: with SMTP id
 x184mr14500516pgd.305.1547754667432; 
 Thu, 17 Jan 2019 11:51:07 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h8sm2517901pgv.27.2019.01.17.11.51.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 11:51:06 -0800 (PST)
Date: Thu, 17 Jan 2019 11:50:27 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190117195027.GA12955@builder>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190113072319.GB28907@builder>
 <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_115109_179691_78D0672D 
X-CRM114-Status: GOOD (  18.82  )
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
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue 15 Jan 08:27 PST 2019, Sai Prakash Ranjan wrote:

> Hi Bjorn,
> 
> Thanks for the review. Please find my comments inline.
> 
> On 1/13/2019 12:53 PM, Bjorn Andersson wrote:
> > On Wed 09 Jan 09:46 PST 2019, Sai Prakash Ranjan wrote:
> > 
> > > Add coresight components found on Qualcomm SDM845 SoC.
> > > 
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > 
> > Hi Sai,
> > 
> > The content of this patch looks good, but please fold it into
> > sdm845.dtsi (keep the nodes sorted by address).
> > 
> 
> I had looked at the sample from hi6220 for coresight and
> decided to keep sdm845 coresight dtsi in separate file as it
> would look much cleaner than mixing it with main dtsi file.
> Also I guess it would make coresight topology more understandable
> if we keep it separately (plus there are about 400+ lines of coresight
> dt entries). Is there any reason for wanting coresight entries merged
> into sdm845.dtsi file? If you still prefer it, I can make the
> change in the next version.
> 

There seems to be some variations of this, but we try to keep everything
sorted in sdm845.dtsi to avoid having to jump around between the various
files. So please merge it into sdm845.dtsi (sorted by address).

Regards,
Bjorn

> > And mention below the --- that this depends on my AMBA bus pclk change
> > and include the URL:
> > 
> > https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> > 
> 
> I had mentioned this dependency in the cover letter. But I suppose
> I can mention it here as well.
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
