Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A64C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:07:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C6B20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OpzndyeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C6B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iu351TGyiUojiil1vF+zEX2y9rmLsb9wNwz8t9AMHpM=; b=OpzndyeJ6u1Pyl
	SsJXKAr7CqaXKM25zz3TG4UNABllA9VaHkB4B/IOYg7w4+MG363gR20O/9t4aShXnaXBoFQw/aS6c
	hWJMBZelOXJBTCzPBQPNXuhmclpYv3PYeR00Jy+jZdxHpx0EX29TyEzU++pAkoQOCVsiQAuVW3Eby
	P/CHx0upxY16Ni5HjI1KyFdEIyVFqGPu5NnWWlSQzhx4CECt30wxHuPDFN6vrP1ayltH2ugo2mvEE
	jXTiAB1efdp8+9arOPSyJyH4PdPhTjZ92YAl3elNYCut2HE5Y6OW233Qo/9b7lej0g9BJWrKoux7z
	bLTaiuAGsELE7jWUwAZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSSag-0001XL-IU; Thu, 29 Nov 2018 20:07:14 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSSac-0001WK-VE
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:07:12 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 155478171;
 Thu, 29 Nov 2018 20:07:02 +0000 (UTC)
Date: Thu, 29 Nov 2018 12:06:58 -0800
From: Tony Lindgren <tony@atomide.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP1/2: fix SoC name printing
Message-ID: <20181129200657.GE53235@atomide.com>
References: <20181119194641.303-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181119194641.303-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_120711_046269_2EF9F261 
X-CRM114-Status: UNSURE (   6.86  )
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
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181119 11:46]:
> Currently we get extra newlines on OMAP1/2 when the SoC name is printed:
> 
> [    0.000000] OMAP1510
> [    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16
> 
> [    0.000000] OMAP2420
> [    0.000000]
> 
> Fix by using pr_cont.

Applying into omap-for-v4.21/omap1 thanks.

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
