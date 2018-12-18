Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EEDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E52D2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHDJ3hqc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="VdYwOgta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E52D2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g9MWIp06xhxakbxuL9Ia1mHsY36uAUIPA08eYFF/XMM=; b=eHDJ3hqc0R5H8k
	EvshhBlZHKS8cuMLNQ9y6I67Emuz6cwyVsKhFcTTx8VhpgGZF5cC/oXx61og3jOaz9w/pRyuins7r
	bnZEv01t2PJR1PbsVYrgehgdeSYBdXh4y26jQd469vczrUtB0hMeNKgr6sFpnlA5MSrC14sy0URh/
	NeG14th8mBOwN8uJzUYo+ztAzG5j5grCIJ5GgjIXAmcAR7bJgdARTXlmMjZBswwCHC6Im9W7Cqo2G
	JSPnLRdq2KFNwuk3xZA9+BGd4HdE7hoOi2UA2A7hs1YRxrU2fsZhSTT1jYG6JsCQAhqZgnt3NMimT
	lGAk7OdZuS9I2ZUu0B4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHOH-0000uc-7L; Tue, 18 Dec 2018 15:34:37 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHO6-0000sK-Fz
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:34:34 +0000
Received: by mail-oi1-x244.google.com with SMTP id i6so2263431oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zRcpSDgKBunETK4jngTuaWDbCUphXpYDKqI0rFAN6ng=;
 b=VdYwOgtalgTEQ412UEhrLyvhKiVp6UVMMgPk8ZbrsIhWs81CVJNDe/jBg10x4iiDl4
 s5W8atvzTPFAj0GI+0DVkFs/HcaxSI4tUfkXiXSvsUQjVGfsxl/U/irbEjLLApwWBU4s
 ApjWDPNgSKTpaDroEbAy9MvFXwMvgcT3qK6sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zRcpSDgKBunETK4jngTuaWDbCUphXpYDKqI0rFAN6ng=;
 b=r4NxEWb+zHxTSWwH829g3rW2nThiO50W8+ufiWESty66NOH1+n/IcEDNg6KYgvJras
 Wgy6ZWmCAbKf/gkzUHYfVfv0zw8klGAv0FNW9HTOWmhztwjb2PIBNglWX50D4WUIFm60
 9hydILt3lZMB+szs1CZqVXMRwbIFyOikLfLLWcjVgCnXc451FypgHNNcFnGt0G8HZ+8B
 zkZwFMQO6vluzH5EYijDb+/q5hDW2gw6IWdb/rm9dGjJMAfEZusWOXKIvISWqUnDriqH
 wN6k+UlnKkCOLy8WJ28KP6G8z/ABpzBK3VnrfDV6U5pamyR8mE2Hw6zTAsY/ZygqwqHq
 /ojg==
X-Gm-Message-State: AA+aEWbrcMcGLAmSOBAiiQxg1SPHVIXEKXcbPvoiJfvbMGNSvnXF37MZ
 zN8S2WXTRYduuA/Y+eNAh2Fq5I5RdfhhGg==
X-Google-Smtp-Source: AFSGD/VGi0+Uy7HRZe5/b4kyMZFLnoEonxfkKEWqqFA07w38dqJHkPUf6pPgtSdcluFJ8VbiUddi+w==
X-Received: by 2002:aca:d414:: with SMTP id l20mr8300424oig.107.1545147254695; 
 Tue, 18 Dec 2018 07:34:14 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com.
 [209.85.167.179])
 by smtp.gmail.com with ESMTPSA id q131sm7269739oih.1.2018.12.18.07.34.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:34:13 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id v6so2284798oif.2;
 Tue, 18 Dec 2018 07:34:13 -0800 (PST)
X-Received: by 2002:aca:e401:: with SMTP id b1mr7717991oih.231.1545147253134; 
 Tue, 18 Dec 2018 07:34:13 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <20181218142756.GA2031@nanopsycho>
In-Reply-To: <20181218142756.GA2031@nanopsycho>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Tue, 18 Dec 2018 23:34:19 +0800
X-Gmail-Original-Message-ID: <CAC=mGzifRScmq6VOtWE1QSJUUrOEG81gF2C8eiYYRnmBRUbWCw@mail.gmail.com>
Message-ID: <CAC=mGzifRScmq6VOtWE1QSJUUrOEG81gF2C8eiYYRnmBRUbWCw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To: Jiri Pirko <jiri@resnulli.us>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_073426_547521_5189421F 
X-CRM114-Status: GOOD (  21.51  )
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

