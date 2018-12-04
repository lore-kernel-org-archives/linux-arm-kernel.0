Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24740C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:40:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58D22081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GLM7yBHa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjkPZW0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58D22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UT/+vpTrsHU/36SKYWfTrpgXdj8vMF4wGA6rSpZsErM=; b=GLM7yBHa6H1qHk
	zIew7lO8ofteIiFa+AIMiTA85sj7xxUWzr+Ut88W+oc+x3eZcEBHAb28s3ZiIe/NACayvM89aE/MZ
	6CDjtr1JtyxkEdidQnsFy8TsBLhaizK8hghZZ1ydiQaJcGmdWUa2ivnYvauSkbrZadpYayC4tTI2w
	xzmPEAC+2nWvr72f+YvgVtuRLr7WbY4+DrsgDJvde6SFzcXOCcEzghDSvBdip0hmeGlPZhd9uwlcy
	i+6HnNPk7GUlLmWbV06+pNrI/1uca4aHTgriB6hnu9tANA4jyN4ikphzSoTukwhSSkOt8gVxtprc/
	TCYoBo7sd2Lfg4wT4rcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGY9-0007tz-DZ; Tue, 04 Dec 2018 19:40:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGY6-0007Ms-Al
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:40:03 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E7B2E2081C;
 Tue,  4 Dec 2018 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543952392;
 bh=aVdSRiFETmY9eEUpLNHwuSWx+iPFRxgvcxjDPYH0cIs=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=XjkPZW0g/FaiMcRHCdtwCO16Quce6XxcXgrxOkbFCwdNWfuQWFKs0SgHJvi61BwOP
 +D4BYAuTnovpyqqlQxMVPT7k5yXZwQAQ6IDa1x7HhZyvM2qR5nW+EjlLjP8j72lQtH
 yR6FJXndbFLjAiQ703dO4lASfGfjNtSemLpouy0c=
MIME-Version: 1.0
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <dbbe1896ba62d2421606fb0807740d9e6090a1df.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <dbbe1896ba62d2421606fb0807740d9e6090a1df.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <154395239140.88331.1595713170039757326@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 02/10] clk: Add kerneldoc to managed of-provider
 interfaces
Date: Tue, 04 Dec 2018 11:39:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_114002_403119_879BD3B2 
X-CRM114-Status: UNSURE (   6.09  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 andrew.smirnov@gmail.com, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
 linux@armlinux.org.uk, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-04 03:33:48)
> Document the devm_of_clk_del_provider and the
> devm_of_clk_add_hw_provider functions.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
