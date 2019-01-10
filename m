Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8872C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:34:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B2C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n/vIJ+wU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="eBaOCwHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B2C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1RbWFVoSOTWQpqcUEZC5Atwi65QedkEkCRbphWWNt8A=; b=n/vIJ+wUcyvEcF
	XxOHPC4oFKF5kaFb/BWUzJqQRprhBRTxAe+RtQ8kG1l/EVZWW+IGP4frWb59Y9GtT9g1bhu2JdcEA
	QCCjR9UDtpv7U5Bz5dqhUcRQNChIgYWaxkfcP0Dt4FCLokO52vcIRgaCw8i9Df3J/Mhm9cc+skMM8
	wk+35BgZvUcQi0T5hqCrmid4mi71uquINBUK/3d9EZpVQ1gNqOf98rzU2S8Ko8I4Dpz9nh41ZJ2KT
	cgvI+Eh2JjroDx2b0CHBBsvrp7ftaG/Ek2vXboIRTzxHfLm/la6Yl5wh6Fz189rTH5t/XAiIDuRnE
	Qs4P/033QWhrOr/gHNTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghTvb-0004f9-Am; Thu, 10 Jan 2019 06:34:55 +0000
Received: from mail.blih.net ([212.83.177.182])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghTvW-0004dy-Da
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 06:34:52 +0000
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
 by mail.blih.net (OpenSMTPD) with ESMTP id 96aecc77;
 Thu, 10 Jan 2019 07:34:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=mail;
 bh=GogRQGptvBC5dfRvDC+KanEe8sw=; b=eBaOCwHfPu4jMPOdDYQFVIUafsLJ
 IYONoZiIhdcrDmcCiBbZBsWNDzVJeMkjgv+5ftS6blTu4ij1YrSVKrVaIcrbpM+c
 WTzKDWNOzWXcZb2JUyHqeVVTY1Au+gU34ydGUDFYotbGZ5mjZFI6YAruzMNwMImQ
 r58QH7UkgrF/0tA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; q=dns; s=
 mail; b=WBvDwgnxuqyzorFtPHrtLI0brfor31nNmSNioY/bdrMGUXIyIGBIu3hN
 Dnrde468riN6GeYbOlx4lJk8q5kkL5pV5gOyliAmOzsgZpMYhbYeY9qXOFmAhcyV
 DzlYR/sdj4FDBwjrR9NtCTIdV8F28EuiXpGZydIacIukSFUwx7U=
Received: from knuckles.blih.net (ip-9.net-89-3-105.rev.numericable.fr
 [89.3.105.9]) by mail.blih.net (OpenSMTPD) with ESMTPSA id 1b096419
 TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
 Thu, 10 Jan 2019 07:34:43 +0100 (CET)
Date: Thu, 10 Jan 2019 07:34:43 +0100
From: Emmanuel Vadot <manu@bidouilliste.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
Message-Id: <20190110073443.75462677e45657b93b3f06e6@bidouilliste.com>
In-Reply-To: <dce82ebf-81d4-c5d3-2739-053c81afb31c@gmx.de>
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
 <87h8f09sbe.fsf@bootlin.com>
 <dce82ebf-81d4-c5d3-2739-053c81afb31c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_223450_873496_08B23673 
