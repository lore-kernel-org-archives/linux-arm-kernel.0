Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619D4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:27:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1693C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G5n9gskC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljWe3EFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1693C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ca4weYRVKYG7kvrCzuq8HSMeZA5i26bg9qhWXW/WBwo=; b=G5n9gskCe+pOpa
	M+S+0BxWglTtqPTGM1h6ddnTDw0IhDOftdD/BVFe2T5jtq79qH9fX/onKEJUiq8AZ/PUZqvpPuD0c
	fEMmpmft5D8fSXH4TFuiktudekl0LiiOUk1RDv/m0NWs57cjuWSydHthueuiVBe57fIji0U8zqIXA
	4mr6jQ1lQCFqJXhC3FCe3+jXnI2Ph5LqGbCswki9L6BdKIe+AG53YYlsNabtJBZc71Xuz2zzESZZ3
	IrbrVl9N7oV/gsHpQQJuybzyyGmJKPvqf0O7h6eTd/2nk4ut7oqAitfUt8hI+F42ImNmYi7HyEZd3
	LVdzlVlaIC1nvufVr2jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGLU-00087o-PJ; Tue, 04 Dec 2018 19:27:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGJy-0006iZ-Nu; Tue, 04 Dec 2018 19:25:28 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2977A206B7;
 Tue,  4 Dec 2018 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543951516;
 bh=p1VHy5qqvyLZJrku2O0wFxd6wj1gXaTCaZTYqP2k+N0=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=ljWe3EFKzcG8sKAeMSRUnjPCAd85/EvAEfD5kUYSYD99Ubx7Otv7nu+8skMQkzKJW
 1PbhAfHR0wB2C0bQFD3tEdgVQbzY1yF61n43gjrA5X+iCJ+ClRfm2GopKYXBRyRB2j
 E0MqznTsrf9yQZ7UpFH09Z4NNnmp6mXc3WAfAzWo=
MIME-Version: 1.0
To: Jerome Brunet <jbrunet@baylibre.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <b401f5bc-32e7-1693-0839-87ffa3dd5767@amlogic.com>
References: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
 <1542284312-55418-3-git-send-email-jianxin.pan@amlogic.com>
 <154387713374.88331.16436869339024592009@swboyd.mtv.corp.google.com>
 <b401f5bc-32e7-1693-0839-87ffa3dd5767@amlogic.com>
Message-ID: <154395151564.88331.17622786431747155066@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/4] clk: meson: add DT documentation for emmc clock
 controller
Date: Tue, 04 Dec 2018 11:25:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_112526_934483_B048C44C 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jianxin Pan (2018-12-03 18:39:34)
> Hi Stephen,
> 
> On 2018/12/4 6:45, Stephen Boyd wrote:
> > Quoting Jianxin Pan (2018-11-15 04:18:30)
> >> diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
> >> new file mode 100644
> >> index 0000000..162b949
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
> >> @@ -0,0 +1,17 @@
> >> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> >> +/*
> >> + * Meson MMC sub clock tree IDs
> >> + *
> >> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> >> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> >> + */
> >> +
> >> +#ifndef __MMC_CLKC_H
> >> +#define __MMC_CLKC_H
> >> +
> >> +#define CLKID_MMC_DIV                          1
> > 
> > Why does the define numbering start with 1 instead of 0?
> >
> The Clock ID 0 is used by  CLKID_MMC_MUX.
> CLKID_MMC_MUX is an internal clock which defined in drivers/clk/meson/mmc-clkc.c, and it's the parent of CLKID_MMC_DIV.

Ok, thanks.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
