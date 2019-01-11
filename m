Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F2C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE78C21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IBu5M2Tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE78C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XbaGNC4/IQkbdFDnPuvhWa4EzrjGQyXEb1wAysV5lSA=; b=IBu5M2Tr6sPkRq
	ESW4s0qnFNx1ovd/PpI7aZmzmmbwIJ/oVIiK2KKW7MMLguZVngyoG6gkrzqYpmgTIHyDqpCd2iOTc
	8f1WQLHK7N5hwGSxFep3j5iTniZqY1z2p47Po4wZIyNg1FC07plE7paQCxkTTzeG4qw9lljeIJ8A+
	j3cgLEeAIVqiiuZIeoUVvsmg6SQdoIF86FHrjbUYLEUYZMu+4exbVDokCjFfUWnipwAT0IUcgV0t5
	dpMPTWUCqMpMLWwovssfZfUrnnBBN0IzwihIAhgspEuMKTIDjuxtSlJ8vzy1TxdakW8Z7azm1cSge
	3znRD+mf/4P9pjxVG5eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxvN-0002hD-04; Fri, 11 Jan 2019 14:36:41 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxvJ-0002gT-IQ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:36:39 +0000
Received: by mail-ot1-f67.google.com with SMTP id 32so13221860ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 06:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BDijiRVqZlvWlqdcV7FN4Lc/210bsUJyj4iSyX0GAYQ=;
 b=essht+0peYSs5iVVFKrP5/VHBQQLYdsTj11vnwHBEHdV8Mm//Yt7u6vGVouOU84V5y
 mbHBs8Oeg4DvTVHmrYB+Uk7yJLLfnt/ILEqtxiZ2hCn8DkMdIQuRxs6Qh5ZVXgpXaAoV
 VnGTmUP25CmF8uqZKTE9vBbkyhgZXANFebCgxXmmaE9N5prNkUZr0c5IrS6nmXUfggJ0
 YTsiGTi/xHft6UlN7k8VUVW7jL/klFsWVTad5avSc2RWVGH4mL0t++Krw+XF3QX61cgM
 YW71Ne6mgfWHX4+Go9v+nXWIPJZDrqtu/EkTWavm6DHOAi7+RD6iI6cVN1WJqzaGN4gT
 utPA==
X-Gm-Message-State: AJcUuke8ETHuFU9YAhYTMkjVibnK0qYoZtP2CKbEuKedwpuHZWSmTcDZ
 QCatz+N/LZOq/zoMD5/6Kw==
X-Google-Smtp-Source: ALg8bN4quM9coiLAgkORMDPr3KBCPvTuQMn5R2UotsF9Hwx6xjGnCe/We4P+QwjI4ow8W9agk4Xsmg==
X-Received: by 2002:a9d:4:: with SMTP id 4mr10321155ota.174.1547217396230;
 Fri, 11 Jan 2019 06:36:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id c78sm57018411oig.30.2019.01.11.06.36.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:36:35 -0800 (PST)
Date: Fri, 11 Jan 2019 08:36:35 -0600
From: Rob Herring <robh@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v5 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Message-ID: <20190111143635.GA21484@bogus>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110175845.1203986-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_063637_609743_DB1FC260 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Lubomir Rintel <lkundrak@v3.sk>, linux-arm-kernel@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Darren Hart <dvhart@infradead.org>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 18:58:36 +0100, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/cmd-gpio/cmd-gpios/
> - s/ready-gpio/ready-gpios/ in the documentation paragraph
> - Remove status = "okay" from the example
> 
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
