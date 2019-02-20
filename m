Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A146C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A0C2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OPyishO6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdeDsZ3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A0C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jW8tEPRHy5tShWC2bSVzJWWTYSfigt36yHJq0W1wN6s=; b=OPyishO6eozyCY
	7y7tKThCNIP0LzrkIhNqv9QuR/KJe+PAcn2gW0WBvdVOlwKsDwqTF1Hv/eHFwWP//2mA0y9rHxbm8
	CEzDNaLUMnZYNjDr4fznQQGGmCbdTuF46RXQnQ88APGvO+IW2lKJKcTVXcbt2NNVqDvdHuU5WJV/3
	eqZsEzgvIYngalzoXgEso4X4mtd0kOvqIAK2Lhx5yKWdKhRxcAasayw70AcpgQkykN8tI1rchPV1B
	6sT9NTLGokUAoRMseHzgB5IVihAmceSiU4XV9ilPGYertblDU03PPkYatxwHBWfu5zrL1fpraah/E
	HHWgGhGQccpHSzzX7JTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwXOS-00022k-2y; Wed, 20 Feb 2019 19:18:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwXOO-00022O-7x; Wed, 20 Feb 2019 19:18:53 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 130A12146E;
 Wed, 20 Feb 2019 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550690331;
 bh=eRPNh/bRa6C0yoDIx0S8voS4NjKQdfvhWqmC35Kco/g=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=KdeDsZ3+1noDRzPa9as3KBZst9Qo+Bsfx+dBJTkbE6Eityyt+uPaXcYRqevnYReHV
 4rm1XkdrcKPFtCCa5KXQteBHiBxe5KgEiuTHrl+mQKN9TlDlsyP9WiKN8ZYOxQoEPq
 +ZgTs/cLz1SY/aSzb1c3rPPVNzcmk2Y4aOX+zv74=
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
Message-ID: <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-2-weiyi.lu@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190201083016.25856-2-weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Date: Wed, 20 Feb 2019 11:18:50 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_111852_302054_41F8B898 
X-CRM114-Status: UNSURE (   8.59  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2019-02-01 00:30:04)
> This series is based on v5.0-rc1 and most of changes are extracted from series below
> (clock/scpsys common changes for both MT8183 & MT6765)
> https://patchwork.kernel.org/patch/10528495/
> (clock support of MT8183)
> https://patchwork.kernel.org/patch/10549891/
> 
> The whole series is composed of
> clock common changes for both MT8183 & MT6765 (PATCH 1-3),
> scpsys common changes for both MT8183 & MT6765 (PATCH 4),
> clock support of MT8183 (PATCH 5-8),
> scpsys support of MT8183 (PATCH 9-11) and
> resend a clock patch long time ago(PTACH 12).

What's the merge plan here? Do you want me to apply these patches to clk
tree? Will someone be sending me a pull request for mediatek clk changes
this cycle? It's getting pretty late for much of anything making this
upcoming merge window.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
