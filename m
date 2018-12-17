Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:50:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB292145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XEdiQKCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB292145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vjp6HmwJb1Ki9WpF4HD4F2JnHqZR9vt+nJZHPSeSOD4=; b=XEdiQKCXQ3gXxz
	AQZxr/PIynSTQFn8HCnehjukmeBrrRIVgFLYrj+04uq+nQAmYRtXRzB4LDsGMs9m9C+nzvgcsSkj3
	f+b82E0ZHhmUqi7A119CPHu6Oz0Mcz7id0u/IMpm4HyIdy4O4xQkZ2fr1xOHgRLvXjVRVUQkZVfrT
	sR8JWHmOv1sOLWVxIYCi/a7KeZ8BsBRzCTZce3zoLCRhVNwuGs+Sx2yFR8VEkUPdiWoNE32GSmL7b
	+MwJOpwbefFGC8Z4B18bV94VL1nExPYw0KUXKVzmBeAljnOVoCwzzS9cvU5EOxn90oTgnVtEQ3Q7t
	CronGUsjw9d+sUDtuRsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYw63-0006lU-TV; Mon, 17 Dec 2018 16:50:23 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYw60-0006jy-Tu
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 16:50:22 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 3B04380DB;
 Mon, 17 Dec 2018 16:50:13 +0000 (UTC)
Date: Mon, 17 Dec 2018 08:50:06 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/9] ASoC/ARM: Merge the davinci and omap audio directories
Message-ID: <20181217165006.GY6707@atomide.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_085021_002425_C96DCFB1 
X-CRM114-Status: UNSURE (   6.48  )
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
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com,
 Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 jarkko.nikula@bitmer.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181217 12:20]:
> Mark, Tony, Sekhar: This series - as I mentioned - is based on next-20181210.
> Not sure what tag, branch, commit  I should base this, but I can resend v2 if
> needed.

Good to see this clean-up happen :) Best to merge this
all via the Alsa ASoC tree, it should not conflict with
anything if it already applies against next:

Acked-by: Tony Lindgren <tony@atomide.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
