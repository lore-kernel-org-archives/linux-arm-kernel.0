Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:27:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99B4218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iU9P3Msd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="dMtfD8S8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B4218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zPS5Rj7+FoL/gBIdCEW1dcM0In9aHTrtSRzT4LvSyvk=; b=iU9P3MsdLtMGtP
	mjSJXtx1FrzpI1M4U/smr39YzxKB/2YxqqtCql9TjgwRR+Ib1AjcdMXrGOAvuqnq2mewY7nls2Dd9
	Ai0Y5/05oSwVpNClJY4brEWOdgq1MZhsQeGjoGBWgPn2vF/qbS335u0zcjqW7fQ/cNC5Tylq6ERh5
	Ldev75a6F7yY1hMOX3VZXbHTBwb7HIC4z/ZIM3y0DxiN+2boK447SFUDhiPjd4FuGiFVSbZTg6sx3
	J5V1ATh9f/vHnpIFqVorvmpmxledoayGz9DxIJcFkzBMCGWqYQLIubiv2v2g4fnvT4kQC/T4ONodv
	KOohG9uK+Uup4CblGjAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZegf-0002Si-Me; Wed, 19 Dec 2018 16:27:09 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZegc-0002RD-B4
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:27:08 +0000
Received: by mail-ot1-x341.google.com with SMTP id 81so19628194otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jnzynyxXBKN0VzR11tNbn7/6rP8TkQURHOc32KN9SI4=;
 b=dMtfD8S8Q6J7KUe39Srbno7FJZ1g+szZ3EI5hsvb50kY2d/fSRbaup6FO6MTWvsTsM
 1juxIDWbGYjbSUjuJWis5Qsc9j4mqaXMUc0KlqlQtviV0gJg6gYbZXxxkwXss7JH+0wN
 FL8TW3s0DdfVDpaJSCekwknrad+RhvzxidZwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jnzynyxXBKN0VzR11tNbn7/6rP8TkQURHOc32KN9SI4=;
 b=VwcA/wJrLjeLzp9Uw6CiDDQsY0XRmBu+o5T9AuxPdQSN5iSmeyyDgvFiGuWed1j83R
 yy/o7AfpFImEPo0uyg3QGLY4QomNS24OGQ7cDEZwgW1m9wbQMt4d9SXVI1ENHd4VmFwQ
 qLlLXVacB0W3OqcIyjoYlmSwMyK0JVheYFvRFfc4e2V2a65Yf1hxOeaSlv8fm5TrLAi7
 Hg5gP4cAJ6zuMQOpHIDoFfIlk69jEEGz60z7GtLZE00rnBQhWlrLXALf/YcxhOocwv/M
 ihA5m2TGERkZ5b+uXcRJ+O/1dl9v2L0uHGPNRqNrsVIe3Dq1SItg6jFHFYKbK911nxWm
 xQHw==
X-Gm-Message-State: AA+aEWbFREoZwYCqdvlaTh/lnc7oOYtwYVpnKyV9KmoUTocsZXSqDdLr
 EctQxUcDQcp4N2cc/9Eb+fdwqw==
X-Google-Smtp-Source: AFSGD/WASXF/5E0JTdTBIQs3OqnNU+RrZD/Rw3KpdAu7+17aGfgJbqVyKtMPg6ZAand3U0Y5oMXULg==
X-Received: by 2002:a9d:740e:: with SMTP id n14mr6194623otk.340.1545236813472; 
 Wed, 19 Dec 2018 08:26:53 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com.
 [209.85.167.178])
 by smtp.gmail.com with ESMTPSA id l20sm9112805otp.47.2018.12.19.08.26.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 08:26:52 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id y23so2083682oia.4;
 Wed, 19 Dec 2018 08:26:52 -0800 (PST)
X-Received: by 2002:aca:4d8f:: with SMTP id a137mr1551744oib.168.1545236811307; 
 Wed, 19 Dec 2018 08:26:51 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
 <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
