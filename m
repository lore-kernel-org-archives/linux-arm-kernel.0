Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9B0C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:59:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD23320892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V6oHVXya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD23320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUcX4PPh66UQL+tbfkWAvDc/MfjGDZW8wvVAXC1Hw28=; b=V6oHVXya520yEZ
	68V5es9IbzhsvViYW30GuftIjkpo9TZ9eGXZAcPtZOAZglZeIp8zP0ZSNjfKPrnoKQDfT+ya55W2/
	qc2s+s4uliLGTtDTIGC7oEzkv/W1B2QrUtKmXmuITUfk0cunrZxnW8lo4ipS2Y60OYMSh+TZGiiFs
	L0SSm0GwJfBVAZ/m8gus2r3CcQZ5pkVJcO7ol+etQv8TjKtWuOY0Ri++HfcNb+P2GvGYFAP+sIWBG
	8YZpAL7nPnv7NL339ANw3L5+S6s+5XSh6M+Fy4WDpF7ezdHFOLlT6g1SdhrHNJGtxBxn0uktCNqZm
	2tBQP8NIAspp/WSXrQOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHaz-0007W1-M0; Fri, 07 Dec 2018 14:59:13 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHa9-0006I7-8N; Fri, 07 Dec 2018 14:58:25 +0000
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa
 (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256) (Exim 4.89)
 (envelope-from <heiko@sntech.de>)
 id 1gVHZv-0004G9-62; Fri, 07 Dec 2018 15:58:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [PATCH] drm/rockchip: dw-mipi-dsi: Support MIPI_DSI_DCS_READ
Date: Fri, 07 Dec 2018 15:58:06 +0100
Message-ID: <2530200.jDlzaWghUx@phil>
In-Reply-To: <20181205130243.5810-1-richard@puffinpack.se>
References: <20181205130243.5810-1-richard@puffinpack.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_065821_924637_E4B81876 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Richard =?ISO-8859-1?Q?R=F6jfors?= <richard@puffinpack.se>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Richard,

Am Mittwoch, 5. Dezember 2018, 14:02:43 CET schrieb Richard R=F6jfors:
> There is sometimes a need to be able to read from the other
> end for instance to identify panels.
> =

> Signed-off-by: Richard R=F6jfors <richard@puffinpack.se>

The Rockchip dsi driver got converted to use the generic dw-mipi-dsi
bridge - will be part of 4.21. And there the different methods seem to
be implemented already.

So this patch does not seem to be relevant anymore. Please wait for 4.21-rc1
or check linux-next, if there is still functionality missing.

Also as a general note, please check scripts/get_maintainer.pl when
sending patches, as that should have also listed the dri-devel list, which
missing here.


Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
