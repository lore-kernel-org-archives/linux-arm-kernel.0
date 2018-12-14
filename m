Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7545DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:43:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7702080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k7fKC8OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7702080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y9rMrCCq3KXPvGb8lbM2iP5VTB0kWjb5Gn01MJjla1s=; b=k7fKC8OZLZA9p0
	nITOb54xDXMfEqElmxDJCphQwNPvmjLuSuAmZHPMgDnv20Y8+pMSTO9sCVINDGTorIFB59WZdnafY
	/EkICl5xZT3E2p7XheOsfZOIXMaD6DMmcr2VnZlbmf726RdcLGegx1kILN46IbtH7ZP8yVsXn/gm2
	6LMkis13hPpqjLOS3vbfNFeaYnsbJ/xscJ8LV5Pj3v2WL6SifTNZzfx/Edzmyq1yegpy/XGAdrif3
	DXMcd7A1247Nvj7KrN6jMURvw3hCvZsH3Tr314NNOMBg6WfzWIuM9o9QuoT9IGgZaEaFvjuJac8yU
	pHyO9/uH6F9PCOEWfi+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXwB6-0006po-0r; Fri, 14 Dec 2018 22:43:28 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXwB2-0006oz-MF
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:43:26 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 1717D14E09825;
 Fri, 14 Dec 2018 14:43:10 -0800 (PST)
Date: Fri, 14 Dec 2018 14:43:09 -0800 (PST)
Message-Id: <20181214.144309.1221577116690535004.davem@davemloft.net>
To: arnd@arndb.de
Subject: Re: [PATCH] w90p910_ether: remove incorrect __init annotation
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a3ZC_1C2pVYcLEe1y0=__YsapF+rZWKjLZ9hyUucyLT+A@mail.gmail.com>
References: <20181210204514.2362328-1-arnd@arndb.de>
 <20181214.132300.832860946069084294.davem@davemloft.net>
 <CAK8P3a3ZC_1C2pVYcLEe1y0=__YsapF+rZWKjLZ9hyUucyLT+A@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 14 Dec 2018 14:43:10 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_144324_727888_5078D060 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 mcuos.com@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Dec 2018 23:22:10 +0100

> On Fri, Dec 14, 2018 at 10:23 PM David Miller <davem@davemloft.net> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Mon, 10 Dec 2018 21:45:07 +0100
>>
>> > The get_mac_address() function is normally inline, but when it is
>> > not, we get a warning that this configuration is broken:
>> >
>> > WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
>> > The function w90p910_ether_setup() references
>> > the function __init get_mac_address().
>> > This is often because w90p910_ether_setup lacks a __init
>> >
>> > Remove the __init to make it always do the right thing.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Actually I think we can validly mark w90p910_ether_setup() and
>> w90p910_probe() with appropriate init tagging.  None of these
>> functions are invoked outside of the probing paths.
> 
> But then we have to change the driver to use
> module_platform_driver_probe(), to ensure we cannot
> unbind/rebind the device. I usually don't like doing that,
> unless the device can never be stopped after it has
> been initialized.

Fair enough, let's go with your simpler fix for now.

Applied.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
