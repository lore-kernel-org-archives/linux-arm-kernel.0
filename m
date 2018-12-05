Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE187C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC6C20666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uoR0i1c7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoV9UVbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC6C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QqbJuLv3H2pBklPpvBmaENGh5s7NjTnFL3E3qJtVYfE=; b=uoR0i1c7NIZ69y
	7c8FnmiaRlKBKIe8if4A8hAYEUwYc42uu7SLRU5uXQVPRwltyrBK1Od/YNXZK4GM2H18lLFqJlzA6
	RpVwQZAV0R+wAe4UAqCDXJ5vLAXasHadi9jmcL7NSdrZJ2g83dlmVPY4t2qKkeKb5pqpu67aGifTi
	OxalEthSOMZZH/8eT6MtU3XntILQwKxH1nrhVgODvgKsGC2jA0w6yReWnQQMxaUXAyPAsXkEl/Pdy
	gFdRRNMzTpP0whqg2EgsrP48DBpErkaD4AbZCeS/5z16t4LvrncC66b4ijT+4DKs++DFBvBxOljHB
	OHPlXXzYRaO+10nuOvkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUNmq-0005a6-BK; Wed, 05 Dec 2018 03:23:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUNml-0005Ze-KZ
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:23:41 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94BF920666;
 Wed,  5 Dec 2018 03:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543980207;
 bh=vzbo0CQapo6E1r5sm+unmAwHK50exHT7EgR/JGJb/Jk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VoV9UVbXqO9EeknruoMdCDtmW+2KBzcEb7Pi7QNJybtOLaZfUzDXTrEHnxIO/qTWe
 EH9id5nu9yHn0fLoR8iGPYLtb5paaCetTcrZd49YWnnGbsk8aV/ysd4xbokS5uTk/s
 cLum04Xzk5AUaGFb1YWBynMLIATlTqz1XoXUmCZg=
Date: Wed, 5 Dec 2018 11:22:50 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-pico: Describe the Wifi clock
Message-ID: <20181205032248.GF3987@dragon>
References: <1543432806-11949-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543432806-11949-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_192339_824236_1A328637 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: cameron@paloaltoinnovation.com, arend.vanspriel@broadcom.com,
 otavio@ossystems.com.br, vanessa.maegima@nxp.com,
 linux-arm-kernel@lists.infradead.org, john.weber@technexion.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 05:20:06PM -0200, Fabio Estevam wrote:
> The Wifi chip should be clocked by a 32kHz clock coming from i.MX7D 
> CLKO2 output pin, so describe the pinmux and clock hierarchy in the 
> device tree to allow the Wifi chip to be properly clocked.
> 
> Managed to successfully test Wifi with such change. Used the standard
> nvram.txt file provided by Technexion, which selects an external 32kHz
> clock for the Wifi chip by default.
> 
> Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
