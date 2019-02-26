Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BEEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:17:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03991217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UCq4ptOr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMnBNpRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03991217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wO346bYY0qBcyO3iFQ4oeAw3UTbSSaDaINhdHA0MfSs=; b=UCq4ptOr/1gxHk
	9ZhfVM5Eq5oT3DVggKGHL/QCB7NTMZx0yw6QTTf8EqGcIsTMBiKIBHP/DGIHeMwLn1WJxwHa3Stta
	ta3EKx2XSxubPzj4Jmle+WwshCsV+JiJgCyZmXeAIFWQVJ+cozBt1Ft4kYuhRJURYa6/6d2BgkcWK
	jd8JvZkEkPuqOCSuOOh1vhLuvi2Z0unbJmdATZHc2IvZsEG33w/v8NwQ7Rsy/JmF3F7nyHcPy6Rhb
	JPutx8i9u4CtrfUMiE/zINE0kqeNmIGFJq530J/lE8QMij/jfeHd0sjZwokQg3lXzjXQjsY/7z8SC
	m/y6TUegdb8NHfpHgBow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhIf-0007MY-OI; Tue, 26 Feb 2019 18:17:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhIc-0007M3-BG; Tue, 26 Feb 2019 18:17:51 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE6EC217F5;
 Tue, 26 Feb 2019 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551205070;
 bh=1Ahvvy76fZ873Gs7wVuak7Fk+CXJ9JPrUMEngzbucqU=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=FMnBNpRli1ZAocpc18jGV/F0TD9WdhcMAnWsmRgd0B6SCyjN04Zw6Lt3r06LnhIaz
 idDhycl3N+td6ZPh57spEpHjN8jdST+Mlp/a9ZtUBDa17bk57j84SoK8nXQznjYaT1
 kUCwoTOKSWAXY6Kqi+NF6eh+Vg4ZzO9WLPJ0ZKto=
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Seiya Wang <seiya.wang@mediatek.com>
References: <20190225065112.3400-1-seiya.wang@mediatek.com>
 <20190225065112.3400-2-seiya.wang@mediatek.com>
Message-ID: <155120506909.260864.5536692295521525636@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 2/2] clk: mediatek: correct cpu clock name for MT8173
 SoC
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190225065112.3400-2-seiya.wang@mediatek.com>
Date: Tue, 26 Feb 2019 10:17:49 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_101750_399417_1D2FC731 
X-CRM114-Status: UNSURE (   6.31  )
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

Quoting Seiya Wang (2019-02-24 22:51:12)
> Correct cpu clock name from ca57 to ca72 since MT8173 does use cortex-a72.
> 
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