X-CRM114-Status: GOOD (  19.38  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Emmanuel Vadot <manu@freebsd.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


 Hello all,

 Sorry I forgot to answer this email.

On Wed, 26 Dec 2018 18:09:04 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> On 12/26/18 5:16 PM, Gregory CLEMENT wrote:
> > Hi Heinrich,
> >  =

> >  On ven., d=E9c. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
> > =

> >> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware=
. Any
> >> attempt to access it from Linux leads to an immediate crash.
> >>
> >> So let's make the same memory reservation as the vendor kernel.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > =

> > We got a similar patch one month ago and Russell King pointed that it
> > didn't match waht he saw on his MACCHIATObin:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612=
360.html
> > =

> > on mine under U-Boot I got:
> > =

> > Marvell>> md 0x4000000
> > 04000000: 00000000 00000007 00000005 00000040    ............@...
> > 04000010: 00000001 00001000 00000007 00000001    ................
> > 04000020: 00000008 00000000 00000009 00000000    ................
> > 04000030: 0000000a 00000000 ffffffff ffffffff    ................
> > 04000040: ffffffff ffffffff ffffffff ffffffff    ................
> > 04000050: ffffffff ffffffff ffffffff ffffffff    ................
> > 04000060: ffffffff ffffffff ffffffff ffffffff    ................
> > 04000070: ffffffff ffffffff ffffffff ffffffff    ................
> > 04000080: ffffffff ffffffff ffffffff ffffffff    ................
> > 04000090: ffffffff ffffffff ffffffff ffffffff    ................
> > 040000a0: ffffffff ffffffff ffffffff ffffffff    ................
> > 040000b0: ffffffff ffffffff ffffffff ffffffff    ................
> > 040000c0: ffffffff ffffffff ffffffff ffffffff    ................
> > 040000d0: ffffffff ffffffff ffffffff ffffffff    ................
> > 040000e0: ffffffff ffffffff ffffffff ffffffff    ................
> > 040000f0: ffffffff ffffffff ffffffff ffffffff    ................
> > =

> > In my case I have an old ATF, however this kind of setting should be
> > done by the bootloader.
> > =

> > I am interested by your claim about causing an immediate crash when
> > accessing this region. How did you trigger it?
> > =

> > Gregory
> =

> Hello Gregory,
> =

> judging from you U-Boot prompt you are not using mainline U-Boot. With
> the legacy Marvell U-Boot I get the same output as you provide above.
> But you are looking in the wrong place to confirm that this is ATF:
> =

> Marvell>> md 04017200
> 04017200: 616d6920 74206567 5043206f 474d2031     image to CP1 MG
> 04017210: 746f6e20 70757320 74726f70 000a6465     not supported..
> 04017220: 4f525245 20203a52 50435320 324c425f    ERROR:   SCP_BL2
> 04017230: 6f727720 6920676e 6620676d 616d726f     wrong img forma
> 04017240: 63282074 745f336d 3d657079 0a296425    t (cm3_type=3D%d).
> 04017250: 544f4e00 3a454349 43532020 6d492050    .NOTICE:  SCP Im
> 04017260: 20656761 73656f64 2074276e 746e6f63    age doesn't cont
> 04017270: 206e6961 66204d50 776d7269 0a657261    ain PM firmware.
> 04017280: 00000000 00000000 040144d0 00000000    .........D......
> 04017290: 00000001 00000019 4f525245 20203a52    ........ERROR:
> 040172a0: 6e695720 20776f64 203a6425 65736162     Window %d: base
> 040172b0: 64646120 73736572 616e7520 6e67696c     address unalign
> 040172c0: 74206465 7830206f 000a7825 67696c41    ed to 0x%x..Alig
> 040172d0: 7075206e 65687420 73616220 64612065    n up the base ad
> 040172e0: 73657264 6f742073 25783020 000a786c    dress to 0x%lx..
> 040172f0: 4f525245 20203a52 6e695720 20776f64    ERROR:   Window

 I do confirm what Heinrich is saying, this is needed (and made for)
mainline U-Boot.

> Possibly the legacy Marvell U-Boot is running at exception level 3
> (EL3). This would explain why you cannot reproduce the crash with that
> U-Boot.
> =

> The legacy Marvell U-Boot is in bad shape: their booti command cannot
> load the initrd.img created by Debian. This is why I use mainline
> U-Boot. Here you can find my recipe:

 I personnaly uses mainline U-Boot because the efi part is too old and
buggy on Marvell fork.

> https://github.com/xypron/u-boot-build/blob/macchiatobin/Makefile (for
> U-Boot v2018.11)
> =

> When I issue the md command for the region in mainline U-Boot  I get a
> crash:
> =

> =3D> md 0x4000000
> =

> =

> 04000000:"Synchronous Abort" handler, esr 0x96000210
> =

> =

> elr: 000000000006b878 lr : 000000000006b7f4 (reloc)
> =

> =

> elr: 000000007ff8b878 lr : 000000007ff8b7f4
> =

> =

> x0 : 0000000000000009 x1 : 0000000000000000
> =

> =

> x2 : 000000000000003a x3 : 0000000004000000
> =

> =

> x4 : 0000000000000000 x5 : 000000007ffae306
> =

> =

> x6 : 0000000000000004 x7 : 000000007fb0a1e0
> =

> =

> x8 : 000000007fb0a0a0 x9 : 0000000000000008
> =

> =

> x10: 00000000ffffffd0 x11: 0000000000000006
> =

> =

> x12: 000000000001869f x13: 000000000000440c
> =

> =

> x14: 000000007fb0a43c x15: 0000000000000008
> =

> =

> x16: 000000007ffb49ea x17: 000000007ffb49ea
> =

> =

> x18: 000000007fb0fdd8 x19: 0000000000000040
> =

> =

> x20: 0000000004000000 x21: 0000000004000000
> =

> =

> x22: 000000007ffacff1 x23: 0000000000000008
> =

> =

> x24: 0000000000000004 x25: 0000000000000004
> =

> =

> x26: 0000000000000004 x27: 000000007fb0a268
> =

> =

> x28: 0000000000000000 x29: 000000007fb0a1e0
> =

> =

> =

> Resetting CPU ...
> =

> In Linux 4.20 without my patch I regularly experience crashes like the
> one below. With the patch I never experience such a crash.

 For me this is 100% reproducible with the FreeBSD kernel, not the same
kind of crash but a hang as soon as we try to call PSCI/SMCCC functions.

 I don't care personnaly which patch is taken as long as it's applied.

 Cheers,

-- =

Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
