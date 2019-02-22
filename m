Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAADC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:48:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908092086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gH4Asx03";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHvlPgvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908092086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PTnlRADAMuuVx99GZQpWGUabgYPNhpbe0JKSYH8K4R4=; b=gH4Asx03lk45ZC
	o7njc3uNCGFk0E/hOltCNqEjqCp1nTZj9NRYtKgxFfnc119wotgdTxy8PS3xFytUiG4WuL/Yv1xKj
	7+ydg2aFPJzLF/3YUkvlL6cbsuL6occz5Wxt9UM09Lumjv+8rjXQBR4E7Cu0GCki+RP+tBpOUl7gy
	Zc0eNv2gtidWaUFMwsyLp6wwSLdWH5GdXV88AP589i6Z6mix2ztPewv22cvSSeRGY6Bmwe1+VC7RR
	+mdQf4m9cL+itewTx0eWGafp3XWXIrggegLIkHnQbsR+CwuZK2vtnBzbAM1EPFLecdW4jvElAU2n0
	eaVztUERNjptMX9pMKJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx5Z7-0004ix-K5; Fri, 22 Feb 2019 07:48:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx5Z4-0004ib-KQ; Fri, 22 Feb 2019 07:48:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF37D207E0;
 Fri, 22 Feb 2019 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550821689;
 bh=IWsGKyF6tSaXeD7/EpbCy6bONxy5c7yvq1SKZiasmCs=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=mHvlPgvXH8lhnQQ1MiSPkgg8nvk+Zdl0Mb0WdNqeFG4q1IHioJEte91aC+pPZ97FA
 pg7IaKaMq3tF5+/fx2rP08nVw3X2Jkeg5EHZt2el9yPHz8pDT7tcbuL3eS0UbK1okE
 Zr4iYUnV64ou6Om4hls2Zp0t6SKvB59wHEJm2U44=
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/12] Mediatek MT8183 clock and scpsys support
Message-ID: <155082168901.77512.12893153125579041936@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-2-weiyi.lu@mediatek.com>
 <155069033021.77512.14493210110678229730@swboyd.mtv.corp.google.com>
 <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b7abe484-71c1-5ec0-796c-544f1ac5d6f5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Date: Thu, 21 Feb 2019 23:48:09 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_234810_686837_0F5D1F0D 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matthias Brugger (2019-02-21 00:36:24)
> 
> 
> On 20/02/2019 20:18, Stephen Boyd wrote:
> > 
> > What's the merge plan here? Do you want me to apply these patches to clk
> > tree? Will someone be sending me a pull request for mediatek clk changes
> > this cycle? It's getting pretty late for much of anything making this
> > upcoming merge window.
> > 
> 
> As far as I can see, the clock patches are independent, so I think it is OK to
> take them. SCPSYS patches will go through my tree once they are in shape.

Ok great. When patches for clks are interspersed throughout the patch
series it makes me think that something later in the series depends on
something that isn't a clk patch so then I can't apply it.

> 
> Do you prefer to get pull requests for clock patches? I wasn't aware of that.
> But if you prefer that, we can find someone who prepares every merge window a
> pull request.
> 

I don't really care one way or the other about pull requests vs.
manually applying patches. It helps if someone wants to pick the patches
up and send them along when there are complex dependencies between the
clk patches and dts bits or something like that. It also helps if
there's someone else with knowledge of the particular SoC saying "these
are good, please pull these patches". Subsystem maintainers obviously
aren't experts in all SoCs and their various quirks, plus datasheets
aren't always so widely available, so sharing the load with SoC
maintainers who are familiar with the hardware usually makes a lot of
sense.

Otherwise, if you just want to put your "Reviewed-by" tag on any patches
that look good and are sane then I'll quickly understand that these
patches are good and that I should pick them up into the clk tree from
the list. Just please communicate one way or the other about patches
that you care about because it helps to know if they've gotten attention
or not.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
