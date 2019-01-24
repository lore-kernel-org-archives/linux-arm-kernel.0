Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D74C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D19218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bWRMsxpG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mabZCt9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D19218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:Message-ID:In-Reply-To:From:
	References:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OAyR/uM5tVqTazANjitKuY/CFBD2PHlM4aXOJEAepYY=; b=bWRMsxpGf8tHlm
	+4Q5hEe40fJlrqAXxNCPevZ5wN9vBimXfvCnEeP+HPGaZuOw4N8I7CgYvmw1A15m+Y1DjbkJ7Ujrz
	T3XSORnmMPur+lOmx3P0aopf8JlRf+UuTl1Unm6dsPFscckV9Gm3og28zzxWCsc94H1alQXdKFswc
	JdCxPgYeMHjcQgxSNjzNp+Jsxp2OfXL7c6r+SdihAaYPNxipsIveN+K4k34lhJnw33RG9VOPRc280
	bjTdcVCEJroOxCHJtw+m7/GvBK0Tg0ArsrodlLVxNU8jBYvjkeNrvNHUIPO/LC+s91pQ1rTzKUWTi
	/7UrWg1qlLlZbXLVsvsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmkmk-00050a-3O; Thu, 24 Jan 2019 19:35:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmkmh-00050E-92
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 19:35:32 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC0B7218FC;
 Thu, 24 Jan 2019 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548358530;
 bh=WuIBLsKcPpoKRamebZZJ1FqmlL04J4nVVGNK/DujFxs=;
 h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
 b=mabZCt9EdpBmjgo3mWSWhK4lFIeVojmlZ4V4c2kf866wYoTfoE33wvcGCGg5ZQtFl
 H+/bvnR1zpOACoNNO8OzmpiIanZeLPxdbkkqUr2v48mZtHxJ4ltrGcTrC10KzDaGV/
 AI88CY7yMCwDIapFr4Viu9JuSXuubXq4bbhvQ4+s=
MIME-Version: 1.0
Subject: RE: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
 <20181203133040.GN10650@smile.fi.intel.com>
 <TY1PR01MB1769B12A216ED3E76A40A6B7F5A90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <TY1PR01MB17690EDAC0E4B637FF7A81DBF5820@TY1PR01MB1769.jpnprd01.prod.outlook.com>
User-Agent: alot/0.8
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <TY1PR01MB17690EDAC0E4B637FF7A81DBF5820@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Message-ID: <154835852994.136743.9597365579277904098@swboyd.mtv.corp.google.com>
To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>, Phil Edworthy <phil.edworthy@renesas.com>, Russell King <linux@armlinux.org.uk>
Date: Thu, 24 Jan 2019 11:35:29 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_113531_337439_945C6753 
X-CRM114-Status: UNSURE (   7.11  )
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
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Phil Edworthy (2019-01-16 07:18:42)
> Hi,
> 
> Any other comments on this patch and patch 2/2 (https://lkml.org/lkml/2018/12/3/326)?
> 

I was waiting for Russell to ack or review, but I haven't seen anything
so I think I'll just go ahead and start applying these patches now.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
