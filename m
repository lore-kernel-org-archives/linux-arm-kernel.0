Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9EAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A800206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ho/Qlb9B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt/85473"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A800206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EcaQLHi11hD9p9H3Z6F3OBhHR19Wsrb8DcqX+UZKvLA=; b=ho/Qlb9BrhkadY
	0CSo8nOILotOnbQMmdnRSrpuaURJXtgDRkaoc+SZW3pxE5I5jeUg6SaO0hMOQrm2cLQ+YzMyW0aWJ
	7k83qaK3Ry3mO+b3/acl9LyHVmVZcaWOU7dOeBbWPDOeweuQaFjXqCmUabIT2INHhPYLIBFIAyEN2
	G45bRtO5B0/Xku5hX53XUNvPqk4tktVVM15WKyik2C9WUklWAyHaY4QWYmfol7JHZeooyyjmSaqdv
	wki3aDI57QZ9UHK2vWKiiofXc4nykZPSiO+0ihOphr4LzCctGRRF6L4UoutkV4w51hdG0DLlmuqKo
	xH1M2hCkebXQgtaoxjiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvDz-0004Z4-CK; Thu, 21 Feb 2019 20:45:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvDO-00033c-HP
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:45:25 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C175206C0;
 Thu, 21 Feb 2019 20:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550781906;
 bh=9S8mGznFfkpPmBMKuHBNi9DafR291+twnzDd/DcRW08=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=Bt/85473672pCLOfULDIta0GgnLgYPH4RbOp0b0eL6qiR+Wb+sfN1UE7XEHiCITLY
 jlm5BhTKgXruGx0WHQuf+dq7hVD7rdq6qU/trhSZ5QRx4HbF/PzXmi3apqNi6XgnDj
 HEDWeBagI17ZN3j9YcKxnlu2yuRxtwSwoDDfGhxI=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: imx8mq: Add missing M4 clocks
Message-ID: <155078190530.77512.6127881894366721461@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190130201725.18961-1-ccaione@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190130201725.18961-1-ccaione@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>, festevam@gmail.com,
 kernel@pengutronix.de, l.stach@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-imx@nxp.com, mturquette@baylibre.com, s.hauer@pengutronix.de,
 shawnguo@kernel.org
Date: Thu, 21 Feb 2019 12:45:05 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_124507_195943_FEC4C0CA 
X-CRM114-Status: UNSURE (   6.40  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Carlo Caione (2019-01-30 12:17:25)
> The clocks list is missing the clocks for the the M4 core.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---

Applied to clk-next plus all the fixes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
