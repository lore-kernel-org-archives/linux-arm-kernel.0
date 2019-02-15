Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04355C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91FB21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T117mfRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91FB21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yfWWCAOqmpUp2ZPCumcZWqfc8T+1HsEziQ9vn0s864w=; b=T117mfRIob+ZlJ
	25spmO67D9MVlFZmftwqIaAg3dn51Ob6xPckiLtYolYf5RbxZ8Z6Mc7ffPdL5Ga9gBt9ef85+p/A5
	P4YfaH4x/gCsszfNjxZ//UESLFwLpEaA9hVUly9L/z9xAM27AcRSDkbYge8lRefe4JfxTT64VXbz1
	wOiKZNzIlovW0WxdDiduDuhxlQC8A4q5oZpWENeXvOmg+hejEMuN1XLg3AUK3BzTgKUOppco8knBT
	n50CZo1OJq5yPCFFLyBL2hu1W9b8XW7xoVPFXIxKU1xyU8yTaytwJEyrSfFl/UL/KqSNwC8CDZvFW
	VNNI51P7xmMfH9ws/3FQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugBE-0004RA-Kd; Fri, 15 Feb 2019 16:17:36 +0000
Received: from mail-qt1-f171.google.com ([209.85.160.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugBC-0004Qm-AA
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:17:35 +0000
Received: by mail-qt1-f171.google.com with SMTP id v10so11451679qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 08:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A6/BpJuLKEv8Wj0JYOau5ZkmQWEoHZlEV7QxEev32Ps=;
 b=ZbCUCylkfzckXuqmdgZfeK5Fi24/Ygqe8mWq1wEHAtNxSFQI1ngdCYNG3sDOQe8WEb
 lfgDU0xwEBAdiI3C50WHai/59DJhyINTasAu05jQ67UQ/eFk0LRYIoaiHkF6+3et54oH
 YUkMvAdkjz03hfHqVg3TzGH//QFMhQaY+pHXXAirZ8v5KjGgjizgn08CHg50XNY8YKd1
 JJisro+I8DRiwsoaBR5foe4HMp1//q77/s1haOxwEMGLSbyoelQOmCarOtnz70efM4zp
 btygSzIaAAfKeFvOAg1kgAuxyFXm4WPF1xSmyOpuYAMJlrt2m7VPSSQwvYiZsqPRIaVn
 B54A==
X-Gm-Message-State: AHQUAuas05S3COWtaKYEpiurENPSRBRVsFVr9XyYG1YwsaRAaKX1MXy1
 LkFN/6qAF4LJj2Fkkbm4ZtSRZB76JlJGM+uxK7g1dA==
X-Google-Smtp-Source: AHgI3IZpjf9MVXT0200kajy7cX7f7xrQp0Pms6u+pL35RNFSGa6SZtzgTcOcTtTtkAUisjC+ljQ2kmfgvRymc9EXkNU=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7865556qtm.96.1550247452344;
 Fri, 15 Feb 2019 08:17:32 -0800 (PST)
MIME-Version: 1.0
References: <9c5f9835-d9ad-a168-7e3f-b71fd6cfda29@monstr.eu>
In-Reply-To: <9c5f9835-d9ad-a168-7e3f-b71fd6cfda29@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 17:17:15 +0100
Message-ID: <CAK8P3a3ANyAASE9qQutoWYhSi+W4sBd018YCtk+NyGLdbDfEmg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: Xilinx ZynqMP SoC changes for v5.1
To: Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_081734_350002_CE02B6E6 
X-CRM114-Status: UNSURE (   8.05  )
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
Cc: arm-soc <arm@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 2:10 PM Michal Simek <monstr@monstr.eu> wrote:

> ----------------------------------------------------------------
> arm64: zynqmp: SoC changes for v5.1
>
> - Extend firmware interface with reset, nvmem,
>   power management and power domain support
>
> - Add reset, nvmem driver, power management and
>   power domain drivers

Pulled into arm/drivers, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
