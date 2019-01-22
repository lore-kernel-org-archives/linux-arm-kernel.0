Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59277C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:39:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2844B20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CKZHy6PV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2844B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PSlah0jR6bNo/AcFPMdCKqTka4kL9CXg+miJi2orxt4=; b=CKZHy6PVW8SLVr
	attvQsvfhIaBi96r9oyojwsSd0e/1naNFwUYI7Zi8jOts78uNx0dteH1Jer9rKfOWjE7qB2MVgbAC
	R69ZMO0afuay0ebsLQDgt20NEWsx1rc9Iu+FJd6+FzDEcOTpBhVEg56R+d/oy5qFitBkWaoOjC76A
	2VtxrCHlMwRjDJPr8DMYAtznIEEQE3Zp4h2Bx7IPPFr8NtFh9uZ0PUr5K0PERF/XJ+AvTe8GgYURJ
	Mv6ItJ98p3q/OQCbvTQUhWVqZD/lkC/m+4azhl44i4z389v33Xs22+7XcIYiGy4tuCO8QwwIFZQzE
	mEJlrw+ZcqbUpw63L5vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm4h8-0005RZ-TF; Tue, 22 Jan 2019 22:38:58 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm4h5-0005Qo-3a
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:38:56 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 455A643C92B;
 Tue, 22 Jan 2019 22:38:51 +0000 (GMT)
Subject: Re: [PATCH] tty: serial: lpc32xx_hs: fix missing console boot messages
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <e7fb8d2d-5daf-afdf-bd8e-472c76701650@mleia.com>
Date: Wed, 23 Jan 2019 00:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190115171814.21789-1-alexandre.belloni@bootlin.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190122_223851_305259_9132313F 
X-CRM114-Status: UNSURE (   9.51  )
X-CRM114-Notice: Please train this message. 
/bin/ln: failed to access
 'reaver_cache/texts/20190122_223851_305259_9132313F': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_223851_305259_9132313F 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: Roland Stigge <stigge@antcom.de>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Alexandre,

On 01/15/2019 07:18 PM, Alexandre Belloni wrote:
> When probing the HSUART, it is put in loopback mode in order to prevent a
> potential issue that may happen on RX (Errata HSUART.1).
> 
> serial_lpc32xx_startup() moves it out of loopback mode but this is too late
> to get the kernel boot messages before userspace opens the device.
> 
> Also get out of loopback mode in lpc32xx_hsuart_console_setup().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

the change looks good, thank you.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
