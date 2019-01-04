Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EA0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sSKkccci";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsjy8Uah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EA0218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8Wd7k8ZminpY4uU6Yp65YFkaeyJeIhfQJ+0NPh8Slps=; b=sSKkccciNki4zrt7NGOtsed67L
	3UfSPN7MkfHa096vSOFHVsIptRsVan0nSQXajQ9jFL5rjqllNIs2QAlxDCcbp1l41vgupEdsZgR4V
	yiENz/IALPe2sbmc0Hu0oREvVyLErNymhrr9dpyCbMXynislMtfsasYhtUGt9GZJs/le8HfijJNYq
	Iwvyg6G8l4nGwZdET3cDFOvZ51TWW6iF9FgqFpZtrwkOKYD+3lBZxd5+yPwuvKx98oTIuT6GYrSCq
	8QsOc74cY54vewPwApJBFQCJ/U8Il5QQbhd3zwrkLMuDQzs6QETpSFZ6EEvMR7zDLoeONxNCedqTc
	GUMfVNxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfShq-0006XU-6i; Fri, 04 Jan 2019 16:52:22 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfShm-0006X2-U5
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 16:52:20 +0000
Received: by mail-ot1-x344.google.com with SMTP id 40so32571427oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=0kNeVu5O1/Er3qPxqBYKcrWwjq25w/8rgELWbLGY+7Q=;
 b=jsjy8UahxOIV79S4ZkseihlZlZmM0Z+PhT5FzOKkOtiQNEzdZPrWfiHzJoPYIkSGZY
 8JDG89XnE33vxBAzZ3tHDe3WBObIn2HFeE8dXHdKHFsid3rh9r+ipgO3hqRZYnTgxyNl
 E3Mr0PTFfZ1c4ThlzKqvzSjBHXpbuR2a7pDUXa6JQdxPPF5n2J45eBpNrvCfYGmfAJls
 7oiwTGmEtUB6SyyKmPQGUEecPb9kmzjPnADX6PCIOCWGp76Bz1s30wbih8WDN3x+734l
 14CzzvqwclYrF6jTWK502ivC3nE6u5VJKh46vtzWnL2ZVvf8If/OtD+0F8aC7QXnCMDF
 Ox9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=0kNeVu5O1/Er3qPxqBYKcrWwjq25w/8rgELWbLGY+7Q=;
 b=icbPLw8i8Njk8ZkaCHsIQ0s9iQHABR3EIMEmmisP9kAGzOeuOu8h8y3CMjy+ffLx4+
 bpjPI4wUU5ZXnE4tCFATNuNPTYWc0rXsjZVlc3MOyp9BSdea2teBYtHnwxyQXDhkXiau
 6NCOdYkp4TbHsnBzcFqKPOog11gwFTH5ad2v4q6OD0ZK2uWJC3EyLHVyP78DYJzT0oVb
 ipNimOeqZqVP2uLfI4xYJpT+5bsGu6qNpRUeFwjIkYKnFDhgBkwN3CBTItOHFkkoNKrn
 4vfySnRh/tag4c2ZtUa0BKZLBf4h60tXpOUzxXxGFYljt8iyGiq8ZtsINCYBecRdnPGx
 HtbQ==
X-Gm-Message-State: AJcUukc/vy+cGnVHzKbH6/jnKzj+dE6T2QlDIkvKKsRIZLM2Ar/wja97
 Ezc6h4yvaT9TTa7M9rO9cbdccBv8Ya8nntqDT7E=
X-Google-Smtp-Source: ALg8bN75vClOdi24njLRAJQm6VndruX3WhkaFTP+6pss59isnYlYisPncZWcdgoydOWwRhH+Wg/jxk7G66ZdDU9f9K4=
X-Received: by 2002:a9d:3bc7:: with SMTP id k65mr37219576otc.11.1546620737846; 
 Fri, 04 Jan 2019 08:52:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGUNXRRpPBLkN6CQMKsKn5GxWJHxkat2TsWfpxO8wsxXDiqqBw@mail.gmail.com>
 <CAGUNXRQquMJ7od5Z_+YPJ-6bUxQpNgpzFC3u5jYDedjQKKEiTQ@mail.gmail.com>
In-Reply-To: <CAGUNXRQquMJ7od5Z_+YPJ-6bUxQpNgpzFC3u5jYDedjQKKEiTQ@mail.gmail.com>
From: Chris Spencer <spencercw@gmail.com>
Date: Fri, 4 Jan 2019 16:52:05 +0000
Message-ID: <CAGUNXRTEArPTcTBuoqVixF_ZAcJPVVDUPiKW7FjEEAuqfhj_sQ@mail.gmail.com>
Subject: Re: imx8mq-evk: Outbound network packets lost
To: linux-imx@nxp.com, U-Boot-Denx <u-boot@lists.denx.de>, 
 linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_085219_059226_A79D514C 
X-CRM114-Status: GOOD (  29.01  )
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

