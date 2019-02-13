Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1216C0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:07:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02DE218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iiF/yGBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02DE218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fMRgehj0r6dOsmoHcu5KTD28mBQ1wEwzilryGn0uveI=; b=iiF/yGBrGMH/FR
	Wj1bz98bgGqFqtalYLJq080+efIOMDtOuzJBdpCObuO+DnRq5rGVe9a0J/It7+OM4AxfOlmxeBcSc
	xxfEai+9rtjtch5Ezfm+ALK6w1CcGub6yuk5oaYwCPcn9uQXoyiQojuGYqUvi2jjcTrgUESLkebTs
	QnRve5epBkgUGfRXw0y6SW47B0eeXqMhtM7gy0bhA3siBkQTNGnbe48agdgYA6Xo4p3/o82kwIKr5
	VYNbeEj9ZaO11ndXv24qhzepo1gkheESK3PJ1wyTOsZoQS7WGammM179FB4RDbW3Y1IDY5cbKJ5Fb
	IMoXZz5fUPnhKDWEB1rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu1l2-0008RE-J7; Wed, 13 Feb 2019 21:07:52 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu1kz-0008Qo-9a
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:07:50 +0000
Received: by mail-ot1-f66.google.com with SMTP id w25so6730564otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yVq6qd0CDAm/lBJzXv+lqJKV0+gBxOcHBTedAUe3rvI=;
 b=POzIb12Fq8HKyKQbRWx/0RSU9Maw0soWRxfAQYUewpLzJNEiD3btxiA0CDRA9M76Cs
 VD1vWMXhOLHqaxzzhZORD5mvWCW2CwnSqF9/23PwLlB2OFXQKNro9o6/+u6lIDQgDERV
 Dw0XpS1nz2aNfe7VZGfnx7lDxnvoYy1L22483UyEKYp0mAQ3ho6+UtZFWeMOrasJSpG0
 YPThQGwsBrrfB4S/1cd7v2zvGycTYfW7hP3qsJWNkyn0TBeXgqp2Q672bKAZEgglnHxE
 Y8sTYK4reP+MA8nuduuPzjw1J5blHiKeBGv7gjo9VTpMl9XC4mqgkbhYN221DQiu2h2+
 lwRQ==
X-Gm-Message-State: AHQUAuaWRPIl3wwhgPqk1XdWIh4+sG5fimfqJXofUEEyaDofEky5GMei
 L2M7ubx7H/udbwCJv5Al9Q==
X-Google-Smtp-Source: AHgI3IbgR2jM34wgdgRHvoHSBF9qY7OqQ10nfGKLD3iRPAtE/E03+APfYxrIV5QPSnpH81C9vYfFOQ==
X-Received: by 2002:aca:c443:: with SMTP id u64mr116265oif.136.1550092068287; 
 Wed, 13 Feb 2019 13:07:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m26sm168372otl.32.2019.02.13.13.07.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:07:47 -0800 (PST)
Date: Wed, 13 Feb 2019 15:07:46 -0600
From: Rob Herring <robh@kernel.org>
To: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v4 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Message-ID: <20190213210746.GA2989@bogus>
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47@eucas1p1.samsung.com>
 <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_130749_331945_7ECA8E3F 
X-CRM114-Status: GOOD (  11.62  )
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
 linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org,
 cw00.choi@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org,
 myungjoo.ham@samsung.com, s.nawrocki@samsung.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 05:46:45PM +0100, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
