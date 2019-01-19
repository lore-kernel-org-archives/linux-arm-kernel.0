Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00803C61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888BD205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="prGLWx37";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="leyXj9uh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA0vWOEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888BD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=pp0H4o43bT7xAjjqc0jGL4wxRLvzt0L+asJB7PVpAz8=; b=prG
	LWx37VP59lKyC8ENnyMazWUA9d9HPE+t88FkaQ0MLCMArVsWWoW8H1apAd80AJbnsT4PGAkJpIt89
	wDKdJF6X1Ez20WW7Uf7ojQvEsX7XsTgSX3LJMQ4xYRPnwXf9fLtRI7100Ra4rXII1uxZVgAo+QfZS
	PJzsKWXrd2RSBeT7TpV3iei6hKNsw+yldHm6tzZlZC1Vtox6T2e2eLeMTaCKnOFxwkzVzlQ9wid1O
	sTQ8Vgbijfplx5mT1vMphv4PHUdHE8ajImwqkwNwKsed7mcfDy9WnMCzv693saPiYodFNGpjyc2ho
	AnvwP+WgQnq6R9eRRBIfWlv3EoU7K+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkt7U-0008VC-Qm; Sat, 19 Jan 2019 16:05:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkt7S-0007Ev-PS; Sat, 19 Jan 2019 16:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z2Q+R94QVkSDTLwPgb79AdkY4t8QWFO8r8J7/+v/k50=; b=leyXj9uh+Z2lC4A1mt8GHSNena
 fm4cHjP9Sq2+i3446UXGfqdExY2pBJd+yzWK+fArTwr3ZVi3kxA0mcspNbaLdiBz7SYhp3F885bph
 OstOVNgGWUS6Sh3a3vt4ghnkx0KwLVkvqglRsj2AZq7+EJBFj6IES4CXdm5G2vw5X8DrVd0qiduRO
 NxCxqZS9IfJKmH0jeV++37HAIY/KFwziRMckdfsbkzRe/EwbDIPsI+mt6e67ohIVtwGLnlOvM+ACa
 QPBr4cO2XeQK+uQoFshpdDllw6hxn1diDLUxVHC86966cu5C6wKVRx9UNwCt5dyEjULt1F6g2RvfO
 sF5nXJOg==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gksm7-0004sv-I9; Sat, 19 Jan 2019 15:43:16 +0000
Received: from localhost.localdomain (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 153072084C;
 Sat, 19 Jan 2019 15:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547912587;
 bh=Ml4Mkp8nCS2/c0cy7Su8HYrB29V+abYd6Obw4Icabyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:From;
 b=UA0vWOEAo34kgKohSzHFcTreZPxnQ3WJ33q/R21HO6Q0dxiuBOHWqBOZUkzo08pvf
 1WtBcpxKik88tOWfq8rnmr+IZkz8FrDazvxQBLJrTYCjIlEZ8IRnhsMACm6z8q04ab
 P+HWnwBhWwfGBAjw41lyhgInPkxPYb5f9EF4xzvw=
From: Boris Brezillon <bbrezillon@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Marek Vasut <marek.vasut@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [v2,
 1/3] dt-bindings: mtd: mtk-quadspi: update bindings for MT7629 SoC
Date: Sat, 19 Jan 2019 16:43:01 +0100
Message-Id: <20190119154301.3800-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 4a09a91e5efd3759d28ae4708a7bcef11bee4416
In-Reply-To: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_154311_738249_17A38ED2 
X-CRM114-Status: UNSURE (   7.32  )
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
Cc: devicetree@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-16 at 02:12:03 UTC, Ryder Lee wrote:
> This updates bindings for the MT7629 SPI-NOR controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
