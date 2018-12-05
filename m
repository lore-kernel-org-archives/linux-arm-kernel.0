Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA773C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEF2206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KJtEGYrE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjMS7Yue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEF2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GoEfBovykknRsywzP0dR/Q3lasR5TsnXezmOyZ0z9T4=; b=KJtEGYrEgD38eF
	2Vdgoo/fX+tagFiq/00uO5r2xT6OYqIKGx3g0z++lAV/Ea4igtNkFe6jWqYPrMPUFKwzLwOg9AqcZ
	RAqLnFa7O4lPazpe4zikJxrANCioeooXBHuYlOEFa3j+NeoCmut6LO3IyOH9ylLjFLcQXRDk8GUGt
	Y9laWRT5a0Rthp1SnSv2+pRqORmzLMziuFXoJ+8rA+lcJDUN8mBu7Npe61JZAzUYkT9aNGU1DBdGA
	8TgbbTYCKDWNfZukczSzwn7i0ExSYR0mcV/A6ycfBx8H3lMoop8SPHS3CRQs+8MIFXIoGhAyLKP9Y
	m59gKIoiEDsLp5u/Nrhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUS1I-0004Te-2y; Wed, 05 Dec 2018 07:54:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUS1F-0004TB-3G
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 07:54:54 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D641F20850;
 Wed,  5 Dec 2018 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543996482;
 bh=+m0Y4A7GmSwXPDcGnJZBi1LEvBLfJJcCri7v7yh0mRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GjMS7YueuJLWkyjrIuOgtA8q0vAZHxppfTos2EJ8lct6mzpC4aQhXRcHc6C/akagd
 idC7/FVagmwUXX3Ge7BSMX7+2b1x99dquUwd13u0mHiBjau8bFrNJ5qMQEj61XSpa0
 csmscWKQUiTWq5fUSoIFR+lTqFpz14vZmqizhhjw=
Date: Wed, 5 Dec 2018 15:54:03 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: vf: Fix memory node duplication
Message-ID: <20181205075401.GO3987@dragon>
References: <1543625092-24498-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543625092-24498-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_235453_207482_847213CC 
X-CRM114-Status: UNSURE (   8.50  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, stefan@agner.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 10:44:52PM -0200, Fabio Estevam wrote:
> Boards based on vf500/vf600 have duplicate memory nodes:
> 
> - One coming from the board dts file: memory@
> 
> - One coming from the vf500.dtsi/vf610m4.dtsi files.
> 
> Fix the duplication by removing the memory node from the dtsi file
> and by adding 'device_type = "memory";' in the board dts.
> 
> Reported-by: Rob Herring <robh@kernel.org>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
