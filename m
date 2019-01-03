Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A8FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:54:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D902073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6lhUceI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrpTA6dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D902073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eCNxVBfUZ8Chuy+vCuPFv9kYDZ9tkx9bU7gbhIFnk4M=; b=Q6l
	hUceIq8GVNYNXEZV7p6pGolnid01Ws/Ahh1svTUoVdrh8ahGiz+df4FVdAQdlK9rKeGSa/tAzrAVw
	ghj/HFXGGtSzavEolO5BYtT+JyflTKYVNVTx/HYE4QyBpb1j1y/xqIFherS/KiucAir6D2IUl5+j9
	L0iLRB3xZR6T7LbQN9l+YNN1DJS82ifpFMaQcKoUd2tArJctP9rhbriQxLL0pgEc1PBuILqJo0s2F
	92tHfGD5RdY1VqE4Z74BCH67xSRKSrViRBbo0YFV0pndfCyV3beY7fy0Fb6MDBgUqTcNEucGIhJqE
	fy4Neb2meQnhZ/IU738HbntQhHv/RMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf2VY-000331-Fc; Thu, 03 Jan 2019 12:53:56 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf2VV-00032V-3E
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 12:53:54 +0000
Received: by mail-oi1-x232.google.com with SMTP id y1so27581926oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=3oLAzYZNzi8WebPWywyk10GRFc0ysW4X3QNan8jlg6o=;
 b=lrpTA6drhwwry2PI5HpA2yOVM+icQCtW4h++ZsC0MAQ3oAOvPzyHXQbYPe7XQXAM1l
 BLfL3XolMQ2o6Yzlz13g5K9q3Tg8eFMgqFOVL0R+zBr2Jp0RtPbJkNCBUpbaqsYI2D5p
 k3oR35pxpKc2oP7oB587LtbLrH5IH5XzJ1OaxZnqakCyp8t5pU5r02PcMjb5xWl2hyvI
 NRzuKRxOOq8dETegCyn9HXDJvGx5wPeIM7B8ce1v1I90JvnGInwBMvPh4O6TNqPwLZ2Z
 Dx4VpomWxiL4lOTIlW7gfaEscPBOP+4QxRbbGqFcOEMVIHY8c1O57lipBFOfFYCRFpN0
 SwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=3oLAzYZNzi8WebPWywyk10GRFc0ysW4X3QNan8jlg6o=;
 b=Y8Su+MH8moXggSgHWuXd5jAJaFWyF0BSaL9v+6bebSWtvVZ/LfudidyTuWOJ+T0cJS
 AWemR59/b++FuMNvO7VJuFMBwUWCDZnw6a6LQb+C5VJTUfphKGvUYpda8IDzsOBB/arb
 7oxD6e0JSz+hbWgWS/P5VrX5o3fQg9R5i0B0thKatEkEldn8FiQn/ToB938NrL1uQK2K
 yCoLZyL3BM+ics9LFPnB0+DSzhDUf7Qs9hsyJ7MYsay7rLYtJrpHiZP+Nq/utmqi04Ce
 rcaVeLGCmZe50AQ+Rz5tFVRDSPguNjCxnwioIMDkwxA1aJ/cjtEnmWJQn74nPXYv+Q9V
 RA9w==
X-Gm-Message-State: AJcUuke1KVmDMq1IKvnnNgiBFs574GREX1viGF95jyYaaXo8R0RvdSn8
 B6EgJFLDFQrC17vv+/3VQ1Kw20Sa8yDczVb5uy2c5xmm
X-Google-Smtp-Source: ALg8bN5FTTgait5D4avyU+daQM0epmUfei+LX76avyWPyUbQ737A+pOcrtHqnrCxDywCHpv69i8aM27It2hbNFJjJdI=
X-Received: by 2002:aca:51c6:: with SMTP id
 f189mr30484309oib.281.1546520031479; 
 Thu, 03 Jan 2019 04:53:51 -0800 (PST)
MIME-Version: 1.0
From: Chris Spencer <spencercw@gmail.com>
Date: Thu, 3 Jan 2019 12:53:40 +0000
Message-ID: <CAGUNXRRpPBLkN6CQMKsKn5GxWJHxkat2TsWfpxO8wsxXDiqqBw@mail.gmail.com>
Subject: imx8mq-evk: Outbound network packets lost
To: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_045353_165115_D9B3BA87 
X-CRM114-Status: UNSURE (   9.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

I'm trying to get the i.MX8MQ-EVK board up and running with the
recently added kernel support (I'm currently working off
arm-soc/for-next) and am having some trouble with the networking. If I
issue a ping from my test machine with tcpdump running on both sides I
see this:

On dev machine:
10:57:52.655882 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
10:57:53.677046 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
10:57:54.701024 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
10:57:55.725050 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28

On imx8:
00:05:16.514604 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
00:05:16.514651 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
Freescale), length 28
00:05:17.578275 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
00:05:17.578298 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
Freescale), length 28
00:05:18.644896 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
00:05:18.644932 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
Freescale), length 28
00:05:19.711548 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
00:05:19.711561 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
Freescale), length 28

So the imx8 can receive packets, but anything it sends back seems to
be lost. The machines are connected directly with a standard patch
cable. I have tried with two different test machines and network
cables with the same results. Firewalls are disabled on both sides.
tcpdump shows 0 packets dropped by kernel on both sides.

Kernel output related to the Ethernet controller:
[    0.550204] libphy: Fixed MDIO Bus: probed
[    0.555023] fec 30be0000.ethernet: 30be0000.ethernet supply phy not
found, using dummy regulator
[    0.564204] fec 30be0000.ethernet: Linked as a consumer to regulator.0
[    0.575518] libphy: fec_enet_mii_bus: probed
...
[    6.479277] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full -
flow control rx/tx
[    6.487386] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Potentially useful command output:
# ip addr
...
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
    link/ether 00:04:9f:05:a5:a5 brd ff:ff:ff:ff:ff:ff
    inet 10.60.9.15/24 brd 10.60.9.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::204:9fff:fe05:a5a5/64 scope link
       valid_lft forever preferred_lft forever
# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:04:9F:05:A5:A5
          inet addr:10.60.9.15  Bcast:10.60.9.255  Mask:255.255.255.0
          inet6 addr: fe80::204:9fff:fe05:a5a5/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:32 errors:0 dropped:0 overruns:0 frame:0
          TX packets:20 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2332 (2.2 KiB)  TX bytes:1080 (1.0 KiB)

Is anyone able to provide some insight on what might be happening here?

Thanks,
Chris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