In-Reply-To: <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Thu, 20 Dec 2018 00:26:57 +0800
X-Gmail-Original-Message-ID: <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
Message-ID: <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
To: Ben Whitten <Ben.Whitten@lairdtech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_082706_379736_35331F71 
X-CRM114-Status: GOOD (  31.47  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Pirko <jiri@resnulli.us>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Dollar Chen <dollar.chen@wtmec.com>,
 Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > Am 18.12.18 um 15:27 schrieb Jian-Hong Pan:
> > >> Sun, Dec 16, 2018 at 11:18:59AM CET, starnight@g.ncu.edu.tw wrote:
> > >>> LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa
> > devices.
> > >>>
> > >>> This patch implements part of Class A end-devices SoftMAC defined in
> > >>> LoRaWAN(TM) Specification Ver. 1.0.2:
> > >>> 1. End-device receive slot timing
> > >>> 2. Only single channel and single data rate for now
> > >>> 3. Unconfirmed data up/down message types
> > >>>
> > >>> On the other side, it defines the basic interface and operation
> > >>> functions for compatible LoRa device drivers.
> > >>>
> > >>> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > [...]
> > >>> net/maclorawan/Kconfig  |  14 +
> > >>> net/maclorawan/Makefile |   2 +
> > >>> net/maclorawan/mac.c    | 555
> > ++++++++++++++++++++++++++++++++++++
> > >>> net/maclorawan/main.c   | 606
> > ++++++++++++++++++++++++++++++++++++++++
> > >>> 4 files changed, 1177 insertions(+)
> > >>> create mode 100644 net/maclorawan/Kconfig
> > >>> create mode 100644 net/maclorawan/Makefile
> > >>> create mode 100644 net/maclorawan/mac.c
> > >>> create mode 100644 net/maclorawan/main.c
> > >>
> > >> I don't get it. In patch "Add LoRaWAN API declaration for LoRa devices"
> > >> you add headers for "API" and here you implement functions. That is just
> > >> weird. Does it mean you can have other implementations?
> > >
> > > LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa PHY.
> > > This part is soft-MAC as Andreas mentioned
> > > http://lists.infradead.org/pipermail/linux-lpwan/2018-
> > December/000010.html
> > >
> > >> Also, you don't really have any user of this API in the set. Please
> > >> introduce at least 1 driver, preferably more (I see that Andreas has
> > >> multiple ones in his patchset). You cannot push kernel infrastructure
> > >> without kernel user.
> > >
> > > The soft-MAC is suitable for the LoRa chips' device drivers, like
> > > sx1276/77/78/79, RFM95/96/97/98W ...
> > > Still waiting for Andreas' sx1276 version 2 patch and more discussion.
> >
> > sx1276 regmap conversion was pushed to my staging tree together with
> > Ben's sx1301 final conversion last night, lightly tested.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-
> > lora.git/log/?h=lora-next
> >
> > TBD: rename to sx127x, implement regmap fields, only auto-detect reset
> > when no OF node available (all low priority atm, patches welcome)
> >
> > (and for sx1301 I still need to update my DT overlays with the new clk)
> >
> > > For example, how to make PF_LORA and PF_LORAWAN like Ethernet,
> > PF_INET
> > > and PF_INET6 don't need separate devices either, both use eth0.
> > > https://lkml.org/lkml/2018/8/3/266
> >
> > Jiri, I am expecting the maclorawan driver to lower packets from
> > ETH_P_LORAWAN to ETH_P_LORA in a generic way, so that any of the LoRa
> > device drivers can benefit of it, with maclorawan using the LoRa netlink
> > commands that the individual drivers implement.
> > Not sure what if anything is missing for that in the current revision?
> > Still dealing with the lower-level infrastructure and my test setup ...
> > progressing slowly.
> >
> > I'll probably need to queue the remaining generic LoRaWAN part 1/6 in my
> > tree to resolve this circular dependency between Jian-Hong and me, so
> > that only the soft-MAC implementation remains a separate patch series.
> > The hard-MAC implementations will be on my plate mostly, as both SX1276
> > and SX1301 need the soft-MAC.
>
> On the SX1301 side of things, the ability to send messages as a LoRaWAN
> node device is a niche use case, the majority if not all people will use the
> concentrator card as the pass through gateway to the node.
>
> In this mode of operation the parameters for transmission such as; frequency,
> spreading factor / data rate, power, are given by a remote server and passed
> in from the userspace application which received it.
> Eventually in the kernel these need to be checked locally to ensure regulatory
> compliance.
> To that end I have experimented with framing, as CAN does, so that this
> metadata can be provided on a write from userspace to the SX1301 driver.
>
> Sounds like we need different protocols for framing within the protocol family.
> Raw in the case of nodes and framed with metadata in the case of concentrator
> cards, thoughts?

Yes, I have thought the roles of node and gateway.  They may have
different skb passing paths.
As you mentioned, many things of the gateway is controlled by the
remote server.  So, I only implement the path for nodes right now.
Maybe, we can have a role flag: node, gateway which can be assigned by
some way.  Then, the skb can be decode, checked and passed according
to the role flag.  And module also checks the integrity (MIC, length
...) and filter out the bad skb before sends to next stop.

> I will send my experiment RFC to the lpwan mailing list.

Or you can send the RFC first.  Then we can have the skb passing path
for gateway and figure out how to put them together.

Does this sound reasonable?

Regards,
Jian-Hong Pan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
