Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CAEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:03:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FD9206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IXa+eK4K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="om3EPZtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FD9206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rU72gY9FUYKvfUA58KJ6ZH4lZISLDUEa6vbZxmVgKNU=; b=IXa+eK4KOwX1Ne
	ekAUDgUnO+wYBiTRBJ5ze+/0TpBWNZAFu3rNQ45AV02Ss+XYIifV0btGITL5/7X3sxcW5oeNxJMCA
	PtjxKuqDpFZv8Dc3r9W7GAo925y3Dk7Axa/JHI7cJIvNwz4K/kIbnDV4hMW5TjKDo9QP7MEBxbysD
	KpovfqGEOkspmn5udm9ecUZ2TK/SHjCiqx8UxKeLN4ozRaoXdoZGkyV3IrSmFmbb7wOUAx/wx0mqM
	25ZE2enDFwbtzaww8QVK0Dc+QW6tk6DxTDrsERu2zyvEgjYtgcd++kAuH90Gqtv0gQxcD8HKc8J3k
	I8ZJqpNVCuM9DozwRuzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt1sl-0005Km-U5; Mon, 11 Feb 2019 03:03:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt1si-0005KT-UF
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 03:03:42 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9389F2084D;
 Mon, 11 Feb 2019 03:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549854220;
 bh=lHrngk9Z+jCXHxnyS5jXIqFYCypTzWCNDVR4gCVMfhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=om3EPZtWoggYaN86Z9WkwXHcBpF3UpQF5OUxwwuKb93A0AfZYgIXiw+8cvs6WJFdD
 p8uw3YyJvHE0Kfgm4/UTEZq9WWN3ZQOLQ2Oz1oeyCp08XJsPVgEXGGVLzNV+ZLsT+w
 PmZ5VuNJBZSYAWoKgzyAN06LZyfhu5t1PHRNRuMU=
Date: Mon, 11 Feb 2019 11:03:29 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH] arm64: defconfig: Add IMX2+ watchdog
Message-ID: <20190211030327.GK22487@dragon>
References: <20190206143737.25368-1-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206143737.25368-1-ccaione@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_190340_991454_062F373B 
X-CRM114-Status: UNSURE (   7.31  )
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
Cc: abel.vesa@nxp.com, catalin.marinas@arm.com, will.deacon@arm.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 02:37:37PM +0000, Carlo Caione wrote:
> It's needed to properly reboot the i.MX8MQ EVK board.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
