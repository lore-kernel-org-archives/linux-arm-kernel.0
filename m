Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6766CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382F32087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cg32dajt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382F32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NWzBjTr8gek2sxGtON1Z/xo94shcCFEfwdpP2+B2oBU=; b=Cg32dajtKP+kKn
	We6IhTo2QjvPorGZg1UMGCPWB912/B8w1bmpwvC9QOdw+EefXDAJd3yu/2qyXp428DVUrAZWhslzV
	Ex876EkVHGB60FlBlzY9cWF4EpKIJAhY54ozayKgkzCrFjAQn5UxY+DcRhJWO6oz80IvJSvWD8cW0
	w+KVetnen4SSfqUmKRdhehT/c5g0Y2umdV7KVtUPN4YeVITgzF/tE9eO7BGc+TEKMVaaex7Pm0xF3
	NekLzkXW9hKl4T/KKG8GulOHxqTOT7wE9BU91iaR91uW9w9YREuHNqZqZJIvUq9sWHLrvMoUDu+yC
	TO/JZxuLaTME8N/sGLSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU997-0007N4-3f; Tue, 04 Dec 2018 11:45:45 +0000
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU994-0007Lq-Ho
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:45:44 +0000
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so14605390lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9lyH6tyDnPML3RDDJuGI/lJe2+4NHy67zfhOq9Tt+Hc=;
 b=r6QCjoVxo2z5PzQq2oZxRlfpg1GhQpmWjXOLRD0cfV8J3SEZk+vVUSVEvr/ENfZgcJ
 vKMQ+djADUrX+XDpf1LeVvdjo3TftSqnlLzGifpsKtQynUtO6DHeVhE1g8YJyWOJxz28
 kQ9ksi3mRo+H37pXirYyu96ys5nDKqaNuLlC0/cbxNnFvDri9R3uxwzeJYvtIceq+VIt
 ht8ATQ/T5HvffbZyvSryWXC7mK/g+t30OKhNsbIo9ENYJ6dujar4dta+bmhA7YOFJnwk
 YCLGOk70FDs86T7oiC61BfuhQ+wCFyrdfMwFfqneDbwd7T/yk9h42cobMb3agyY/cVid
 bGxg==
X-Gm-Message-State: AA+aEWa9cB2GEDCI3q3L3Gn2QPts356AtLd1IZnkqCEEyH5MKD63mJjR
 zYC6HgRZvmKJecdio4dwo00=
X-Google-Smtp-Source: AFSGD/XASlqggDkini/davVrrJ/kWhZDrlA7co2DQulhti4C5FWny9V3epSYvazwOutGQt9IM3FicA==
X-Received: by 2002:a2e:55d3:: with SMTP id
 g80-v6mr13915624lje.78.1543923930534; 
 Tue, 04 Dec 2018 03:45:30 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id e14-v6sm3011099ljb.31.2018.12.04.03.45.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:45:29 -0800 (PST)
Date: Tue, 4 Dec 2018 13:45:27 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com
Subject: Re: [PATCH v6 00/10] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181204114527.GC31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_034542_591249_2FB25C37 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 01:31:43PM +0200, Matti Vaittinen wrote:
> Series add bd71837/bd71837 PMIC clock support + managed interfaces

> Changed drivers are:
> clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
> and apcs-msm8916. New driver is clk-bd718x7
> 
> Changelog (for this series) v6
> - Drop 'devm_of_clk_add_parent_hw_provider'. Change
>   'devm_of_clk_add_hw_provider' to look the parent device node for
>   provider information if device's own node does not contain
>   #clock-cells - property.
 
Forgot to mention the obvious - I did also convert the call to
devm_of_clk_add_parent_hw_provider to call to devm_of_clk_add_hw_provider
from all drivers where I had this new call added.

I kept Reviewed-by and Acked-by tags from Peter Ujfalusi and Krzysztof
Kozlowski as the devm_of_clk_add_hw_provider should now do same thing
as devm_of_clk_add_parent_hw_provider did. Please let me know if this
is not Ok.

Br,
	Matti Vaittinen

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
