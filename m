Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:55:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5262173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LMglt66s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTp+PCq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5262173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gNk+hs8MGAOKzx9fEVj5a8qcZ+EGrPYE8QoQc+0nyDw=; b=LMglt66slZFxld
	yO08KGLMBQs89Zck1wkyHuosAFjYmIAx499WCqEKvAajIhiavNNlR3sWpm4IwfRVTgQ91nd0UB+2O
	FdD5kfiAT+9CFlgX8ofVBLUPEdFucwx3kiwaK7sKEqQ3y53cxG9lkn/+W9UN/Xwyke8BAL8TRUpxr
	dZwVpcOADAWXjPt7CwfJ41y9GwuUqY+BUp6llKy2GBRla/mcCVGAJXdYQqj++/0k2HkZO6nW4VrVL
	vpRi32ykTADZ0+1X1Fywh/iCyO/YZvewJGBx5KDk/R0uRsE0mOSpSxgWjuaDhKaKIhMDzZX3jkOe7
	QaroJFClxZv4lzr0K7GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygwn-0006BT-NB; Tue, 26 Feb 2019 17:55:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygwk-0006At-EU; Tue, 26 Feb 2019 17:55:15 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 112912173C;
 Tue, 26 Feb 2019 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551203714;
 bh=X5OVCzrsQAnuNCeXkl+OnEMMckqJHX7xniL91R3UZ3I=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=uTp+PCq0LQf7VAOSSO4ajmylbRf3pTVnNhDal66Aprct+bXoa1iLUExK008wDPgwM
 GSP02jEkxfcElA/Gj1u4WwYWChorVWYEW+z/7C0JeVgNbd7su7NvwxnU6C+lUaSytq
 xrimVfTPV9w0Adqz7iODnysevam+sUnjAIOmhhG4=
MIME-Version: 1.0
To: kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com,
 matthias.bgg@kernel.org, mturquette@baylibre.com
References: <20190214163242.26259-1-matthias.bgg@kernel.org>
Message-ID: <155120371334.260864.14503820089028591730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v4 3/3] clk: mediatek: Mark bus and DRAM related clocks as
 critical
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214163242.26259-1-matthias.bgg@kernel.org>
Date: Tue, 26 Feb 2019 09:55:13 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_095514_505929_4EA81836 
X-CRM114-Status: UNSURE (   6.45  )
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
Cc: sean.wang@mediatek.com, linux-kernel@vger.kernel.org, jasu@njomotys.info,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting matthias.bgg@kernel.org (2019-02-14 08:32:42)
> From: Jasper Mattsson <jasu@njomotys.info>
> 
> Currently, DRAM-related clocks are not marked with CLK_IS_CRITICAL
> for MT6797. This causes memory corruption when the system is
> booted without clk_ignore_unused.
> This patch marks MUX ddrphycfg_sel as well as gates infra_dramc_f26m
> and infra_dramc_b_f26m as CLK_IS_CRITICAL.
> 
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Applied to clk-next

Would be nice to get someone from mediatek to ack it, but I can't wait
forever.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
