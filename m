Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:42:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79B120859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UDmI8Alo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juclmqFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79B120859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QINuwHi/nd/QVyhvM1eJLS175Kjh6PY83aCYsAVauCE=; b=UDmI8Alouzij2n
	hLxCYMN3Wls0fFeBAWbbHZAtQKhoKT3kOh/syfLTFpOYSyHHlNEJu5q8KiPZrUyLEvyqhry174Hid
	inscP5BpK98vLYhbUxBB6xKU098z6wL8IzrWNhmzxZ7Sy5uY8qoL0vMurSkfKwKddWwE5bSKn17+K
	lUH/WRfGzeUZ/XxdPdaGmVjkcUE15YMJHGhHERTE94XzFuhA4CzglG6P2P5s++Av4N8T3LnIKdM0G
	utc9SDZ2fUJKdMnAh8ClM/KXlyFpVQMysRuyUxSRD8uUgsBB4E1lZOI77Y5QraQFrd/MJyMyf3h4N
	VkXg/kLPJsNn/swmJxxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRQX-0004h6-P9; Mon, 07 Jan 2019 09:42:33 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRQU-0004gd-L2
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:42:32 +0000
Received: by mail-oi1-x242.google.com with SMTP id m6so35345356oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XnSIVwNVJ3gQjQTnYiN7ni0F5aGM4ukpC4+joBvWW9M=;
 b=juclmqFlKl1wATvtcI+NUI6BGovOVb4l5AXwYvkxF5le+higzX4cWL9dLg5yljrJPJ
 GZle7TibPDh3VbPGK6ihffVBcIz3KutCr2BQl5sAuUsUm3EX/25P3vfqpJg/P5rzo8gk
 V4O5++mfNasuGSb0Y493UvFSUeQHWe0+BAYmd5WjrJtocfdEzLKgsGzU36PkySCPEJoH
 tjS2N8fZKUxm3rfz80GUvsuSOjn4DDQApC0u2wQ/0BNTOrovZu1YRa37M0A2/4t9CFlG
 1SxGlwmBN2DbQkpYl5HxmgIxd/iRFOXwzrCp+JKsZeeLt1PeQiZPKFjvlUpycMk/HAik
 T6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XnSIVwNVJ3gQjQTnYiN7ni0F5aGM4ukpC4+joBvWW9M=;
 b=GWrzgirypYsJbwFU2jOeNZT8ZNnYR8p9ixfpZmEG1FCIjc6ZR3WR0P3iG7lCK9vxzA
 zulgWI/qyOUajpwoBjNXW8Yj4rFP+r/oGJKcYA39kqTv4gsnhdo+xBwWIDk+bUSc7fnj
 kroX68q2+aCmZT5MJK4uhmYGj3h6pbNy3AnVlDY8qhrNK4g+NPdQL+ZzUG0fdg2E7C/t
 PE71oL0SEBBXCDgB2JT32rkyvMb7DKYQ8r0LG/n+Xw3jypKLAVbBRevk+LSiOVP8qZEL
 MtKxka4hGHpr2rWerD0Xs9C61nf+jiPf1yFt/KuD5Nmx5x0IlVl3dzI5uLBpBK4NHXkK
 +zFw==
X-Gm-Message-State: AJcUukdJK+ib38wz6cbYrUEkogghRUWZrqM9XAa7HEcpvcr7BHL+4/Xx
 ikPd3mblutyO2uz2LlHO9lrJ1veYzQitwLpRuL8MgbDF
X-Google-Smtp-Source: ALg8bN63W90liuZp2c6z3GXEBJsdaxjW3wkXbkFSbJELRltYCKp8sK3Klakcncn9kwwasdg3sbrr6qgN5CsLGwz7XDU=
X-Received: by 2002:aca:51c6:: with SMTP id f189mr7287333oib.281.1546854149355; 
 Mon, 07 Jan 2019 01:42:29 -0800 (PST)
MIME-Version: 1.0
References: <CAGUNXRRpPBLkN6CQMKsKn5GxWJHxkat2TsWfpxO8wsxXDiqqBw@mail.gmail.com>
 <CAGUNXRQquMJ7od5Z_+YPJ-6bUxQpNgpzFC3u5jYDedjQKKEiTQ@mail.gmail.com>
 <CAGUNXRTEArPTcTBuoqVixF_ZAcJPVVDUPiKW7FjEEAuqfhj_sQ@mail.gmail.com>
