Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D921871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNxNZeUw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dxkjBY7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D921871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M1oN4EcbLQbjMxIhzGkWDasgF4V9ATlM8iaZ2eKYUtY=; b=MNxNZeUwGj1GyY
	OQQ3XyPVfb8J+QjYmr2eV7TCvFxYLgPsR87TUuhmGM9y+61BGCdNAtnFhMK/X0Y4tjI08Km07BJBm
	QDhAkygv1/aVqrow7lX9GERNKuXqvJjGQ52KlrIdIx72oMTXFel5jebuOL+yac79pDidWbqwYnFQo
	91FGIzFikj0NZCC+kRBaKltaXdVlRaI1eZv7D+CELpfu63wihj4jZkqEpiF8/beZYsE5+zJl/7+6N
	hikTzkp2G4eUrlNpkroYuHbjcUViOxL0GiQaEaBe/nHrpXP6EmK5iDvmUBms54lTZtsY0S+8Jr01a
	cffcdEPqB3aopVxxtD9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGTN-00042G-Qz; Tue, 18 Dec 2018 14:35:49 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGTJ-0003jy-B9
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:35:47 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so16146328wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 06:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4/0zY6u1RnApvmJHF2Wye5hDyNvlXySXtkNAZsbxooA=;
 b=dxkjBY7GaqejEiBFu65PXtKuy9H1n0cWKbSxNXMwZnNbFpofgPkQcozPZJ9Xro0HaM
 joOaIXsSuLsZtqYVa9iJWIXPcm6FQ6/War9WD13/YqNpLg/WFbQhirfVTdoRatIquplS
 jNLAmoQ11stj2Xeu4jVo0V8oQE9ImOcHda30kH5nYZVoRxxv33eLjNhhXWrGMtYhDocW
 S1BsdhXwZm/ZwX/lRCJsySp5/sbvwdhWGXpEVtpYpvsLAnLNLp+wvkdESySR2A1yka5M
 wib1pi/O+tUYOHF1/RVpVYZpdcyehKF2CvjRyieIo4DrqkPvZo8Wvx3eIs29+dytRWO/
 +x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4/0zY6u1RnApvmJHF2Wye5hDyNvlXySXtkNAZsbxooA=;
 b=rRtbYYIsaQMD+pmjuH4UiyJhqJfrTHNWFMazl+AXxPa3F6iSIcConQKQWgDlAoSfen
 f+2vsdCmUkSKJPMQgmAHFv0QhtvLQdadZFRXznHjE4ZS5CB2eacn65yCysnz7OfFq3Uo
 27m/k9nWNr1woOJ/xWY4WUQalE1T72g4CB8gLtaXPI5KqcyWEZWdiqm4C6zTJdAMHIBb
 pZP5gsvGzneCCfYJpG7xaPbxpj8WSSBixm9ZE0In3XmUDjfkBjotJshKnXfj3VvvN/7x
 BcPj2MPJR1iPPnTHdfwlTBk6GAgruVj5B5t0KXyYosngpcJXS7sNdgtybhE7QbEf10uf
 IrLQ==
X-Gm-Message-State: AA+aEWab0mzMaPn7hOV4w+Bxabsw5LTYkb20FxgfKPValAiro/5nf8ys
 ExyoDdirAg+1oF79hVCh5kcVlA==
X-Google-Smtp-Source: AFSGD/XtIo2IPa6vdIXA6faQeaIDcdrNb8/xev1hGKBKrWAotKnKX+UF7Ruj43lhdmQ0t5yvKEomhw==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr14319964wrh.317.1545143733076; 
 Tue, 18 Dec 2018 06:35:33 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
 by smtp.gmail.com with ESMTPSA id 202sm2863061wmt.8.2018.12.18.06.35.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 06:35:32 -0800 (PST)
Date: Tue, 18 Dec 2018 15:27:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Message-ID: <20181218142756.GA2031@nanopsycho>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_063545_415291_535814E9 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org>,
 " <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, linux-lpwan@lists.infradead.org,
 "David S . Miller" <davem@davemloft.net>, Dollar Chen <dollar.chen@wtmec.com>,
 Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 "<linux-arm-kernel@lists.infradead.org\\"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Tue, Dec 18, 2018 at 03:27:09PM CET, starnight@g.ncu.edu.tw wrote:
>> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
>> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
>> >
>> >This patch implements part of Class A end-devices SoftMAC defined in
>> >LoRaWAN(TM) Specification Ver. 1.0.2:
>> >1. End-device receive slot timing
>> >2. Only single channel and single data rate for now
>> >3. Unconfirmed data up/down message types
>> >
>> >On the other side, it defines the basic interface and operation
>> >functions for compatible LoRa device drivers.
>> >
>> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
>> >---
>> >V2:
>> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
>> >  LoRaWAN Soft MAC modules
>> >- Modify for Big/Little-Endian
>> >- Use SPDX license identifiers
>> >
>> >V3:
>> >- Remove the decoration word - inline of the functions
>> >- Order local variables from longest to shortest line in the functions
>> >- Change the calling mac_cb function to lrw_get_mac_cb macro
>> >
>> >V4:
>> >- Fix the delay period between RX window#1 and window#2
>> >- Fix by coding style report from scripts/checkpatch.pl
>> >
>> >V5:
>> >- Initial rx_skb_list when it is allocated with LoRa hardware
>> >- Check the sk_buff's data length before access it
>> >- Deal FPort field and decrypt payload in lrw_parse_frame function
>> >- Drop the recieved frame if parse failed
>> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
>> >
>> > net/maclorawan/Kconfig  |  14 +
>> > net/maclorawan/Makefile |   2 +
>> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
>> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
>> > 4 files changed, 1177 insertions(+)
>> > create mode 100644 net/maclorawan/Kconfig
>> > create mode 100644 net/maclorawan/Makefile
>> > create mode 100644 net/maclorawan/mac.c
>> > create mode 100644 net/maclorawan/main.c
>>
>>
>> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
>> you add headers for "API" and here you implement functions. That is just
>> weird. Does it mean you can have other implementations?
>
>LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
>This part is soft-MAC as Andreas mentioned
>http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html

Okay, that does not answer my concern about header file in one patch and
the actual implementation of functions in another one.


>
>> Also, you don't really have any user of this API in the set. Please
>> introduce at least 1 driver, preferably more (I see that Andreas has
>> multiple ones in his patchset). You cannot push kernel infrastructure
>> without kernel user.
>
>The soft-MAC is suitable for the LoRa chips' device drivers, like
>sx1276/77/78/79, RFM95/96/97/98W ...
>Still waiting for Andreas' sx1276 version 2 patch and more discussion.
>For example, how to make PF_LORA and PF_LORAWAN like Ethernet, PF_INET
>and PF_INET6 don't need separate devices either, both use eth0.
>https://lkml.org/lkml/2018/8/3/266

Then you should push this is RFC or together with Andreases work in a
single patchset. Infra without users cannot be merged.


>
>Jian-Hong Pan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
