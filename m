Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9D8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:33:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8897121874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fu0wGl6h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxmhsFtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8897121874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Aah1AgAc0INtFiQZfG+NELTeuKPid5k8EQqwC7WXhOc=; b=Fu0wGl6hVs/9B78X2O8GwlMFJJ
	VtdhmtAhT6X0j7hGYzb4NhzvkkyRnBxb8qzD80/VUJWl7rO0KLmCyNtaUt5PMFwhVVOyHTbCnMCSX
	uKNWWzVjKqmSWMocYbywBbveY8UV8oIYdiKJkHL5hE2e/ZRuY6IXgX93hT5WTqmE4Asbo5OSM11tU
	3EmpLgoQM2DGw+JgEWKTvfzFinTBmEBEX3rYNsNgTi72bx2S27NCH+FYBbO4nNmcZCCgn3hOg8UPD
	eA5UGNgvdReSpOQKVY/e3zHqQpzUNh70KohhOPvJUmk9WxdKBXuEBX0GjU9LLupcN1dCfIzlPUz4w
	saj5GNvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfRTO-0001zv-Tl; Fri, 04 Jan 2019 15:33:22 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfRTL-0001z2-98
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 15:33:21 +0000
Received: by mail-oi1-x243.google.com with SMTP id j21so30626959oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=EDSJw3EIzlCAgExM5GoNP03698kOkKD1pAV6WmIy/Qs=;
 b=BxmhsFtg5ghUrxH2ZT8rwevMYmH4bt8rsQmeTiXBSo5xwsRhXFEg6PdA5vOTdUwe69
 FDs9lcnI4NQ3RJTSRtzPlM93MaLGgY23QB/eO1WXpO7gL0bqXB6IGEM/iB7kKvUUzHXF
 Z11kxeEwRJA599Yx1MhwS+94Nq3+5nRDiOH0Pq75xq18suxMVkbPFyNykXQk1e57O7Wm
 ff1+HybMjtrCAP6J1pnueyl9YweJSN/xF3BxQaVuyIkAkqcVrm60f18adll/FlgzaEvG
 f7vr6FyOlpKGU+Hflibtjmsg6XFgQKwtzDP3MwBtGBorN/4xGxPRUVRK6sJ0/SdxXgMx
 BeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=EDSJw3EIzlCAgExM5GoNP03698kOkKD1pAV6WmIy/Qs=;
 b=HBufwgQqnkX0albu2kv/7ubd/rklrUjgMOBYnDiprtXSP20LmEsibs0or5fQdeY+2A
 pOpCLYuAbfVPdXXHXBGvhvxK+yonE6jjwR2+UZYPdE6rJ3f/RYTZVZtcvHqrFWPb7q2p
 dkXQHe15yQlyLoO43So/NH6VpdPE5fD7QMC/w9/yHoIURj7YX8fCt4UShiDzACjt38AQ
 CK7De7u0O+CJHbvMI+00Jn5iry1YqZvn3GQdKIDCuwQcMFxCpimEJvvQ/ZqoJ37QzfmW
 7Ok+pbk1E6P8vwnFylfmC3wAI3y10penDRjztnSheb1OvyWU97fVEhRTNx6Dk7FR+8ZS
 xpMw==
X-Gm-Message-State: AJcUukdh9NZEF6BgD7MpXM5qJxeV+R5heUh/EY6A0wXWogjMNOPcrYvg
 8Y5B0a4WuHHYZlip5L64j80gadiHHdhmaJE0bTZyT5Nq
X-Google-Smtp-Source: ALg8bN74RMIzbHbotBSA53jFcHrSI+UPyDiWrC89PqSHgRO3dHDuuy/iFRqv9kcB9nFiCNmt3/kWbDRTVfXGPI6EFWk=
X-Received: by 2002:a54:478f:: with SMTP id o15mr1416999oic.42.1546615997035; 
 Fri, 04 Jan 2019 07:33:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGUNXRRpPBLkN6CQMKsKn5GxWJHxkat2TsWfpxO8wsxXDiqqBw@mail.gmail.com>
In-Reply-To: <CAGUNXRRpPBLkN6CQMKsKn5GxWJHxkat2TsWfpxO8wsxXDiqqBw@mail.gmail.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Fri, 4 Jan 2019 15:33:05 +0000
Message-ID: <CAGUNXRQquMJ7od5Z_+YPJ-6bUxQpNgpzFC3u5jYDedjQKKEiTQ@mail.gmail.com>
Subject: Re: imx8mq-evk: Outbound network packets lost
To: linux-imx@nxp.com, U-Boot-Denx <u-boot@lists.denx.de>, 
 linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_073319_348984_D4862A65 
X-CRM114-Status: GOOD (  20.02  )
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

