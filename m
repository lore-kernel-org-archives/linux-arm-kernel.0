Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:10:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48067206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eENNszli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48067206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vQvSGzWjygx1Men0sawYzA2s6lTt4z/jSZHnHCZxElY=; b=eENNszli25hgEr
	r+nzSZ8DshjYBMA6lwJmDrX3rVigF5yby5gIVDPQHd7d39SoiKVwUVJO+CjLYqfVTewZ4mZ83xvtQ
	RMN8yyuhUjkvnN7NSXeeL0pZSoZ7Fjt4a4vd4esVFf5JS2BRG9Ql3Hb1R82Nm0WFxxkmsA9TqKxcD
	IZwW/cEhxMGQw204X5JJPIy0jVr9VRKrJOuU+rS3gqZFa7Np0r4fdyUV4Og24wMGCC07vSe4LiKP4
	2L7iyLaZVBI4DdYhklntirvU/kIm8hzEiLuUC7bEk555SmGra1Ui0+jnCm50DPEHyu+uWVub7UFbB
	rTIASM/41Wpod2OLuGXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjYn1-0002Ql-Bx; Wed, 16 Jan 2019 00:10:39 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjYmt-0002IC-GH
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 00:10:33 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 996A28022;
 Wed, 16 Jan 2019 00:10:35 +0000 (UTC)
Date: Tue, 15 Jan 2019 16:10:25 -0800
From: Tony Lindgren <tony@atomide.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190116001025.GL5544@atomide.com>
References: <20190115192840.GK5544@atomide.com>
 <20190115210920.GJ5522@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115210920.GJ5522@sirena.org.uk>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_161031_800048_D32F8C69 
X-CRM114-Status: UNSURE (   7.56  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 Belisko Marek <marek.belisko@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Tero Kristo <t-kristo@ti.com>, Jon Hunter <jonathanh@nvidia.com>,
 "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Keerthy <j-keerthy@ti.com>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Mark Brown <broonie@kernel.org> [190115 21:09]:
> On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:
> 
> > Any ideas what's needed? Some triggering mapping data to palmas.c
> > driver?
> 
> There should be a fix in -next already waiting for me to send it to
> Linus, can you check there (a couple actually, in my for-linus branch)?

OK great, yes the two drivers/base/regmap patches fix the issue
for me.

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