In-Reply-To: <CAGUNXRTEArPTcTBuoqVixF_ZAcJPVVDUPiKW7FjEEAuqfhj_sQ@mail.gmail.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Mon, 7 Jan 2019 09:42:17 +0000
Message-ID: <CAGUNXRQw4KeLdrknP7yVvN6LP+itivtxM6DkJRxcjpe0tRA6=g@mail.gmail.com>
Subject: Re: imx8mq-evk: Outbound network packets lost
To: linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_014230_723689_27580801 
X-CRM114-Status: GOOD (  37.33  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 4 Jan 2019 at 16:52, Chris Spencer <spencercw@gmail.com> wrote:
> On Fri, 4 Jan 2019 at 15:33, Chris Spencer <spencercw@gmail.com> wrote:
> > On Thu, 3 Jan 2019 at 12:53, Chris Spencer <spencercw@gmail.com> wrote:
> > > Hi,
> > >
> > > I'm trying to get the i.MX8MQ-EVK board up and running with the
> > > recently added kernel support (I'm currently working off
> > > arm-soc/for-next) and am having some trouble with the networking. If I
> > > issue a ping from my test machine with tcpdump running on both sides I
> > > see this:
> > >
> > > On dev machine:
> > > 10:57:52.655882 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > > 10:57:53.677046 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > > 10:57:54.701024 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > > 10:57:55.725050 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > >
> > > On imx8:
> > > 00:05:16.514604 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > > 00:05:16.514651 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > > Freescale), length 28
> > > 00:05:17.578275 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > > 00:05:17.578298 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > > Freescale), length 28
> > > 00:05:18.644896 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > > 00:05:18.644932 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > > Freescale), length 28
> > > 00:05:19.711548 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > > 00:05:19.711561 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > > Freescale), length 28
> > >
> > > So the imx8 can receive packets, but anything it sends back seems to
> > > be lost. The machines are connected directly with a standard patch
> > > cable. I have tried with two different test machines and network
> > > cables with the same results. Firewalls are disabled on both sides.
> > > tcpdump shows 0 packets dropped by kernel on both sides.
> > >
> > > Kernel output related to the Ethernet controller:
> > > [    0.550204] libphy: Fixed MDIO Bus: probed
> > > [    0.555023] fec 30be0000.ethernet: 30be0000.ethernet supply phy not
> > > found, using dummy regulator
> > > [    0.564204] fec 30be0000.ethernet: Linked as a consumer to regulator.0
> > > [    0.575518] libphy: fec_enet_mii_bus: probed
> > > ...
> > > [    6.479277] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full -
> > > flow control rx/tx
> > > [    6.487386] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > >
> > > Potentially useful command output:
> > > # ip addr
> > > ...
> > > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
> > >     link/ether 00:04:9f:05:a5:a5 brd ff:ff:ff:ff:ff:ff
> > >     inet 10.60.9.15/24 brd 10.60.9.255 scope global eth0
> > >        valid_lft forever preferred_lft forever
> > >     inet6 fe80::204:9fff:fe05:a5a5/64 scope link
> > >        valid_lft forever preferred_lft forever
> > > # ifconfig eth0
> > > eth0      Link encap:Ethernet  HWaddr 00:04:9F:05:A5:A5
> > >           inet addr:10.60.9.15  Bcast:10.60.9.255  Mask:255.255.255.0
> > >           inet6 addr: fe80::204:9fff:fe05:a5a5/64 Scope:Link
> > >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> > >           RX packets:32 errors:0 dropped:0 overruns:0 frame:0
> > >           TX packets:20 errors:0 dropped:0 overruns:0 carrier:0
> > >           collisions:0 txqueuelen:1000
> > >           RX bytes:2332 (2.2 KiB)  TX bytes:1080 (1.0 KiB)
> > >
> > > Is anyone able to provide some insight on what might be happening here?
> > >
> > > Thanks,
> > > Chris
> >
> > I've been digging into this further and it seems to be potentially
> > related to U-Boot. If I use the version of U-Boot that is shipped with
> > the device on the eMMC and use that to manually boot into my SD card
> > then the Ethernet controller seems to work fine.
> >
> > It looks like perhaps the physical layer is not being initialised
> > properly. If I execute the following commands on the bundled U-Boot
> > everything looks normal:
> >
> > u-boot=> mdio list
> > FEC0:
> > 0 - AR8031/AR8033 <--> ethernet@30be0000
> > u-boot=> mii info
> > PHY 0x00: OUI = 0x1374, Model = 0x07, Rev = 0x04, 1000baseX, FDX
> > u-boot=> mii read 0 2
> > 004D
> > u-boot=> mii read 0 3
> > D074
> >
> > But on my own build of U-Boot (current master
> > 7436f5e54d35bcad53befec90e2e67288071f74e), it seems every request to
> > the physical layer is returning zero, resulting in it using the
> > generic PHY driver instead of the AR8031:
> >
> > u-boot=> mdio list
> > FEC0:
> > 0 - Generic PHY <--> ethernet@30be0000
> > u-boot=> mii info
> > PHY 0x00: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x01: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x02: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x03: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x04: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x05: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x06: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x07: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x08: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x09: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x0A: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x0B: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x0C: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x0D: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x0E: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x0F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x10: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x11: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x12: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x13: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x14: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x15: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x16: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x17: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x18: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x19: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x1A: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x1B: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x1C: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x1D: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x1E: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > PHY 0x1F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> > u-boot=> mii read 0 2
> > 0000
> > u-boot=> mii read 0 3
> > 0000
> >
> > I have added some tracing to drivers/net/fec_mxc.c:fec_mdio_read() and
> > the read seems to be proceeding normally (i.e., it gets an interrupt
> > indicating that the read has completed), but the value always comes
> > back as zero.
> >
> > # Clear MII interrupt in ENET_EIR
> > writel(800000, 30be0004)
> > # Re-check ENET_EIR; as expected, the interrupt is not set
> > readl(30be0004) => 0
> > # Issue a read request to ENET_MMFR for phy 0 reg 2
> > writel(600a0000, 30be0040)
> > # Check ENET_EIR; the MII interrupt has been set, indicating the
> > transfer has completed
> > readl(30be0004) => 800000
> > # Clear the interrupt
> > writel(800000, 30be0004)
> > # Read the data from ENET_MMFR; the value is zero. I would expect to
> > see 004d in the lower 16 bits here
> > readl(30be0040) => 600a0000
> >
> > There's a decent chance I'm missing something obvious, but I'm not seeing it..
> >
> > Thanks,
> > Chris
>
> The plot thickens... I updated my Trusted Firmware-A BL31 [1] and that
> seems to have fixed the problem on the Linux side. I'm not sure what
> revision I was on before, but it would have been around 2-3 weeks out
> of date. It still doesn't work at all in U-Boot, although I'm not
> going to lose too much sleep if I can't get that to work.
>
> Chris
>
> [1] https://github.com/ARM-software/arm-trusted-firmware
> 9a207532f8216bf83fed0891fed9ed0bc72ca450

