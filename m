Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E806DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:22:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F992184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AgeXVnBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F992184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LVwCImxTMenRSDrfNc4X8Xjg64ndENJN6iAuu1QRzLc=; b=AgeXVnBj+TMAvA
	kT8Oq6sEkLmf4reamaLEj8GLQ9zy049cIEjwJQe9lCSVOPnD/K8odPJiaKbV8bZVDF7eGV296nDOg
	pqGCmc1QGcAMKZKoX4EQj6lWPLEutvBxPsXMzz/TnRGlvNhWTFiuiphfDT9w/sEBp9tZUiq/qJjmT
	E+ZiJuY1Ukc2wfV8vd5keaAGDQBk5E3DmPJH7VSxttBRcUSQdD9YKcMMDq0U66R9vZ+kgPpfEZT2Q
	XvNuA2sDm5YY1lw55ODKuQock9ojFio83+7oUBIpP1OaeHnH5769Chdz80X2jpGnUEFgnW4VOSyb6
	v6kMLUlOGpp1n8BxpczQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmMEY-0003PD-8H; Wed, 23 Jan 2019 17:22:38 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmMEU-0003Ol-R4; Wed, 23 Jan 2019 17:22:36 +0000
Received: from oxbsltgw05.schlund.de ([212.227.220.149]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MpUQm-1hXVpH0Zg4-00pxKM; Wed, 23 Jan 2019 18:22:27 +0100
Date: Wed, 23 Jan 2019 18:22:26 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Scott Branden <scott.branden@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Message-ID: <1037403886.766203.1548264146309@email.ionos.de>
In-Reply-To: <616d33b6-a8c8-3ead-c0f5-f87ca71b84b6@broadcom.com>
References: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
 <616d33b6-a8c8-3ead-c0f5-f87ca71b84b6@broadcom.com>
Subject: Re: [PATCH 1/2] ARM: defconfig: Enable BCM2835_POWER for bcm2835
 and multi_v7
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:2GRRgIVH2jPJW6sn7m/b4Lu6I9eHoefqnhkwn+ZTsDXIuGlrUYm
 84jfeAuzG4lXDSskY8NrglXogUVGq1dApVhEcQBC5KKqPxbq3UAoT8X397hdGfZpzfFXX6v
 iiQlgn2myaKIqg5fMJx1eWFk1b2AwpRfeTbeJSdkVraTCxrVafTTh6VI+2J3nvGWBsvdFu3
 Puo9YyRQqYTGq1VURIVbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cu4hK7rdu0o=:xPIu1jdBM+472AeV4ahqZu
 C91uokdlrz/07hZil/Kod+f2etc3J/Y6NqmkoBmm56iy6vGiy1YXar/xqHKnjDArC3l5fXwBU
 Oy1xNAsEM3PE/1G7PSmWoP/0CtV0DqUOkyWrtemGMpnS+TiImJ1iOb2dAWOBeTtkxptDJevfx
 KIgCR7lKVG4yUveVo4bU4XGoYMln8ugPugWOZspGBLR1DBt7mLS084F25Zsc2jGTNBrT7kD+k
 Pu9gFeaeWZVuZXnkOsXDckLyvE5yz6wydPHf5a6T92RwlHuIW0yFDUx6MH6mSH1T3dIZmbgHc
 MQcvwH0Dy5gcRHLA09KBY8PXP0ewtDzvfNOFtYGrg0SRrswwRPN45wDq4O/t4P7u6ks1jJgPM
 T56SsFvj41dMhP4FnfhpzbcZc0GiJaFTocCz2X/7AaDJr4ektVDzeJXrx8ZevZtkoeN6fnaJK
 +DznhxQuFk9IHHm2RIwZIBcXizQVemUbaPtQm4jiihuOS3A9DpI5C/xxLVmF/EK37WVVVLlSC
 jM7S7L7afl1Bz7GV+JT7V9DWTv0bNzVgoCergW4qNH4IA6xdwp/J3Ijf8d6zRAPFoxnglARLT
 zL/KtHHn6tV02zbPAkweAO+urPcWLdSBDOpe7D+LoR+ORZiOfODlYhxRYBsQnGVh3ED3cdBjD
 ZVZu+TogEdL5WnMnnwqRf4ybOhK7ZvS/EzueDbKK8VZ6JsajIj2KzfyJGC1Z7pPXmRphKJji+
 P6WIhvrNWndoTxBxQTpy/8RK/g0C83qNAMq++Y0Z2wFVms25hCeWpRSjYmI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_092235_195244_1F751C92 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Scott,

> Scott Branden <scott.branden@broadcom.com> hat am 23. Januar 2019 um 17:41 geschrieben:
> 
> 
> Hi Stefan,
> 
> On 2019-01-23 6:07 a.m., Stefan Wahren wrote:
> > Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
> > PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.
> >
> > Otherwise the driver won't probe and HDMI output stays black:
> > vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >   arch/arm/configs/bcm2835_defconfig  | 1 +
> >   arch/arm/configs/multi_v7_defconfig | 1 +
> >   2 files changed, 2 insertions(+)
> 
> Seems more fool proof to add a default ARCH_BCM3825 in the Kconfig
> 
> instead of modifying multiple defconfig files.
> 
> And that way users with custom defconfig files for 2835 will get the 
> config change automatically.

i already thought about this, but it didn't worked for arm64. Maybe i missed something.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
