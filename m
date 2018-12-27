Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:10:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7182148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nAzX+Ffo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7182148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZkM1QyTitvArNJLj+Puq+EWr9H8F2otBur6UbmIXl0c=; b=nAzX+FfooOSO3G
	KCLOIbqsFvvTPbgyGrU6GFuL4ruUsZ6npOCYbca6AVTZKKZKfzkMxqAN3jM23WGu7+M8R0+/a4p3W
	d5MzdXcMWUMhoh/oVWruvVx+M2SPSMO/znRmzpbMe5ES5t8Qp25a1yGuyS84OgT0rrCw1QbRk5jKP
	0lU4ipHk/in/X3WdLxsviI13ubmFM2QXiWxq6eLTFY6miJor1FX3efZlRxn3GeJt2bvOe7Q/0pthm
	VnB7fUvI6mJi/Fj6u6Wznfbf3W5WTcBQ5LRDK4fgg9BXNuODuCtOG4sHz+gIeU6dlKCqYpI2oxXWM
	lT5vILbujzfkRdwY2BXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gccuy-0006LR-6i; Thu, 27 Dec 2018 21:10:12 +0000
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gccuu-00052C-1Z
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 21:10:09 +0000
Received: by mail-io1-f68.google.com with SMTP id p7so4573356iog.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 13:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=i3w/R5gR+TdjmOUjmdVKVXjH3rS0dZDOdRUKMIU0C5I=;
 b=t6+BiYMktE8PtusyWBJu2PL8FkP+RNZOr1hHZoTtTdEcRFj/Ou4mUgHaLBpHwo46bv
 5vxzcRu78hdaX3uugMOQzWQEM03TQKmzFvt9nHaICr1nwZ4oWPORbOsVBU51xiZiRFRg
 hAyKmnUsgfYQgrjNZuGXmCb3oI5/lA79d+0nols/qDHnI2yKfb2EcF0z7QyrXJd8oI6m
 IXQ+gVZ4972pe/n3CMOn2SUKecx1h5bVAnc/zc7Yum8OzjEJj3fpFu7hEmDVer9gOBNy
 SMALL0hIvSNbbWoOXQSKXZIjBmLMmIFHi3vA4UMCAmDUeu7a1p8O7mw7GC6wtZqkQvyT
 +QpQ==
X-Gm-Message-State: AJcUukc7XAAPuAI3bFD6AzbyW1cYL/FaniJyqVoSpCSL8GZWzEvKT2LL
 xjomO/349U+8pmCBBZbp+g==
X-Google-Smtp-Source: ALg8bN6uxLNlL1SLxOd7h8Pw3C2ra6M6k6X40yXAXjKSMhjwoxv27WAOCn7jg8WfGYzvOkcZyslZcQ==
X-Received: by 2002:a6b:7844:: with SMTP id h4mr2137221iop.216.1545944993830; 
 Thu, 27 Dec 2018 13:09:53 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id m186sm12985893ita.2.2018.12.27.13.09.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Dec 2018 13:09:53 -0800 (PST)
Date: Thu, 27 Dec 2018 15:09:52 -0600
From: Rob Herring <robh@kernel.org>
To: cezary.gapinski@gmail.com
Subject: Re: [PATCH v2 14/14] spi: stm32: add description about STM32F4
 bindings
Message-ID: <20181227210952.GA26671@bogus>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
 <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_131008_104152_2C35C9A8 
X-CRM114-Status: GOOD (  13.19  )
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

On Mon, 24 Dec 2018 23:00:40 +0100, cezary.gapinski@gmail.com wrote:
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

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
