Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F1C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D5320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GodfO/K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D5320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l02a4uVTQ1xpcfGguTleHAL2QBIMUwAsE0x5hK+tjrU=; b=GodfO/K102hh16
	eE4OqlgPJBS4/AqQ6EDN8NcBkpyExwFGN3JtVsURmsOhXUVkSNmzVYwMllYo+YfBibPzeTSyvZVT2
	/Kdqm73/Jp6ASMwsKrKe+A2m/CUwzFK2w2fp72LsjFCPu8UEJAUxTdntVihTWM5tisO/runo+hs14
	YiBGHnDJFCtA031ZmuLAEyFh9PRewSCXkSu6e9TGgcE3xYaRS8AmuhKp3MKy1FJalXInN13jfrsCg
	TkdfhlC/KbpLGkdwq2KvsQQx6pq45/26OGpiJNG+cqMJr/z0fz2o91TUt3MADC+/8Av+lH5PBYDp+
	nGkTAOaJ7r+l2NxBZw5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSjq-0001Do-9F; Thu, 13 Dec 2018 15:17:22 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSjm-0001CK-AF
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:17:19 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id A95518081;
 Thu, 13 Dec 2018 15:17:09 +0000 (UTC)
Date: Thu, 13 Dec 2018 07:17:03 -0800
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: dts: omap4-sdp: Make ethernet working even if
 booted with latest u-boot
Message-ID: <20181213151703.GN6707@atomide.com>
References: <20181213135845.3965-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213135845.3965-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_071718_394141_25C0B834 
X-CRM114-Status: UNSURE (   6.80  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 linux@armlinux.org.uk, bcousson@baylibre.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181213 13:57]:
> After some debugging I have managed to get the ethernet working with
> mainline u-boot while not breaking the networking with the case when we
> boot with the mysterious binary u-boot.

I'm pretty sure this is the most recent version of
WIP u-boot SPI support from Nishanth:

https://github.com/nmenon/u-boot/tree/v2014.04-mod/sdp4430-ethernet

From what I recall, that did not work for Blaze though
for enabling Ethernet for tftp booting but worked on
4430-sdp. Maybe because of the same issues as these
kernel patches though.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