Any chance somebody from NXP can comment on this?

It seems updating the TF-A didn't actually do anything, it's just the
problem is erratic.

I have added some trace logging to the Linux 5.0-rc1 fec_main.c and
have found that the very first MDIO read often incorrectly returns
zero:

[    0.584706] fec_enet_mdio_read(mii_id = 0, regnum = 2) => 0
[    0.590566] fec_enet_mdio_read(mii_id = 0, regnum = 3) => d074

This results in the Generic PHY driver being used instead of the
Atheros 8031 and things don't work properly. Occasionally, the correct
value will be returned any everything works fine:

[    0.584674] fec_enet_mdio_read(mii_id = 0, regnum = 2) => 4d
[    0.590623] fec_enet_mdio_read(mii_id = 0, regnum = 3) => d074

I can work around the issue with this patch:

diff --git a/drivers/net/ethernet/freescale/fec_main.c
b/drivers/net/ethernet/freescale/fec_main.c
index ae0f88bce9aa..802f51308b2d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1789,6 +1789,7 @@ static int fec_enet_mdio_read(struct mii_bus
*bus, int mii_id, int regnum)
         goto out;
     }

+    udelay(100);
     ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));

 out:

It seems that the interrupt is being triggered before the register is
actually ready to be read. I tried a 10us delay but the value returned
from the very first read was random and incorrect.

Thanks,
Chris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
