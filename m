Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDCC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505F42081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q+FC/mvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505F42081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hbp/GNA4YmPq5Ap9X4FSAgJQBz+91gUIcGPtzN0QuHo=; b=Q+FC/mvOBmfpBm
	g7Hx9BIw7Dz4O+lmzdKoASjpqROwS658s6RXBgZMWbBHwY1X6AkbCdf1M8dGSJbcl11rH9m4ic4E3
	BUQEWa2MHvcReiAp/tOVz1SKogLGUlzmX5lnxsRpbp8F15VVb1c/V7RGdR021r6als77pVQAOkPlQ
	7OOx26WOyH9zlAChsWHIKmouKjBFikmu7OyyEHbn0JyjEupwfBHGMv8D73fzqWxe7ExmGQSTu+y12
	rT+sjUIyXq1LO/Juc7bEtngn1kUKBOMBTtBHqzKAgqVkiXa8Ueqzk9f2YD7hubeDhW9ygcNALGwef
	UGWh2qVv+Y1rdW1wN1Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGpq-0000dq-2c; Mon, 10 Dec 2018 08:22:38 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGpk-0000ck-Ud; Mon, 10 Dec 2018 08:22:36 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E523120CE8; Mon, 10 Dec 2018 09:22:18 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
 by mail.bootlin.com (Postfix) with ESMTPSA id 9AF1720CE3;
 Mon, 10 Dec 2018 09:22:08 +0100 (CET)
Date: Mon, 10 Dec 2018 09:22:08 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181210092208.0971c3be@bbrezillon>
In-Reply-To: <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
 <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206202956.GG3084@sirena.org.uk>
 <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_002233_501844_9383AC6E 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Vignesh R <vigneshr@ti.com>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 Mark Brown <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Yogesh,

On Mon, 10 Dec 2018 04:13:28 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Mark,
> 
> Patch has been resend [1], this patch is depends on the series of patch[2] and this series has been applied by Boris already.

You're still not asking the right person. Every patches touching
things in drivers/mtd/ should be taken by me (or another MTD
maintainer), and patches touching things in drivers/spi/ should be
taken by Mark. So, the patch you're pointing to should be applied by
me. Plus, I told you I would apply it after 4.21-rc1 because I don't
want to deal with the mtd -> spi dependency.

Please be patient.

Regards,

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
