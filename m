Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3CAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:05:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AFD218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELn8qVwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AFD218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/mTnvyAz8TLndHiiLtW/uH6jY/PSIKgXvA1qg4tL4oQ=; b=ELn8qVwb/+Bmf3
	U5EmC0c95DVAr7dhv6qil5WIX8o6MpsXVBSCXwQTH0UxmdxuakaM2LwpuHZDqKmqUItxIRfNsIOoY
	ZW2BfZUZ6IKseokyrrsb4G44wLSc/YIjLVGC3j7FAsqKKIJtoLbiP0NeMXWzHdQcdjxLrfl363k5f
	i4DcescNUR9NmbJZMcfcobX2Kn8y6vMRWBHWdtjP1QAgEsRhU2G9v3mv+byoKKnWSO9ed+VJefdqf
	knf15R8NA1u9MMEcQ+V2K2wTzGHzui477WQiRYfN0/xQUmoAMQTf7e8hgIENhY61vrC2p/Rw1kKe7
	ZJfpN3I/Iiwers9DHFEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZcT1-0006Zk-88; Wed, 19 Dec 2018 14:04:55 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZcSy-0006YJ-Ct
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 14:04:53 +0000
Received: by mail-ot1-f68.google.com with SMTP id f18so19138283otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 06:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/+1iwZ1k09J4X6V9hU88xagJXDo8YzrEApBpau+WViU=;
 b=W5k73W20XhmR884tkdhUiFzaRVQ9QI8JnYitKyA9mtvOIR8ni0xWFgxA68NUUSqWkO
 S8ctJwgE5eiFgc7NXGoUZf/Fi0SWu2Xt2kKLIdlxQJxR8O0scVQS/nEupIdcMzuYVRLf
 6ecgwBpqcIytUWD67N7kcAJJB2OCMSbK/19s1NNnBiJodmipkV8QjzpYb4f4ew17HpvI
 2qcb3cH5RqZZ2gZlaVqvdCWYLTYR7KJ0UerzMj0myQVqz05sww4QBZWh4ilOtD7PBQ3e
 upkPVtTTPojDc9D91skSE9T2ZmQDS2WrLvsysJjtHSDT8Rzm6svaN9eWclGlWEkUg0np
 zF5g==
X-Gm-Message-State: AA+aEWZl1zULJL+Zxwe+eNjhWX+sSC+37tmjLxAlqyaNK6wIRNkGVIh1
 WaNbmsmoyvoAeL9xR44rUQ==
X-Google-Smtp-Source: AFSGD/WWh6dPcxJsDFkewPSdC4INOdBginIV9yDAw/W/qF6KfgqdRaJNwCFb94ed9d2faE9aByHSjw==
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr15886768otm.170.1545228280726; 
 Wed, 19 Dec 2018 06:04:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d5sm8586713oth.78.2018.12.19.06.04.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Dec 2018 06:04:39 -0800 (PST)
Date: Wed, 19 Dec 2018 08:04:39 -0600
From: Rob Herring <robh@kernel.org>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [RFC PATCH 07/10] dt-bindigs: sound: Add Allwinner suniv F1C100s
 Audio Codec
Message-ID: <20181219140439.GA6820@bogus>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d0ce4b1f2a89a319d6becb5f88d7ca4184aa5595.1543782328.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_060452_433458_0DBDD878 
X-CRM114-Status: GOOD (  12.00  )
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
 alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>,
 dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 12:23:14AM +0300, Mesih Kilinc wrote:
> Add compatible string for Allwinner suniv F1C100s audio codec.

Typo in the subject. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sun4i-codec.txt | 5 +++++
>  1 file changed, 5 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
