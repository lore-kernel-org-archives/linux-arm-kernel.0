Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D31C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:03:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B032077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ASCZvoaq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkuIOdL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B032077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QDXMCtI7AtK8WBGlrWPAOppnghZn+t1NqsOOlpmHk7s=; b=ASCZvoaqDa9Rk8
	QM1816LftFkXDI3Ijtbae/ufNFIgnHElXRvJkwFBBQaOeDhYc0VvOiwRmNGRGvYuMGJ9TWvtNdrte
	+0UvcfNxsdXUZkjlBeHpEaT3hdrfEG4VaSXYVMfvQglJLqwphfdtvwtP9QFyelGhquwP4ciHTMPSn
	4lnVmFnq29ygXDbCFbM1Q6TofkEoxRfdeLEm09aQVpR0pjIyxi0aAXkvTYsR2WptB7TwPbnfoT+f8
	rL9jTDfFAtvhaw6nC6ZVzYokIZrALqejUJyWZdC1Sb/f9dQx+qpIcFpr76GVXhYBhy4vJwaJceXia
	uNeLdlgX/Zlt58AM88cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwRW-0006ra-OQ; Thu, 21 Feb 2019 22:03:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwRS-0006rB-Qr; Thu, 21 Feb 2019 22:03:44 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A5752077B;
 Thu, 21 Feb 2019 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550786622;
 bh=GePG9ZNYDL1UfQsS/WcBOUtdgUCum5elDNu0WiIcoeM=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=BkuIOdL1SOIlME3oCDLyoOVJlNlWtTitF+oMEO7tn380aPLCQL80TLli67mJI49sj
 mho+1ZNDb7fi8EAeMlCGWek/pAt8h5xo3c8ImwigFYg75fbBqUD6NW+WsW4F+xvOpX
 ppYoVhe3Y8z0RvfWGqEPBg9vZTOF7aZoqlOcPBac=
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] clk: mediatek: correct cpu clock name for MT8173
 SoC
Message-ID: <155078662163.77512.15925700437277835877@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211071555.31430-1-seiya.wang@mediatek.com>
 <20190211071555.31430-2-seiya.wang@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190211071555.31430-2-seiya.wang@mediatek.com>
To: Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Seiya Wang <seiya.wang@mediatek.com>
Date: Thu, 21 Feb 2019 14:03:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_140342_892115_CD5C29F3 
X-CRM114-Status: UNSURE (   7.51  )
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
Cc: devicetree@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Seiya Wang (2019-02-10 23:15:55)
> Change cpu clock name from ca57 to ca72 since MT8173 does use cortex-a72.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

I'm guessing I can't apply this patch because the define is renamed
which would break older DTs. Another option would be to just add another
define and mark the old define as deprecated and unsupported. Then I
could apply the patch to clk tree.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
