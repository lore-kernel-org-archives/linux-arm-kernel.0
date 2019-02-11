Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F2021B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E2TpN49k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XQdei3AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F2021B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QtIwLkSvhlma2fLKuWhi7b7K++1SNy/3umy2lh0irU=; b=E2TpN49koRbxXg
	aqIGZ1roQvhSSochZO87Iew55Yjb1y1FN1crr9XsfB2Vdnv9a4O1hLZmfm/3EWMpti5V87oF0HI75
	dFXCLnb1FEtB8fp5TLw45AvltFSPPGtuyUK4Tbyj/W9xfRfZqMY/Sgi0PaqVTNsm45oQ9tjPhYSAT
	cYeNPzs8Uf9jGZQnLPosGiZEJu3b1p+Pff85zbAytLNTmjtPzoZHKSVu+yn/2KVtrDlpbJiI2tUwM
	fZSqo4PE0vZwpxvCVso6oUP8AxCU8if+qELHfH0YkSD6RsWnrBI20ZagtOrGzLrvLyLClc8gNSJEa
	s9hnbWoezxSzLRoTAEgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCfF-0008AS-1a; Mon, 11 Feb 2019 14:34:29 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCfB-0007kJ-1H
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:34:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ymMtoJ4VxEW4NYDpSBX7aJm35z9TuQ1LmHtTmwq0JLA=; b=XQdei3AVXz1be9mZF8M9HyMtD
 c7Ajp6SNqi/F5BVMIkFgsMVwXxFUug5DSFN/GQSpgPK9Qjybe8mo80hM3p8mW3q3JYMEdv1/fvKQH
 mhk6KZl5noS0Hr2UdqOTCuJorf1JTwPZIs82NmYk1nVT9LjP7ZfDZRKiX6UsHUA07edc0=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36702)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gtCKB-0006U2-Id; Mon, 11 Feb 2019 14:12:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gtCK9-0001EE-Iv; Mon, 11 Feb 2019 14:12:41 +0000
Date: Mon, 11 Feb 2019 14:12:41 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: Re: [PATCH] ARM: MCPM: Add provision for platform specific wfi
 alternative
Message-ID: <20190211141241.vcz64as6wqdhfrmb@shell.armlinux.org.uk>
References: <20190210231212.20470-1-stuart.menefy@mathembedded.com>
 <CAPoDyq6vzXuR+Z=t9eyJytuOGZknyY1nOY7v_ir86VTZM3DH5g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPoDyq6vzXuR+Z=t9eyJytuOGZknyY1nOY7v_ir86VTZM3DH5g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_063425_220610_65573B41 
X-CRM114-Status: GOOD (  16.00  )
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
Cc: linux-samsung-soc@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Nicolas Pitre <nico@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 01:53:14PM +0000, Stuart Menefy wrote:
> Folks
> 
> On Sun, 10 Feb 2019 at 23:12, Stuart Menefy
> <stuart.menefy@mathembedded.com> wrote:
> >
> > On some platforms (in particular the Exynos5260) the wfi is not
> > executed directly by the operating system but by trapping into the
> > secure monitor. This allows us to replicate the behaviour of the
> > vendor supplied kernel using the MCPM framework.
> >
> > Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> 
> I forgot to add, this is a part of a series of patches which updates
> the Exynos 5260
> support, allowing use of the kernel on secure parts and adding suspend
> functionality,
> Version 1 of the patches has been posted to the samsung-soc mailing list:
> https://www.spinics.net/lists/linux-samsung-soc/#65035
> and I'm just about to post version 2. However as this is the only patch which
> touches generic ARM files I though I'd better check the approach is acceptable
> to a wider audience.

Please don't limit patches to just the SoC specific mailing list - copy
linux-arm-kernel and linux-kernel as well.  Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
