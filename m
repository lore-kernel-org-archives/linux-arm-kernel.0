Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1AEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:49:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2AC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pTVe+rzY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l6xL+Koj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FRaQB/Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2AC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1RPnqqhI8w8k5PHWt0SY1ibzDRkBddpcSfLr/pFx0sg=; b=pTVe+rzYCSZlHC
	ZzpuAkZ6Hj9ZC2m4lnMGK+EJNZecJ+YNQ/EcXWk/dx2Q6Fc2mXf/zDi/fhc2mgVvW6d95rvcrWXM/
	Hun7oW8c7VOn9vpMtSTIGh5OhwGlnvPb+XK7WlDzDBw2VQ6kRHDoB8o9vR2TbPe3X5R9Q0RwLJss1
	PJogAEeGTEONek325uU2OymTpIgxdgZf5bey9TLQxiZjjfNm1EIM4DK1B2BJS4VFZXlIOXLUW+xhv
	P8L78JKjre0KR4rLTf2U9J87mWog/whmK4KN5L8vYz3OTzY1vbv5wrbff0wcIPOJn5A+DB/LGhZDB
	tJa0+WFnmK9xeulTL/rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnf8-0004bu-6B; Mon, 03 Dec 2018 12:49:22 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnf5-0004Pi-1E; Mon, 03 Dec 2018 12:49:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0467F60913; Mon,  3 Dec 2018 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543841348;
 bh=9jY/kiaNNMyuigDJmz1eK4j/O9SP9k5USUl2K97IftM=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=l6xL+KojIsTinvJIk1XSKFWGn24xMtUsiayAGBJYErfNR4yTZpJAjHPK31SECRb6A
 xvCVbsxz5bSjsiBuPUMHyF68lJbCl8KblFrJqbM83+T0m4F07nNSfzr6Xe2+QVhOMC
 ry+ihdQfyykr7TZG2Nxv25Kk2ukVM86ugGQvmMMo=
Received: from x230.qca.qualcomm.com (37-33-92-201.bb.dnainternet.fi
 [37.33.92.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: kvalo@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1BC396021A;
 Mon,  3 Dec 2018 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543841347;
 bh=9jY/kiaNNMyuigDJmz1eK4j/O9SP9k5USUl2K97IftM=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=FRaQB/Dxl20YvbKVBFdF6t9IbsvG1okIIh8Hlr6mtLQQcBPOV95qJlLpf9VgTodvX
 qaVZ5FW9ZN2203ZjVpyLkbL7EwLf+KkE3JRtbZXemdIem57N5v7hUu7YNnN7ynJUrh
 ZhhbZI55AOe+BN45IlH0Eqazd9ypzBglbQ2qHGMM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BC396021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] wireless: convert to DEFINE_SHOW_ATTRIBUTE
References: <20181202093047.11174-1-tiny.windzz@gmail.com>
Date: Mon, 03 Dec 2018 14:49:01 +0200
In-Reply-To: <20181202093047.11174-1-tiny.windzz@gmail.com> (Yangtao Li's
 message of "Sun, 2 Dec 2018 04:30:47 -0500")
Message-ID: <87d0qig4hu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_044919_111322_0FFF034A 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: merez@codeaurora.org, sgruszka@redhat.com, kubakici@wp.pl,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@perches.com, wil6210@qti.qualcomm.com,
 linux-mediatek@lists.infradead.org, pizza@shaftnet.org, matthias.bgg@gmail.com,
 lorenzo.bianconi@redhat.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Yangtao Li <tiny.windzz@gmail.com> writes:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/net/wireless/ath/wil6210/debugfs.c    | 240 +++---------------
>  .../wireless/mediatek/mt76/mt76x0/debugfs.c   |  20 +-
>  .../wireless/mediatek/mt76/mt76x2/debugfs.c   |  38 +--
>  .../net/wireless/mediatek/mt7601u/debugfs.c   |  40 +--
>  drivers/net/wireless/st/cw1200/debug.c        |  32 +--
>  5 files changed, 64 insertions(+), 306 deletions(-)

This is rather large cleanup so please split these per driver (wil6210,
mt76 and cw1200).

-- 
Kalle Valo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
