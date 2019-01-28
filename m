Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F8BC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:27:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23807214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t8JTfQ/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23807214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ANxtuCosk8ShkvGBlbnhq4oAc5sXVLS7VgZg99FAUNI=; b=t8JTfQ/6c0i4Wc
	68k3ZDncCDk50FSMeFgR2k1P5AneGu/MfsPpv6tLPcewLwr4NNHHZEZ78a8KtqqY3LQQHdF4E2AIx
	j2Ksuix2pANf1bcvCsnIGpche70c6/mM3qKBwBQbJKAyKNTcFxq/s/6pda1hzHiN7XB8aeOQN3i38
	21M6WwmEa1vStYPtluFPpVm2y+OdbiGgEiI4g36Q7hdG24myiQBemnNtd6HZxGBe8TpPPvIoXNzCr
	FG0ojsoH/GIKZL0atCEU+bZFq7xeaZNBMDDjBXNvMhO+iLlaaUamY+rP8TxjOKiL6yt/XAiJ2TSAV
	JM6C/c8qxt2lxTrsUfHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go48i-0006Nu-OY; Mon, 28 Jan 2019 10:27:40 +0000
Received: from protonic.xs4all.nl ([83.163.252.89] helo=protonic.nl)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go48e-0006Mn-Ss
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:27:38 +0000
Received: from erd987 (unknown [192.168.2.69])
 by sparta (Postfix) with ESMTP id A624744A0027;
 Mon, 28 Jan 2019 11:28:44 +0100 (CET)
Date: Mon, 28 Jan 2019 11:27:30 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
Message-ID: <20190128112730.0175049d@erd987>
In-Reply-To: <20190128102022.1880-1-martink@posteo.de>
References: <20190128102022.1880-1-martink@posteo.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_022737_087780_001CBB6A 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Mon, 28 Jan 2019 11:20:22 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
> doesn't turn off the VMMC regulator which leads to hangs when loading firmware.
> 
> Tested on i.MX28.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> again, this isn't new. it's (rebased and simplified)
> https://patchwork.kernel.org/patch/4365751/
> 
> Thanks Robin for your input!
> 
> revision history
> ----------------
> v1: was just a question why this hasn't gone in earlier.

Not sure why it never made it. I created it for use with a wl1271 which
wan't properly reset in case of a fault. Also combined with imx28.

Regards,
Robin van der Gracht

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