> Tue, Dec 18, 2018 at 03:27:09PM CET, starnight@g.ncu.edu.tw wrote:
> >> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> >> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
> >> >
> >> >This patch implements part of Class A end-devices SoftMAC defined in
> >> >LoRaWAN(TM) Specification Ver. 1.0.2:
> >> >1. End-device receive slot timing
> >> >2. Only single channel and single data rate for now
> >> >3. Unconfirmed data up/down message types
> >> >
> >> >On the other side, it defines the basic interface and operation
> >> >functions for compatible LoRa device drivers.
> >> >
> >> >Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> >> >---
> >> >V2:
> >> >- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
> >> >  LoRaWAN Soft MAC modules
> >> >- Modify for Big/Little-Endian
> >> >- Use SPDX license identifiers
> >> >
> >> >V3:
> >> >- Remove the decoration word - inline of the functions
> >> >- Order local variables from longest to shortest line in the functions
> >> >- Change the calling mac_cb function to lrw_get_mac_cb macro
> >> >
> >> >V4:
> >> >- Fix the delay period between RX window#1 and window#2
> >> >- Fix by coding style report from scripts/checkpatch.pl
> >> >
> >> >V5:
> >> >- Initial rx_skb_list when it is allocated with LoRa hardware
> >> >- Check the sk_buff's data length before access it
> >> >- Deal FPort field and decrypt payload in lrw_parse_frame function
> >> >- Drop the recieved frame if parse failed
> >> >- Fix the bug which passes wrong skb properties from maclorawan to lorawan module
> >> >
> >> > net/maclorawan/Kconfig  |  14 +
> >> > net/maclorawan/Makefile |   2 +
> >> > net/maclorawan/mac.c    | 555 ++++++++++++++++++++++++++++++++++++
> >> > net/maclorawan/main.c   | 606 ++++++++++++++++++++++++++++++++++++++++
> >> > 4 files changed, 1177 insertions(+)
> >> > create mode 100644 net/maclorawan/Kconfig
> >> > create mode 100644 net/maclorawan/Makefile
> >> > create mode 100644 net/maclorawan/mac.c
> >> > create mode 100644 net/maclorawan/main.c
> >>
> >>
> >> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> >> you add headers for "API" and here you implement functions. That is just
> >> weird. Does it mean you can have other implementations?
> >
> >LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> >This part is soft-MAC as Andreas mentioned
> >http://lists.infradead.org/pipermail/linux-lpwan/2018-December/000010.html
>
> Okay, that does not answer my concern about header file in one patch and
> the actual implementation of functions in another one.

Just for clarification:
- Patch "net: lorawan: Add LoRaWAN socket module" is for lorawan module
- Patch "net: lorawan: Add LoRaWAN API declaration for LoRa devices"
containes the header file "include/linux/lora/lorawan.h" which will be
included by LoRa device drivers or other kernel modules.
- Patches "net: maclorawan: Add maclorawan module declaration", "net:
maclorawan: Implement the crypto of maclorawan module" and "net:
maclorawan: Implement maclorawan class module" are for maclorawan
module.

Question 1:
Should I marge "net: maclorawan: Add maclorawan module declaration",
"net: maclorawan: Implement the crypto of maclorawan module" and "net:
maclorawan: Implement maclorawan class module" into a single patch
named "net: maclorawan: Add maclorawan as the soft-MAC module"?

Then:
For example, after a LoRa device driver includes the header
"linux/lora/lorawan.h", the device driver will call "lrw_alloc_hw()"
and pass with a "struct lrw_operations" type of variable's pointer.
It gets a type of "struct lrw_hw *" pointer.  Then, it will call
"lrw_register_hw()" to register the device.  The device driver
implements the callback functions for the "struct lrw_operations" type
of variable by it self before calls "lrw_alloc_hw()".

Question 2:
Should the patch "net: lorawan: Add LoRaWAN API declaration for LoRa
devices" also be merged into "net: maclorawan: Add maclorawan as the
soft-MAC module" or "net: maclorawan: Implement maclorawan class
module"?  Or, just leave it as a single patch?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
