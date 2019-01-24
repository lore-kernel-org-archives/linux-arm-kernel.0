Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB2C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:30:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA2B218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWme9psi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA2B218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ifDsZcZgpHTurvJEdR9GjKhnvSDCoonYQV7+hgEbUGU=; b=nWme9psiVd0dCA
	LIXzImbYlqKVxgWKDdSnvE8sVUdyKIYHSUG3Uj+3QmNpYu/2aQwsxtLXIUZqMT7qbO/B0RxP9Kz5O
	QeIho78qlVr9Pf5P5nlHkQBy536yA78N2uPSdZAj4OcrqAycz4XXQYr7QZOWg3+Pv/XayVr029SGg
	RDgeZCYA2I3ry9/NkpnBf+jaZR/oj3W5O18QoW6tt94SoCZo1TGuiDkw1Jjp2u3F7iAXrPchsJSUl
	rsFNZr75VFb1hDhc1yZ37hrPyr4DPL+Y0oEX2Jxe4F63kqAKI/F/UdOYfa9c+PYozJBkVmlcXorz/
	VXo/uQ1Fgr6SAfEv+I4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgxJ-0003YU-Am; Thu, 24 Jan 2019 15:30:13 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgwd-0002Ik-J3
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:29:32 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 71D4D80C3;
 Thu, 24 Jan 2019 15:29:37 +0000 (UTC)
Date: Thu, 24 Jan 2019 07:29:26 -0800
From: Tony Lindgren <tony@atomide.com>
To: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH v2] arm64: dts: zcu100-revC: Give wifi some time after
 power-on
Message-ID: <20190124152926.GM5720@atomide.com>
References: <efc793c8-da17-e267-851e-f08f097843ee@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efc793c8-da17-e267-851e-f08f097843ee@web.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_072931_664973_5F4C3C1E 
X-CRM114-Status: UNSURE (   8.42  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ryan Grachek <ryan@edited.us>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Michal Simek <michal.simek@xilinx.com>, "Reizer,
 Eyal" <eyalr@ti.com>, John Stultz <john.stultz@linaro.org>,
 Kalle Valo <kvalo@codeaurora.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Jan Kiszka <jan.kiszka@web.de> [190124 08:29]:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Somewhere along recent changes to power control of the wl1831, power-on
> became very unreliable on the Ultra96, failing like this:
> 
> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> wl1271_sdio: probe of mmc2:0001:2 failed with error -16
> 
> After playing with some dt parameters and comparing to other users of
> this chip, it turned out we need some power-on delay to make things
> stable again. In contrast to those other users which define 200 ms,
> Ultra96 is already happy with 10 ms.

Good to hear this got sorted out, thanks everybody.

Acked-by: Tony Lindgren <tony@atomide.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
