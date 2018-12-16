Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:13:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D450321836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uf7K66/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D450321836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qnsSJ1FN97yzjx/T5MptAjQdZ2R03T0zmMqoYCwe7hU=; b=Uf7K66/UZM6rwU
	Njb7pn4c42TJf6N9VDFiEBBoPmuno3EAZQDf52ITU9j+qvBUepOZm0WvPgfR3KkfZhJSkdCyV1HsT
	QP/6M2b7xZstBbe6M4OJBpdgCg9xy5vTrh2QN9S85AnhwOYTU3Q4cllo0OjC1j/fL8nd9dl67TyH1
	hkSe2PRigDUHgRMtKbx2+1+tT9zJpJnX0uRglYpsQ2mzpOtXRSneyfSnmlihkifkdSqc1Jescv3bQ
	KQQzwILzWakrQfXI6bXABp2PDH2bdvO9XXyElur5mQG/MNULQtsLORXvmzWdPliYnHH3QIQQU5PDQ
	iLLxnrdGkHPGexiCpKbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYSU0-0004ZF-Gu; Sun, 16 Dec 2018 09:13:08 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYSTv-0004Xn-UJ
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 09:13:06 +0000
Received: by mail-wm1-f65.google.com with SMTP id r24so2382615wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 01:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=4M2gNDDUepKT1HSc99zAnCDtL+xwmziOWA+NCTYJTyA=;
 b=OjYZPqJQ+VI3CG0f9c4ZmckIXV96MK/z1Mw0y57wfJPMFlp9gZQhng0EGObrIwTjkR
 1XzQsn2GMcttn1EENjfv+Lc7rnSw+upo14B6ItdJTfXuRYLBASthAGjE2DfhN+PQ7d+V
 N9yEYgMtkYLwnB/PpqDHT1OTYvkZ38HdpFbp2HYaC/BjRgyLGqIujYwadgMDuiGI3/03
 iS04PC8Z6bYrEPCJAI6tPb4d864aoc0kPUTUqifLnaeT6IvKAkAIfHR2QcACgcVvAbxG
 2eKt2TMALJWETmowr2niXaBRXn+Gd0Elgdl9qmMH3MKtHQEyw58wghVyLhUi8QlgexJw
 kaFA==
X-Gm-Message-State: AA+aEWYnWmLj6GIAu53ipohCeXJhG5Aj1U6AALSijbZuaPc8F+/S79OP
 ScKSdkzaTjpWEr8w2O0auvJHOFz1N6F0inQ5mqE=
X-Google-Smtp-Source: AFSGD/XilYU/IwXDpGykSspBC4E0fiH80B5fqsAmx/Yj9DSJhGsqeI062grMIRpcW7PZc5+SBqj6sm8hZvyWdjCAsM4=
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr7852074wmf.125.1544951570317; 
 Sun, 16 Dec 2018 01:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-6-robh@kernel.org>
In-Reply-To: <20181205195050.4759-6-robh@kernel.org>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Sun, 16 Dec 2018 18:12:11 +0900
Message-ID: <CAJ0PZbQRNGoKsMZjpwaemzpK677v0T5n6h9OtZMdd5UTvq-drA@mail.gmail.com>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_011303_976322_BCCD9B56 
X-CRM114-Status: GOOD (  11.90  )
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
Reply-To: myungjoo.ham@gmail.com
Cc: devicetree@vger.kernel.org,
 Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 4:54 AM Rob Herring <robh@kernel.org> wrote:
>
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

> ---
>  drivers/devfreq/devfreq-event.c     | 2 +-
>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
