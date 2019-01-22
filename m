Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74700C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B8B20684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pPKoWYuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B8B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ovfRqBAPiXX6b9CZkTCCQEK/WSGfHX0hS5VXwE+bg9E=; b=pPKoWYuU4masla
	d7yFyVIn4JH9xY8Q1W7/HaZ4Y1f9C3+xopPtQgzfcZH3q54wauE2dJetKGi6D2L9YbToigCBwEx0C
	npq7MpgALgqX5c90NZv78gV86tYs9DrLIlcAsCZkN0elJq3yhNTQzFBmATLwv+mfb1TTv17SRmDQa
	O0vpFB7R/tZnBbHszdHre3dYDkrynmNz2BM6TsCY3EIxlzVEftFNtO08kQAOAthCxtdLf1SfNuzBu
	Jqz0Z6lmx+GDMUAlx56M3QzmipsP8l2uLqbS+2iNuAxluk6L/qDkajfb+AbnH69GLcHBcRc2djkke
	Zro8LtqmqjNginF5P+9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwTO-0006WN-J4; Tue, 22 Jan 2019 13:52:14 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwTL-0006Vk-VK
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:52:13 +0000
Received: by mail-vs1-f68.google.com with SMTP id e7so14732487vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KcDFAfFc7EsqJTg783tpvFYSuv3o+l1WYw+Ppm1hEvI=;
 b=UD6t05hnY/jvL6VE5wHpRoo9mGAfo0JW3RAg/HnnHxFfAeQkjO1coU9YD8AcZpU663
 VJHd/10huGjP9AwOkRs1LyIDQkS/qP8JvsurRwXxM6LmazIULtzNVEgqZK+PDytPnM/M
 XWAc5g86u5Ypf20Pg+3gi3iIcKIGigL2sqYl051xdcHKP/e5B/uxCnqYoMd2w9QjnALm
 wRrFQ8aSIPE0XblPguXQ2DDjMClaGltOxlrBn/HjSwgM29xLKqFxQaEhMNDWAA0b5Btk
 Ydae0g8nu6fSthW8uoImlpxKBcfm6YHn2LwSeOD4VGLLOEAP/pw6cbLqm9KQOVKxZEMS
 Jicw==
X-Gm-Message-State: AJcUukcupVIu3UC+u6XeyA3/DmM4GhY+efguD2aU4TLoyK2H6Vtki5SB
 SCp5n6c0mMuKaCxMEnIeVdqKmfiS4s+usyXKUuM=
X-Google-Smtp-Source: ALg8bN6c22dYFsVRGpMa59s/KE5nkBHTAEWeY7ZXm0O6YfV0fhNcm/uNPbKipDrSQyf15xnpm7+wc8n56TswjgTcVvQ=
X-Received: by 2002:a67:c202:: with SMTP id i2mr13578963vsj.11.1548165130536; 
 Tue, 22 Jan 2019 05:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
In-Reply-To: <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Jan 2019 14:51:58 +0100
Message-ID: <CAMuHMdUz6J2cG-NCYPTRyS=1QZHGBWUFZPqj4ShEdioQLqu9qw@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To: Heiner Kallweit <hkallweit1@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_055212_009367_0A083B0F 
X-CRM114-Status: GOOD (  23.54  )
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
 Krzysztof Kozlowski <krzk@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>, "David S. Miller" <davem@davemloft.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Heiner,

On Fri, Jan 18, 2019 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> > On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> >> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> >> Expected:
> >> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> >> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
> >>
> >> Result:
> >> [ 15.614964] Root-NFS: no NFS server address
> >> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> >> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> >> [ 15.634252] Please append a correct "root=" boot option; here are the
> >> available partitions:
> >> [ 15.642791] 0100 16384 ram0
> >> [ 15.642804] (driver?)
> >> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> >> on unknown-block(2,0)
> >> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> >> root fs on unknown-block(2,0) ]---
> >>
> >> Bisect pointed to:
> >>     net: phy: check return code when requesting PHY driver module
> >
> > I see now in the logs:
> > [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> > driver module for ID 0x00221513
> > which is kind of misleading. There is no initramfs so there is no
> > usermod library at this point. It is not needed. This seems to break
> > all DHCP/NFS root boots without initrd/initramfs.
> >
> Thanks for the report. Could you please provide your kernel config
> and the syslog of a boot before or w/o the patch in question?
>
> If you boot via nfs then I'd expect that the PHY driver is built-in and
> not a module. Therefore it's not fully clear to me yet why
> request_module() returns -ENOENT.

I'm seeing the same booting nfsroot on several Renesas boards.
E.g. on r8a7791/koelsch:

    mdio_bus ee700000.ethernet-ffffffff:01: error -2 loading PHY
driver module for ID 0x00221537
    sh-eth ee700000.ethernet: MDIO init failed: -2

This failure happens only when CONFIG_MODULES=y.
Reverting commit 13d0ab6750b20957 ("net: phy: check return code when
requesting PHY driver module") fixes the issue.

phy_request_driver_module() tries to load module
"mdio:00000000001000100001010100110111", which fails.
When CONFIG_MODULES=n, the error is ignored, and everything works fine.

0b00000000001000100001010100110111 == 0x00221537 == PHY_ID_KSZ8041RNLI,
which is served by drivers/net/phy/micrel.c.
Interestingly, CONFIG_MICREL_PHY=y, so I'm wondering why the PHY subsystem
tries to load a module for a driver which is already present in the first
place?

Oh, the following comment tries to explain:

        /* Request the appropriate module unconditionally; don't
         * bother trying to do so only if it isn't already loaded,
         * because that gets complicated. A hotplug event would have
         * done an unconditional modprobe anyway.

Hence request_module() failures are normal.

       ret = request_module(MDIO_MODULE_PREFIX MDIO_ID_FMT,
                            MDIO_ID_ARGS(phy_id));
       /* we only check for failures in executing the usermode binary,
        * not whether a PHY driver module exists for the PHY ID
        */
       if (IS_ENABLED(CONFIG_MODULES) && ret < 0) {
               phydev_err(dev, "error %d loading PHY driver module for
ID 0x%08x\n",
                          ret, phy_id);
               return ret;
       }

However:

    /**
     * __request_module - try to load a kernel module
     * @wait: wait (or not) for the operation to complete
     * @fmt: printf style format string for the name of the module
     * @...: arguments as specified in the format string
     *
     * Load a module using the user mode module loader. The function returns
     * zero on success or a negative errno code or positive exit code from
     * "modprobe" on failure.

So perhaps the check should be for "ret > 0"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
