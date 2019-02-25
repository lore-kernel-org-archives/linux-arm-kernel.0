Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE93C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:46:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C2C20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="soPs1r3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C2C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LVfajMgXNbjdCrqjkmBzc6r4HZPvAKO3ZvdwXLOTxWU=; b=soPs1r3UM3YDJ6
	tZS10XFNxMdR6Gowta09txkKOXXXwk2vGQ1tsjxlwsIOG2pi7EvpgdZE4Sdtw6kwdN/eatOgR5S5n
	6nym9TIg8XZaZC879zo2QzLpfOZERNAG5faaDVg9fHmbjzpD6jocUvbYMfGkYF92lU70VBg/BF0dB
	cVPm1LBmYCmtZHoTFOU7ehI3lJbqDlZ3qe4emmQqLORC9PEjaCFhsN0FSVMCwOa+FjMLHDICEveTR
	pjdh41pqhAFw8cwsaFnyO6tbIyW9O7YNhB8q5nZPganGOILHy3Kytaz7KLAUvwn4rvZXHtCZWO1Q0
	WdcJLzj2QfGGk7jDRG6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyDmR-0004oO-Vm; Mon, 25 Feb 2019 10:46:39 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyDmN-0004nz-HE
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 10:46:38 +0000
X-Originating-IP: 109.212.201.85
Received: from localhost (alyon-652-1-170-85.w109-212.abo.wanadoo.fr
 [109.212.201.85])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7D8421C000D;
 Mon, 25 Feb 2019 10:46:23 +0000 (UTC)
Date: Mon, 25 Feb 2019 11:46:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 0/8] add power management support for SAM9X60
Message-ID: <20190225104622.GA11983@piout.net>
References: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_024635_717027_C3FB5119 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com, linux@armlinux.org.uk,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/2019 15:54:26+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Hi,
> 
> This series add power management support for SAM9X60. The following
> platform specific power management modes were enabled for it:
> Idle, ULP0 and ULP1.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (8):
>   ARM: at91: pm: introduce at91_soc_pm structure
>   dt-bindings: arm: atmel: add binding for SAM9X60 SoC
>   ARM: at91: pm: initial PM support for SAM9X60
>   ARM: at91: pm: keep at91_pm_backup_init() only for SAMA5D2 SoCs
>   ARM: at91: pm: add support for per SoC wakeup source configuration
>   ARM: at91: pm: add ULP1 support for SAM9X60
>   ARM: at91: pm: disable RC oscillator in ULP0
>   ARM: at91: pm: do not disable/enable PLLA for ULP modes
> 

All applied.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
