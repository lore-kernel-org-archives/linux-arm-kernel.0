Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C13C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E674320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gp0iS9Xv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L29jhk+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E674320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d+runDPhWLD0xBIg2EiVJ65CO7XuyeZXldM/rD/BzdU=; b=gp0iS9XvJZMxQs
	ikIZ4kAIgJci8kErKdb6yZKJA68zoqYyGFgsfAa+1ZcciH7EMpj1pOXfWq4ng0xkfvrs1Apcq/VVu
	ZFOuPgpvJAtvYjGBWQE2nZg3CC1/lyX7V1lo5S9/Lxh9zlhUq1+Chh60llsZ8Yz+1YjTBo2MTdpOs
	NJ6aiQY7DErEc/lYs4skm0K81J1tdKituMfrUC3C0ctrIbcQz/JI8DrnQGWlo+HJTFJzykt2IQaby
	ArcCFnKpRjC3b41eazNFlq37ctJL8GdKAKWoiAY3vAVNnVT2xhH6Gjm7EupNESymuv/z6emBPQhQo
	CQ52MAgAtt0vQjSwCz7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi8UM-00048h-Tt; Sat, 12 Jan 2019 01:53:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi8UJ-000484-HL
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 01:53:28 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50FA420870;
 Sat, 12 Jan 2019 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547258007;
 bh=yAJbgMSlmy82wjF08zyYNtNBG4McQGoIAFbzSEkeuz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L29jhk+032KTgsDnaD8O1eUue8WIFMxxWjhoDNDI1tkmCTjsNis9ng3x9lyV3Uphc
 YoYqn3YCACv2HlyW0f8jyNoFSgdlyqr/Zmk2pGSCiDJx0Ug0nmDK1Ac/DddB+AeSjc
 DbX+7W2foLaBuAd2KJDUP0E0CM0nOFlRwsym+C1I=
Date: Sat, 12 Jan 2019 09:53:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH] ARM: dts: imx: Change i.MX27 interrupt controller unit
 name
Message-ID: <20190112015314.GL32649@dragon>
References: <20181219155639.17096-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181219155639.17096-1-shc_work@mail.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_175327_596594_67E9C4B5 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 06:56:39PM +0300, Alexander Shiyan wrote:
> The interrupt controller is located at the physical address 0x10040000.
> This patch changes the unit name of the controller to reflect the actual
> address.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
