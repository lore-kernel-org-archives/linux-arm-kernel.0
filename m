Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EADC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:14:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448102084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3YE64F+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ruT+z63f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448102084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gASeE7VpqLGdw/tM1cN85eZV1kcmgci3NpdjFtitrIk=; b=Y3YE64F+QEVuse
	Ak4hYmScI6O05NXsFmBaOSjdHTIrDBGmfJU85t+VphHATxKladj8AWpIJy5kXUyl+mjHkwbDcq2GB
	25JAEcAXVYVWFYj0PTR39N/rASn1EEVGnWY9DuAaB7XfEq09QsnhB4SDBbVr3DDvOZaaK208eYBPW
	ocBVIO+JGHyGEfRQhis2Z7v0TaDcq3iZ6HsRglr9dQyrqu/a52BUHJlSnkBkv0rhzo3LUeKGkFHq3
	cHe2n92ST2JXyBu/yLzsAeaj/xNEaWykhiEiz3SX9uokmeBuuP1lk+r25Ax0quRfyKjBANE0bEel1
	t62YZasfgr8pJeX8gnVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKRw-0002ym-HQ; Mon, 10 Dec 2018 12:14:12 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKRf-0002ck-L5
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:14:07 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 5D90125B7A1;
 Mon, 10 Dec 2018 23:13:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544444022; bh=fT3q20J0KEsc0Ko/yclup8Wh+PitOBtVgVmHFDitGjk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ruT+z63fuOlG2cV7CVQLosnGrcqFbUanAcQIAKDOfcqQ/8oV2G2ga3COjplSFwr8i
 NrPJzl8rJTJ0eLk7QiCm0FUf5ar2blbY6Kvyfryvc3lUl1uJSa0Mpo3UmryJ7l6YLU
 qjZaRY/ah2uGVw1FHvAcILwzZMzPfwYLEPjL/dZQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id CA1989402E1; Mon, 10 Dec 2018 13:13:40 +0100 (CET)
Date: Mon, 10 Dec 2018 13:13:40 +0100
From: Simon Horman <horms@verge.net.au>
To: Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v4 4/5] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
Message-ID: <20181210121340.iuwyq5myk4woezpg@verge.net.au>
References: <1544182066-31528-1-git-send-email-biju.das@bp.renesas.com>
 <1544182066-31528-5-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544182066-31528-5-git-send-email-biju.das@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_041356_564970_5FF0720A 
X-CRM114-Status: UNSURE (   9.81  )
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
Cc: linux-rtc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-renesas-soc@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 11:27:45AM +0000, Biju Das wrote:
> The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
> support enable the driver in the shmobile_defconfig multiplatform
> configuration.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.22.

Is a similar change for multi_v7_defconfig also appropriate?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
