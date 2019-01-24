Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A5C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D547621903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Umvm+Rha";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn8fRI9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D547621903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fa3VAQR49SlodC3aWPT5RoMWb1KJDekEfapP1o0j63k=; b=Umvm+Rha26t/TL
	VGY1GmpEbJGZIJ5yaY8Mnvki6ox5Ei4BCKywTdtlHjkdhuT5k15ILSoaIbJdvhNiCXgYwoXmML50P
	3TsYqMp80qv00hz/0dyrdL3AQH89OuK1eJU7gj8j5KtunMyxF4/yEqcnCehjS8Osj25q/rNg/T63Z
	ytnfmfM2UP65ZWoU1LwsFqILe1gO+tcv/FWeXbNSYXTEkuNoVbGyWgDdUW7lZG8dtF8XlhsTHOebW
	wJlMxLufXUlwBNnbj//OsPTdKiSkvnzBILjf70reMhH4nbWUTp3v2JOZ2aV78njdPVKQPJDkjgL+S
	svGyZnpXsTJ/GT4pb8Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmkp6-0005nr-DM; Thu, 24 Jan 2019 19:38:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmkp4-0005nD-0G
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:37:59 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9D638218FC;
 Thu, 24 Jan 2019 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548358677;
 bh=NvJxEb0uwFbkNik/mB17l9fI/755tZ+BKXKMx+ZcRng=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=Gn8fRI9xvZFzw9ZPvcClUC4WnZMrxT2LEAImQZgLeik1ED5CVZIcmmoWgB7I8AwL6
 8o2OIhGqdS3yDKCHaBcsuEqjIOuQ4Yu/Ot5ccGmQeXQLKAAn0nXXuKxgGf0HWPllws
 fozHVK4Mtkp1i5uqF19lzPR6ToulPn0fwfK7lO9U=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx: imx7ulp: use struct_size() in kzalloc()
References: <20181224064025.GA9588@embeddedor.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181224064025.GA9588@embeddedor.com>
Message-ID: <154835867687.136743.9650857344780789822@swboyd.mtv.corp.google.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jan 2019 11:37:56 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_113758_061625_D64280D4 
X-CRM114-Status: UNSURE (   9.19  )
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Gustavo A. R. Silva (2018-12-23 22:40:25)
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
