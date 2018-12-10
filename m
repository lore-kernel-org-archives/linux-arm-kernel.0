Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B0C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:20:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA5E2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CH/fjwEI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHwAOjfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA5E2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e+Zu9vBWZ4H7xc82gKPC3DjKcGn+r7XyZiXMx9l1mWQ=; b=CH/fjwEIIoKtqH
	YhOLXU1lHhsIvn8k02ZUBnqMAaX4e3/oE5D9Fynorsuy2zTQijHV5TFfOSJvrXjSzG8uGeKsf1keJ
	6ZZpA63OWRLcUkEw8jFocCxCImO/NI0UtOMckXRsCer3sg5CsWMQud2Zp/PaWm2CrtuItLIGYwzGv
	YuX/rVm1imB3t+F2AqziNZaOJwf/azme0eea0H0Sm1QwGcWH63IX7EExNfPOG8sqRP+HbSS3ug+T3
	UrpNDuwCPpxD4hiN9212r2PLc0a75dJ3EkHBs3sfchVdCDAIBRS2T0381Su+XBHwanTeBTqyoMaPw
	X2E4b6j5m4P/s6Ea9Xxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWR6X-0002li-5w; Mon, 10 Dec 2018 19:20:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWR6Q-0002ky-D1
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:20:29 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0670E2081F;
 Mon, 10 Dec 2018 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544469616;
 bh=2AGN2PcwGti2dDpMVvtBewhNOhrFKjahOgrPVKm3xrU=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=HHwAOjfAZ4wC59VzokefI95Lj18MpLf++5b7XHP1VnLkLAxL4ej9RFqES4LzHOGbO
 nwwBkfKbQffn9zE2erx8XlKtTXe0Icv0wFjJ7gBj/m3+XK6qfgaFROPonJvNtNsI1g
 uUR9N91oO5DyGhgKpk6zObXglsrFpqtna61b15TY=
MIME-Version: 1.0
In-Reply-To: <20181210081454.GQ3987@dragon>
Message-ID: <154446960530.17204.11121916509657625570@swboyd.mtv.corp.google.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
 <20181210081454.GQ3987@dragon>
Date: Mon, 10 Dec 2018 11:20:05 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_112026_456691_AE061C6E 
X-CRM114-Status: UNSURE (   8.23  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Shawn Guo (2018-12-10 00:14:56)
> On Wed, Dec 05, 2018 at 11:41:01AM -0800, Stephen Boyd wrote:
> > No worries, I fixed it up and merged to clk-next.
> 
> Hi Stephen,
> 
> In order to send imx7ulp device tree for 4.21, I pulled branch
> clk-imx7ulp into IMX tree to resolve the dependency on clock ID
> definitions.  So please keep the branch stable, thanks.
> 

Ok. No problem. Thanks for letting me know.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