On Fri, 4 Jan 2019 at 15:33, Chris Spencer <spencercw@gmail.com> wrote:
>
> On Thu, 3 Jan 2019 at 12:53, Chris Spencer <spencercw@gmail.com> wrote:
> > Hi,
> >
> > I'm trying to get the i.MX8MQ-EVK board up and running with the
> > recently added kernel support (I'm currently working off
> > arm-soc/for-next) and am having some trouble with the networking. If I
> > issue a ping from my test machine with tcpdump running on both sides I
> > see this:
> >
> > On dev machine:
> > 10:57:52.655882 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > 10:57:53.677046 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > 10:57:54.701024 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> > 10:57:55.725050 ARP, Request who-has 10.60.9.15 tell linux-dev, length 28
> >
> > On imx8:
> > 00:05:16.514604 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > 00:05:16.514651 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > Freescale), length 28
> > 00:05:17.578275 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > 00:05:17.578298 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > Freescale), length 28
> > 00:05:18.644896 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > 00:05:18.644932 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > Freescale), length 28
> > 00:05:19.711548 ARP, Request who-has 10.60.9.15 tell 10.60.9.101, length 46
> > 00:05:19.711561 ARP, Reply 10.60.9.15 is-at 00:04:9f:05:a5:a5 (oui
> > Freescale), length 28
> >
> > So the imx8 can receive packets, but anything it sends back seems to
> > be lost. The machines are connected directly with a standard patch
> > cable. I have tried with two different test machines and network
> > cables with the same results. Firewalls are disabled on both sides.
> > tcpdump shows 0 packets dropped by kernel on both sides.
> >
> > Kernel output related to the Ethernet controller:
> > [    0.550204] libphy: Fixed MDIO Bus: probed
> > [    0.555023] fec 30be0000.ethernet: 30be0000.ethernet supply phy not
> > found, using dummy regulator
> > [    0.564204] fec 30be0000.ethernet: Linked as a consumer to regulator.0
> > [    0.575518] libphy: fec_enet_mii_bus: probed
> > ...
> > [    6.479277] fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full -
> > flow control rx/tx
> > [    6.487386] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> >
> > Potentially useful command output:
> > # ip addr
> > ...
> > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq qlen 1000
> >     link/ether 00:04:9f:05:a5:a5 brd ff:ff:ff:ff:ff:ff
> >     inet 10.60.9.15/24 brd 10.60.9.255 scope global eth0
> >        valid_lft forever preferred_lft forever
> >     inet6 fe80::204:9fff:fe05:a5a5/64 scope link
> >        valid_lft forever preferred_lft forever
> > # ifconfig eth0
> > eth0      Link encap:Ethernet  HWaddr 00:04:9F:05:A5:A5
> >           inet addr:10.60.9.15  Bcast:10.60.9.255  Mask:255.255.255.0
> >           inet6 addr: fe80::204:9fff:fe05:a5a5/64 Scope:Link
> >           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
> >           RX packets:32 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:20 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:2332 (2.2 KiB)  TX bytes:1080 (1.0 KiB)
> >
> > Is anyone able to provide some insight on what might be happening here?
> >
> > Thanks,
> > Chris
>
> I've been digging into this further and it seems to be potentially
> related to U-Boot. If I use the version of U-Boot that is shipped with
> the device on the eMMC and use that to manually boot into my SD card
> then the Ethernet controller seems to work fine.
>
> It looks like perhaps the physical layer is not being initialised
> properly. If I execute the following commands on the bundled U-Boot
> everything looks normal:
>
> u-boot=> mdio list
> FEC0:
> 0 - AR8031/AR8033 <--> ethernet@30be0000
> u-boot=> mii info
> PHY 0x00: OUI = 0x1374, Model = 0x07, Rev = 0x04, 1000baseX, FDX
> u-boot=> mii read 0 2
> 004D
> u-boot=> mii read 0 3
> D074
>
> But on my own build of U-Boot (current master
> 7436f5e54d35bcad53befec90e2e67288071f74e), it seems every request to
> the physical layer is returning zero, resulting in it using the
> generic PHY driver instead of the AR8031:
>
> u-boot=> mdio list
> FEC0:
> 0 - Generic PHY <--> ethernet@30be0000
> u-boot=> mii info
> PHY 0x00: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x01: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x02: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x03: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x04: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x05: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x06: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x07: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x08: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x09: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x0A: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x0B: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x0C: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x0D: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x0E: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x0F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x10: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x11: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x12: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x13: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x14: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x15: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x16: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x17: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x18: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x19: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x1A: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x1B: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x1C: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x1D: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x1E: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> PHY 0x1F: OUI = 0x0000, Model = 0x00, Rev = 0x00,  10baseT, HDX
> u-boot=> mii read 0 2
> 0000
> u-boot=> mii read 0 3
> 0000
>
> I have added some tracing to drivers/net/fec_mxc.c:fec_mdio_read() and
> the read seems to be proceeding normally (i.e., it gets an interrupt
> indicating that the read has completed), but the value always comes
> back as zero.
>
> # Clear MII interrupt in ENET_EIR
> writel(800000, 30be0004)
> # Re-check ENET_EIR; as expected, the interrupt is not set
> readl(30be0004) => 0
> # Issue a read request to ENET_MMFR for phy 0 reg 2
> writel(600a0000, 30be0040)
> # Check ENET_EIR; the MII interrupt has been set, indicating the
> transfer has completed
> readl(30be0004) => 800000
> # Clear the interrupt
> writel(800000, 30be0004)
> # Read the data from ENET_MMFR; the value is zero. I would expect to
> see 004d in the lower 16 bits here
> readl(30be0040) => 600a0000
>
> There's a decent chance I'm missing something obvious, but I'm not seeing it..
>
> Thanks,
> Chris

The plot thickens... I updated my Trusted Firmware-A BL31 [1] and that
seems to have fixed the problem on the Linux side. I'm not sure what
revision I was on before, but it would have been around 2-3 weeks out
of date. It still doesn't work at all in U-Boot, although I'm not
going to lose too much sleep if I can't get that to work.

Chris

[1] https://github.com/ARM-software/arm-trusted-firmware
9a207532f8216bf83fed0891fed9ed0bc72ca450

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