On Thu, 3 Jan 2019 at 12:53, Chris Spencer <spencercw@gmail.com> wrote:
> Hi,
>
> I'm trying to get the i.MX8MQ-EVK board up and running with the
> recently added kernel support (I'm currently working off
> arm-soc/for-next) and am having some trouble with the networking. If I
> issue a ping from my test machine with tcpdump running on both sides I
> see this:
>
> On dev machine:
> 10:57:52.655882 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> 10:57:53.677046 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> 10:57:54.701024 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> 10:57:55.725050 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
>
> On imx8:
> 00:05:16.514604 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> 00:05:16.514651 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> Freescale), length 28
> 00:05:17.578275 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> 00:05:17.578298 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> Freescale), length 28
> 00:05:18.644896 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> 00:05:18.644932 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> Freescale), length 28
> 00:05:19.711548 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> 00:05:19.711561 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> Freescale), length 28
>
> So the imx8 can receive packets, but anything it sends back seems to
> be lost. The machines are connected directly with a standard patch
> cable. I have tried with two different test machines and network
> cables with the same results. Firewalls are disabled on both sides.
> tcpdump shows 0 packets dropped by kernel on both sides.
>
> Kernel output related to the Ethernet controller:
> [    0.550204] libphy: Fixed MDIO Bus: probed
> [    0.555023] fec 30be0000.ethernet: 30be0000.ethernet supply phy not
> found, using dummy regulator
> [    0.564204] fec 30be0000.ethernet: Linked as a consumer to regulator.0
> [    0.575518] libphy: fec_enet_mii_bus: probed
> ...
> [    6.479277] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full -
> flow control rx/tx
> [    6.487386] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>
> Potentially useful command output:
> # ip addr
> ...
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
>     link/ether 00:04:9f:05:a5:a5 brd ff:ff:ff:ff:ff:ff
>     inet 10.60.9.15/24 brd 10.60.9.255 scope global eth0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::204:9fff:fe05:a5a5/64 scope link
>        valid_lft forever preferred_lft forever
> # ifconfig eth0
> eth0      Link encap:Ethernet  HWaddr 00:04:9F:05:A5:A5
>           inet addr:10.60.9.15  Bcast:10.60.9.255  Mask:255.255.255.0
>           inet6 addr: fe80::204:9fff:fe05:a5a5/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:32 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:20 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:2332 (2.2 KiB)  TX bytes:1080 (1.0 KiB)
>
> Is anyone able to provide some insight on what might be happening here?
>
> Thanks,
> Chris

I've been digging into this further and it seems to be potentially
related to U-Boot. If I use the version of U-Boot that is shipped with
the device on the eMMC and use that to manually boot into my SD card
then the Ethernet controller seems to work fine.

It looks like perhaps the physical layer is not being initialised
properly. If I execute the following commands on the bundled U-Boot
everything looks normal:

u-boot=> mdio list
FEC0:
0 - AR8031/AR8033 <--> ethernet@30be0000
u-boot=> mii info
PHY 0x00: OUI = 0x1374, Model = 0x07, Rev = 0x04, 1000baseX, FDX
u-boot=> mii read 0 2
004D
u-boot=> mii read 0 3
D074

But on my own build of U-Boot (current master
7436f5e54d35bcad53befec90e2e67288071f74e), it seems every request to
the physical layer is returning zero, resulting in it using the
generic PHY driver instead of the AR8031:

u-boot=> mdio list
FEC0:
0 - Generic PHY <--> ethernet@30be0000
u-boot=> mii info
PHY 0x00: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x01: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x02: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x03: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x04: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x05: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x06: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x07: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x08: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x09: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x0A: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x0B: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x0C: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x0D: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x0E: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x0F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x10: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x11: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x12: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x13: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x14: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x15: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x16: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x17: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x18: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x19: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x1A: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x1B: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x1C: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x1D: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x1E: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
PHY 0x1F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
u-boot=> mii read 0 2
0000
u-boot=> mii read 0 3
0000

I have added some tracing to drivers/net/fec_mxc.c:fec_mdio_read() and
the read seems to be proceeding normally (i.e., it gets an interrupt
indicating that the read has completed), but the value always comes
back as zero.

# Clear MII interrupt in ENET_EIR
writel(800000, 30be0004)
# Re-check ENET_EIR; as expected, the interrupt is not set
readl(30be0004) => 0
# Issue a read request to ENET_MMFR for phy 0 reg 2
writel(600a0000, 30be0040)
# Check ENET_EIR; the MII interrupt has been set, indicating the
transfer has completed
readl(30be0004) => 800000
# Clear the interrupt
writel(800000, 30be0004)
# Read the data from ENET_MMFR; the value is zero. I would expect to
see 004d in the lower 16 bits here
readl(30be0040) => 600a0000

There's a decent chance I'm missing something obvious, but I'm not seeing it..

Thanks,
Chris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
