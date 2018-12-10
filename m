Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:33:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9959E20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h1DesJM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9959E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XM0RX6VpSKgehdr3dcg+KPxoUN9Tm4C3vehtrcL0Zdk=; b=h1DesJM9Jk+idd
	iwtxOy3z4e2D47aG8+JygG2APEincZl1WhRMN/d0XQ3xY3o79eft2VVNI/S4fT9Zu/Ut8lno/lsaV
	lffX0g7pEdBM68kquR4NhEJM82mzJ7UgtEHRLgM9sDMZZPiUQJE04Ido6gqUWpJUCFu1Gy5dYvo+6
	4UYOeWWr2Yk1nvo88+aIvZStakystMXps6/V3KAg85tz5sEHxEUD1lfxZdWjAzosqKHToJfv5hz+M
	RpAopUUgVRHW74oXDJSMc9kySpr/BL3A6dNrpVDPNaSNHlUDA4acCYW5eV2N4bDlrocSCDjdMiBpV
	QREMLSl4cxRNzogylFEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWU7N-0000Cu-VI; Mon, 10 Dec 2018 22:33:37 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWU7L-0000Al-Ca
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:33:36 +0000
Received: by mail-oi1-f194.google.com with SMTP id v6so10441819oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 14:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yfwr3ceJXdWZ5pAW5Q1dV5iAmfUilIgFOg2s3h330Oc=;
 b=Q7J7eUj+nTZPDVREvhfyhXhXJCSXwkg3TFlVWZm54CfcS32gPrwTqtlu1EPwmatjUQ
 WJr9znZdHybUpnBekxmBDPgvnoV96eaurEsnO4GPe5q7xZiwglGxwH1PPfyf1xeJGEed
 Eb4tOJkvGimnEGhlbOmAuvmSZfltqRzKaehUfbT6EC0hf2QgDyVHhqb7TBlnowXjQppr
 nhffnoAZTwdQZnaCIVs+BoYAUnX2Pk/Ry8gfUjpl23ymqrFK6tqI8oOKZSgRL+Du+4GT
 AnEHiJYwTqJoejSmoGqrZ92u8aYlyI5C1iqY82p5sn9ZadxG5fz1esO8bUnEibDH8mkw
 zG4A==
X-Gm-Message-State: AA+aEWb9EIpcWBopYOYxVM/CdQjtaLMvrhRwLa9YdF2e/xLn1sHm6ap0
 ct7U348+ZfZueacWzPyIHj977QM=
X-Google-Smtp-Source: AFSGD/XZxAZfcYGBIjAdtZHteUa2XJ0kK/XKcdhdLN3eo1D0xiUOzguYYpbfT5kvWQoQ7gdYdr3Xmg==
X-Received: by 2002:aca:c649:: with SMTP id w70mr8768116oif.186.1544481204328; 
 Mon, 10 Dec 2018 14:33:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b18sm5675330otl.33.2018.12.10.14.33.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:33:23 -0800 (PST)
Date: Mon, 10 Dec 2018 16:33:22 -0600
From: Rob Herring <robh@kernel.org>
To: Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
Message-ID: <20181210223322.GA16266@bogus>
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204165248.17572-6-k.konieczny@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_143335_424508_E080DB1C 
X-CRM114-Status: GOOD (  12.85  )
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
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 05:52:48PM +0100, Kamil Konieczny wrote:
> Add imem clocks for exynos5433. This will enable to use crypto Security
> SubSystem (in short SSS) and SlimSSS IP blocks.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c   | 193 +++++++++++++++++++++++++
>  include/dt-bindings/clock/exynos5433.h |  55 +++++++
>  2 files changed, 248 insertions(+)

Lots of trailing whitespace checkpatch errors...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
