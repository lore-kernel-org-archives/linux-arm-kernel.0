Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFADC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:27:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6190020675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="axIWeSNQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="m1jJLvGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6190020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=idfcmqIJYCnQWCWnJbn3XIOH/MURozmp3JBSiRO5qrM=; b=axIWeSNQE8G4n4
	mpWylsR8nBv57mGWMU4ZBUgD7C/q3G1CLYA+wV+CT1/zI7kTz9TS2R/kSsG+swSXjFJhHCSe5so03
	/MFVfkdEOLfcwFCwnWF44HpOE/+6tegdKmu45Js9CZ734upPBWSV+mpwMUpTs2FcKWsynA9EamUEB
	1mctBN3oCgpNVNh3S4X/VnXgU4/2rgMjzP+ezTWSwfYHlF0zrodS9C7GPY7Pfl73SVp6nDZDOiLEg
	fRt9ly2oizhvyOHxL1ZltDaKZNpTkop7cHdAzyya3WKr0TtSOOsirbNu6z7xM7Ra02Ey4a3YejEzR
	sN6JYQBnEEOV8O4EOKEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGLB-00061Q-CK; Tue, 18 Dec 2018 14:27:21 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGL7-0005xL-37
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 14:27:19 +0000
Received: by mail-ot1-x342.google.com with SMTP id u16so15787040otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 06:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rBrK8cQ72TbNjqCTL0/cxQjz7lUhccTjfnchQwNrscc=;
 b=m1jJLvGYGeGJSTC2uwsAU1GbC48Vi3+LLS+/7Zn9Y2SoaAUQzYQNzKw/escLXzVDBV
 5noCt9Ql2cjw7LarZTxqZGVaQbMoSh0II/Va6TJNI2/7DyQiCf3i7teZw0gpawx20Ihm
 Sgl0EwXsgt0dFJ5iaWeh60xb4tF0DWl5UX5EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rBrK8cQ72TbNjqCTL0/cxQjz7lUhccTjfnchQwNrscc=;
 b=WH0B1pILWrBW1ZNcLvU8GHC4VWgFDq+r+PPYEqYTk4t4UzXiZpZ6pB62SR786FjWDs
 uD4gkkTVrjv54CfZLYdil845N2lFBka4lBYJLbF2nELstkkF0yr9pn/tEs4y8eGw5JMU
 Du5LEio+VBoKWG7OxO8d4PH0mH5Pdw8qxsyXAdnN03BVmV5hpIqHDxERJuWX36AMjVzK
 C0jzFg73InK1uGuUXpKY2xxlhX4eXSbxJa3A3bkk+aU3sX2U3ZGcQ3V/p64nXfMMEt/3
 8YNzoUHv36x8YoBSMzL3TXzfjB0dWD7DbNTYQCBPvYsTIe4ltgg8wOAkvmA5Sg+Ma/9r
 dwhg==
X-Gm-Message-State: AA+aEWYmv76gnZuKlyJ1HgGcUlavLTbX4kTfb9mL4YbPsxOI6w1hEzi1
 +NBcG01AvoSNowanPdpDR52o7A==
X-Google-Smtp-Source: AFSGD/XUhahvel+frqlLQ/PBc5rXBIGpIZURJOqPCWNZiEdpCgWjm0pgKZi5ZcU/zrO8ppM1gzOnXg==
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr12909818otb.165.1545143225296; 
 Tue, 18 Dec 2018 06:27:05 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com.
 [209.85.210.51])
 by smtp.gmail.com with ESMTPSA id g25sm1654280otr.30.2018.12.18.06.27.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 06:27:04 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id a11so15769017otr.10;
 Tue, 18 Dec 2018 06:27:03 -0800 (PST)
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr12017080otl.196.1545143223416; 
 Tue, 18 Dec 2018 06:27:03 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
In-Reply-To: <20181217140233.GG2096@nanopsycho>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue, 18 Dec 2018 22:27:09 +0800
X-Gmail-Original-Message-ID: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
Message-ID: <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To: Jiri Pirko <jiri@resnulli.us>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_062717_442274_003634E5 
X-CRM114-Status: GOOD (  16.91  )
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
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "<linux-arm-kernel@lists.infradead.org\\"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
> >
> >This patch implements part of Class A end-devices SoftMAC defined in
> >LoRaWAN(TM) Specification Ver. 1.0.2:
> >1. End-device receive slot timing
> >2. Only single channel and single data rate for now
> >3. Unconfirmed data up/down message types
> >
> >On the other side, it defines the basic interface and operation
> >functions for compatible LoRa device drivers.
> >
> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> >---
> >V2:
> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
> >  LoRaWAN Soft MAC modules
> >- Modify for Big/Little-Endian
> >- Use SPDX license identifiers
> >
> >V3:
> >- Remove the decoration word - inline of the functions
> >- Order local variables from longest to shortest line in the functions
> >- Change the calling mac_cb function to lrw_get_mac_cb macro
> >
> >V4:
> >- Fix the delay period between RX window#1 and window#2
> >- Fix by coding style report from scripts/checkpatch.pl
> >
> >V5:
> >- Initial rx_skb_list when it is allocated with LoRa hardware
> >- Check the sk_buff's data length before access it
> >- Deal FPort field and decrypt payload in lrw_parse_frame function
> >- Drop the recieved frame if parse failed
> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
> >
> > net/maclorawan/Kconfig  |  14 +
> > net/maclorawan/Makefile |   2 +
> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> > 4 files changed, 1177 insertions(+)
> > create mode 100644 net/maclorawan/Kconfig
> > create mode 100644 net/maclorawan/Makefile
> > create mode 100644 net/maclorawan/mac.c
> > create mode 100644 net/maclorawan/main.c
>
>
> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> you add headers for "API" and here you implement functions. That is just
> weird. Does it mean you can have other implementations?

LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
This part is soft-MAC as Andreas mentioned
http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html

> Also, you don't really have any user of this API in the set. Please
> introduce at least 1 driver, preferably more (I see that Andreas has
> multiple ones in his patchset). You cannot push kernel infrastructure
> without kernel user.

The soft-MAC is suitable for the LoRa chips' device drivers, like
sx1276/77/78/79, RFM95/96/97/98W ...
Still waiting for Andreas' sx1276 version 2 patch and more discussion.
For example, how to make PF_LORA and PF_LORAWAN like Ethernet, PF_INET
and PF_INET6 don't need separate devices either, both use eth0.
https://lkml.org/lkml/2018/8/3/266

Jian-Hong Pan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
