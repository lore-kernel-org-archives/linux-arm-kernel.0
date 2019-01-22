Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097D5C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:22:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C903E217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hPM5oAmJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLR+XGac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C903E217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/UAInnleGIVG79XROYePuQRLjEkkOkdwlsGs9cHH288=; b=hPM5oAmJMugeTe
	hdr2tMAKYUxaFylh5EhPcQdh5C8YJ7AmOUFVwzNXK0dFUqS92w/fnFdae3xMmx/Nb2SjcU7RhrmvC
	ZIVXNOqUDNU4OZNtW/00EPDMlkAVvuatLKICfymDJF6zMtpw76vSfIsVM3GPymWvQB4t06N1ajZmh
	rUoFP86DOynyPVpxjfUxgpPcmRkbs1Bv1I/Oba8m8rFaWFuCMOhbXtHJbhaqgUNa/uJJmYeRfxmnL
	Zqh05etj+IuTD44Wbb2OZ70VE2pur5QJDE58gHn7IltGwwMHLGVPFsse3YucyK5MDRwi3P6nrrP21
	AsWOo02Xknws2JVQCEWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwww-0005M2-I5; Tue, 22 Jan 2019 14:22:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwwt-0005Li-HT
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:22:45 +0000
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72D2B217F4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548166962;
 bh=SJbq+MbTDSRaJtMVQGVTLNT+jJsrO6+dvaVyDG2/iE4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wLR+XGachqOJN3SwBCCJoHPatf8PhRk0hNuzg+AR0kanKjbexGhgeAAy4om1n+uc2
 uJVvlWiQAPa498Ho2Zm8gvaDkE3lAQ5m+djVEz9tCdDUgmuUUQNLijBES9e/9nxRAK
 uqm5T1yGuQHKlBpIlv6skhlOJ0ZRXKMG3yyT17s0=
Received: by mail-lf1-f47.google.com with SMTP id i26so18230254lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 06:22:42 -0800 (PST)
X-Gm-Message-State: AJcUukdQbOrZrgU3v4y5KUMfA2ep8lJ1SaXKe8S4l1r2OVNijf569+vK
 GCcXNgDAzBwqeasa/aVdyB45gNDmC/Y8eVtXROo=
X-Google-Smtp-Source: ALg8bN5mEAZn2B3qgLIr97TphkudtFk+U7dDWJwXXbKMpL87TIvtf3BMhT7Sss+LDCb4n715glh72yraItlgtgZCRB4=
X-Received: by 2002:a19:4948:: with SMTP id l8mr997043lfj.156.1548166960348;
 Tue, 22 Jan 2019 06:22:40 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
 <CAMuHMdUz6J2cG-NCYPTRyS=1QZHGBWUFZPqj4ShEdioQLqu9qw@mail.gmail.com>
In-Reply-To: <CAMuHMdUz6J2cG-NCYPTRyS=1QZHGBWUFZPqj4ShEdioQLqu9qw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 22 Jan 2019 15:22:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcm3sMrAS8Yag-6YVUF7f=wGjst991WSVWeRMg2zk3FvA@mail.gmail.com>
Message-ID: <CAJKOXPcm3sMrAS8Yag-6YVUF7f=wGjst991WSVWeRMg2zk3FvA@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_062243_607755_89D1C49C 
X-CRM114-Status: GOOD (  22.80  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jan 2019 at 14:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Heiner,
>
> On Fri, Jan 18, 2019 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> > On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> > > On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> > >> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> > >> Expected:
> > >> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> > >> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
> > >>
> > >> Result:
> > >> [ 15.614964] Root-NFS: no NFS server address
> > >> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> > >> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> > >> [ 15.634252] Please append a correct "root=" boot option; here are the
> > >> available partitions:
> > >> [ 15.642791] 0100 16384 ram0
> > >> [ 15.642804] (driver?)
> > >> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> > >> on unknown-block(2,0)
> > >> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> > >> root fs on unknown-block(2,0) ]---
> > >>
> > >> Bisect pointed to:
> > >>     net: phy: check return code when requesting PHY driver module
> > >
> > > I see now in the logs:
> > > [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> > > driver module for ID 0x00221513
> > > which is kind of misleading. There is no initramfs so there is no
> > > usermod library at this point. It is not needed. This seems to break
> > > all DHCP/NFS root boots without initrd/initramfs.
> > >
> > Thanks for the report. Could you please provide your kernel config
> > and the syslog of a boot before or w/o the patch in question?
> >
> > If you boot via nfs then I'd expect that the PHY driver is built-in and
> > not a module. Therefore it's not fully clear to me yet why
> > request_module() returns -ENOENT.
>
> I'm seeing the same booting nfsroot on several Renesas boards.
> E.g. on r8a7791/koelsch:
>
>     mdio_bus ee700000.ethernet-ffffffff:01: error -2 loading PHY
> driver module for ID 0x00221537
>     sh-eth ee700000.ethernet: MDIO init failed: -2
>

Hi Geert,

There is a follow up patch:
https://www.spinics.net/lists/netdev/msg545573.html

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
