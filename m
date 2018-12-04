Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5222EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E091F2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7olTslP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="EIz4ikbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E091F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5IyDvMY+8RJKjtkRu31lHkCeUzcw/5Ny146FtqhhC4Y=; b=G7olTslPIVIiI0
	WP+PC907DW5qkIUL9x3IdL8sdf5Eews7lqhVDYhuuU/GtM9aIqcStVz5vb/rGw/+ElGTpayVe5olg
	vucfXCrUI7bEhOurlTQT7ePS2Hdp63+RBu3m+TLCKwb2Q0MbWz+sbVGQId2Tu1XwA+g/VV0QQCi5c
	RCDflbwJN82ovRuWDSjeAlllcFYj1E4AYmckU44T85KYtcrkPLbB5rvpjGEejNozi6lvlUDxXoX4/
	GXw6a7h/jhNZFzq9DggTTPbYgLHPQIsbPRRhYFaSEtlRHu1U0vr+1Qec8i2QgG6QjOnfNa+X15R45
	jsMgu6BCelXk939KHA9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBUJ-0000lE-Vt; Tue, 04 Dec 2018 14:15:47 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBTq-0007iJ-14
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:15:20 +0000
Received: by mail-pf1-x443.google.com with SMTP id 64so8267357pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=g.ncu.edu.tw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8JPiqVruzrD5OGaZzdip19sastO5p9E3ha1IKkMYs/A=;
 b=EIz4ikbfLjJhka7KtNZTWOVLwnJG2BE1jDRQZU8gGzbfCrKPE4Xft9SVix9Xsz4/dr
 DQ7vJ0nBSEfKsvqY1AaA+IV07GVS7OaSFkvm7tytU2D+BX+reKdcVSokKkpu9O5j3Y9/
 tDfJvJY6alklmXm5iA/gSGfjY5oeD5J8kTLJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8JPiqVruzrD5OGaZzdip19sastO5p9E3ha1IKkMYs/A=;
 b=kGpB0rb+kcoUsL/buKHd50JLqlTCMc/z4HaY67EtJnskvK0nyxZ1FePfvBUlyOkAQU
 +KjCJ8yxhQV1PSiQDFXwHQUCz5Q6OmvjvcUVbExE+VJps6qwLfPtPJQnrxI/oISNyMIT
 N7aFNzBhUQ2VWDMNtPkXg8uMwJyyjXHTz/Nukg+yL6bW7VMTIwVyFoRnTNkJOkNGPMov
 DuZSzk2zAPEUazo7Bhvm6GgGxSwgtGCsUQe2GJRf1W33RMo41ivKZC9wOuv62e8K9VR5
 5fQZ0Ecg412W0ktdjRvM6led183GQafZmLm6J3YpBoNBtCdc26LKNh0w5G6xAUzJBir5
 CMtQ==
X-Gm-Message-State: AA+aEWbyRZK/KRsNiDkYX5f8uZ4WRpmgQN5KtQ02Bz8bMrAldYWXGPwQ
 n55Q3ytuTOKUlR+JYGHAnSdrMw==
X-Google-Smtp-Source: AFSGD/U8jvgr5ygk7IiXzVM4RoOJoR5pGRq0PsdpspeDhmhInQMIIIaP2wWjBtn2+DL3gDfirwSWGA==
X-Received: by 2002:a62:5950:: with SMTP id n77mr19999151pfb.128.1543932904969; 
 Tue, 04 Dec 2018 06:15:04 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
 by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 06:15:04 -0800 (PST)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH V4 0/6] net: lorawan: Add LoRaWAN soft MAC module
Date: Tue,  4 Dec 2018 22:13:36 +0800
Message-Id: <20181204141341.4353-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061518_461323_4AD8FCC8 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 linux-kernel@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 linux-wpan@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.

LoRaWAN networks typically are laid out in a star-of-stars topology in
which gateways relay messages between end-devices and a central network
server at the backend.  Gateways are connected to the network server via
standard IP connections while end-devices use single hop LoRa(TM) or FSK
communication to one or many gateways.

A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
optional features (Class B, Class C ...):
* Bi-directional end-devices (Class A)
* Bi-directional end-devices with scheduled receive slots (Class B)
* Bi-directional end-devices with maximal receive slots (Class C)

This patch set add LoRaWAN class module implementing the stack,
especially the soft MAC, between socket APIs and LoRa device drivers.

socket APIs:
send and receive the data
------------------------------------------------------------------------
LoRaWAN class module implements soft MAC:
append the header/footer, encryption/decryption, timing slot and MAC
commands
------------------------------------------------------------------------
LoRa device drivers:
send and receive the messages for MAC layer
------------------------------------------------------------------------
LoRa devices

This module starts from simple and implements partial Class A
end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
More features and complexity, for example regional parameters, confirmed
data messages, join request/accept messages for Over-The-Air Activation,
MAC commands ... will be added in the future.

Jian-Hong Pan (6):
  net: lorawan: Add LoRaWAN socket module
  net: lorawan: Add LoRaWAN API declaration for LoRa devices
  net: maclorawan: Add maclorawan module declaration
  net: maclorawan: Implement the crypto of maclorawan module
  net: maclorawan: Implement maclorawan class module
  net: lorawan: List LORAWAN in menuconfig

 include/linux/lora/lorawan.h        | 131 ++++++
 include/linux/lora/lorawan_netdev.h |  52 +++
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 686 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 212 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 518 +++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 200 ++++++++
 net/maclorawan/main.c               | 605 ++++++++++++++++++++++++
 14 files changed, 2463 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h
 create mode 100644 include/linux/lora/lorawan_netdev.h
 create mode 100644 net/lorawan/Kconfig
 create mode 100644 net/lorawan/Makefile
 create mode 100644 net/lorawan/socket.c
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/maclorawan.h
 create mode 100644 net/maclorawan/main.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
