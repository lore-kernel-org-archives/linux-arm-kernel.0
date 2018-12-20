Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039D5218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DYKmbyJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039D5218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T/GYHpyKZPhsYg/SZ0B+w1SYEaluQLgZ11t/AcyXjAI=; b=DYKmbyJHOnQ3Su
	1Z0y41ncaF1nKNmCXt6YcYFZ9eIWzw7hQqeeFQsKQZBSccv5Vv3QN12/PDbd4l8aAXb9Z/Jv+IYh+
	JHBb8mBcj+5bvQxBhMgqt6o9l8llwwtSbtaIUAhNDbKii7hd+jJIy49X5g6wFoDwOQODSH8gzMVBR
	4+2afAoAOigS1HO7XlLM0uSViBLTFJS+NjUEi9+IydGrwlKSO2rO/+/fFaZGeZcA6HsQ0V0dfaVW5
	qoUKSaCCmAsjrNiKaOOy2p4sdY7jaXtMUz18/ufGjuLctfyrptTnaMsQK3Z3uXTWodmQg/V1w1HYr
	DORPpkeSf27dU7jqp5wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga4K0-0008AA-7V; Thu, 20 Dec 2018 19:49:28 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga4Jw-00088r-9K
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 19:49:25 +0000
Received: by mail-ot1-f68.google.com with SMTP id 81so3056796otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 11:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mpin4rmY1KHiXB2yLRM1gONu7AeF2ezjMMA9danRL7s=;
 b=KZBJbeRMMhAu1i/14gZSXXfLU28+mW/SscQbEvtWBbRzMN9lzIkxQaBHhqZYZs152v
 cu1694BvZUkqxTJx7dQ86v4Ci44Nr5uXjtrfciNX+uGKlAhy62YrU9i7OoDmPZC/YeQK
 2n0PZ8RNwkmFHkXqUMIhC/2ta2mL0Aesk+hhYx6nzNATbaMt9EnvoYhNmJfznozoS9ym
 P1gS6cUi1ZIP7X9CSZLzRydj5CmWXXKMG4HMv00MbUgHjVXUqga7znrYIyw2qLuqFqSo
 r1FyQ/IPfAJL6JI77Eoth+jaqS6Yo6Hql4+pku5K8L0vajnjCPFccA0DQsmcs5ZgDp9W
 NjGw==
X-Gm-Message-State: AA+aEWbLP4Y1SgpOBDdhHXU2290l9MTLsMorUgaq6WBUS7bi67P9LMLS
 3b1SowAR9W7oCb2spRD3Ww==
X-Google-Smtp-Source: AFSGD/UmB/VXwQMTBz+ZpWV6GMPqXR5Mpfw5Zk5BFr+klOY+NIMe33FWpYrh9JdRvBJgB2go4ge5zQ==
X-Received: by 2002:a9d:128b:: with SMTP id g11mr18776880otg.130.1545335352988; 
 Thu, 20 Dec 2018 11:49:12 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
 by smtp.gmail.com with ESMTPSA id j5sm22008741otc.54.2018.12.20.11.49.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 11:49:12 -0800 (PST)
Date: Thu, 20 Dec 2018 13:49:11 -0600
From: Rob Herring <robh@kernel.org>
To: cezary.gapinski@gmail.com
Subject: Re: [PATCH 5/5] spi: stm32: add description about STM32F4 bindings
Message-ID: <20181220194911.GA17409@bogus>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
 <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544363636-12161-6-git-send-email-cezary.gapinski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_114924_327827_9860A45C 
X-CRM114-Status: GOOD (  11.83  )
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
 Amelie Delaunay <amelie.delaunay@st.com>,
 Cezary Gapinski <cezary.gapinski@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun,  9 Dec 2018 14:53:56 +0100, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> Add description that STM32F4 can be used in compatible property.
> Master Inter-Data Idleness optional property cannot be used in STM32F4.
> 
> Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
