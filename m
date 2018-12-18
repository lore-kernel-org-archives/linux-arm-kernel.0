Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:42:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41664218A5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QZ4i6jpE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9onnpKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41664218A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Subject:To:In-Reply-To:
	Message-ID:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MFutI1WQmREBj2SJhk72jI16fA0TVogfmr11BUtOIUs=; b=QZ4i6jpEWVTtyu
	Crxugref0CT/6jexo83qQHVkD/HJEuRsax54GhLnj44qLKei/Ja/UAprZbJSnPBzSaOu0s198cXq9
	yu4DmbLbhVfpMvL0Qa4TIEyV0R7QkpHERwjvK+UBjAsHVGGVlP7G1wgxdeJkXnarlHap0m0dz9uIP
	gJ3rzw8Q0ine+DQJUEsnZKlduylwyBMRh4JlGGOS/71ZMrjiTvmlgakFX6FscQAu/p9+PD8+//rFi
	ykm6lNzKjw1DvfKqLt8JsAlX7dAZxaO5vNT095Yf7lPAWQAur1blK7egLLImtCV8JRFjtQTWPbbka
	ggXG+Dlx+G5VEkhKajEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKKB-0005G3-6p; Tue, 18 Dec 2018 18:42:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKJp-0004pw-9r
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:42:22 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C246121841;
 Tue, 18 Dec 2018 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545158522;
 bh=Qwp3sC1y5c7gwI34LVa17FDHJQHAQC/1J1sRC92eF+I=;
 h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
 b=W9onnpKNE87UmNsOaN2dEU6NZ2bAoolcp23ApFPrY+/til53QB+7EADG0wXfkB0NN
 xHt7NFS6yMmC3SQ1jCF5WFWAn1h3fK42030BSeMsbOlmYON0vv9sx3P/gP+9sb+qTl
 yep0OSZtVJbGV3DgsZsEdCaEoeYCJ4+gEdQ4nD34=
MIME-Version: 1.0
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-10-josephl@nvidia.com>
Message-ID: <154515852208.238328.769742330440710710@swboyd.mtv.corp.google.com>
In-Reply-To: <20181218091232.23532-10-josephl@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>, Joseph Lo <josephl@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V3 09/20] clk: tegra: dfll: add CVB tables for Tegra210
From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 18 Dec 2018 10:42:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_104213_881711_550A509E 
X-CRM114-Status: UNSURE (   6.64  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Joseph Lo (2018-12-18 01:12:21)
> Add CVB tables with different chip characterization, so that we can
> generate the customize OPP table that suitable for different chips with
> different SKUs.
> 
> The parameter 'tune_high_min_millivolts' is first time introduced in
> this patch, which didn't use in the DFLL driver for clock and voltage
> tuning before. It will be used later when DFLL in high voltage range.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
