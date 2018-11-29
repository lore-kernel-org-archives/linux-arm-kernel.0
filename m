Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:03:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768F720673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGhQixHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768F720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+BaJih+SKDTWqbTdhcukYmSQjfhBGyfIm2zmzVJcyQ=; b=eGhQixHVBdwOPQ
	Mw81NPgtT/4xNu90LmbuPaiyF9Y8QzkIaoeZXFGp2RwpJkCW+9eTga18/Y2vJlrRVzLkY6cwmKLOu
	qH6upbgHAEIby8puiDUXlOk+eY3VtX8lPvxUDcBcGb2A3zxKxm3509tESd/1aCUlX9EO3scU1liLz
	d7rcAC80bo2wVGaXSeJvs5YwtShdJ1aI04yExknWtIfGfIQ8Q6LKXnEyglrLCS00okwtuH00UBjzk
	WgfI9kqZZYu36u26e0DKx9WiIFK7AChthnsuNoAJx356P52NJfOjn0Vdkdq+sFJ6DX4FVOxmLg6UQ
	gJ2pgcOa1VXQHQ3Mgg/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSXI-0007zQ-8K; Thu, 29 Nov 2018 20:03:44 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSXD-0007wj-Os
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:03:41 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 02F4F8171;
 Thu, 29 Nov 2018 20:03:30 +0000 (UTC)
Date: Thu, 29 Nov 2018 12:03:25 -0800
From: Tony Lindgren <tony@atomide.com>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181129200325.GC53235@atomide.com>
References: <20181106143516.8394-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181106143516.8394-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_120339_959388_6421789D 
X-CRM114-Status: UNSURE (   5.66  )
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
Cc: aaro.koskinen@iki.fi, khilman@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Yangtao Li <tiny.windzz@gmail.com> [181106 06:35]:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Applying into omap-for-v4.21/omap1 thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
