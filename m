Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80592C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:20:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45852218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fXpQEbAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45852218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=amDaAAOl7XT7RDbUeKQP0V7F4QXH3d3mY6ANNujkSac=; b=fXpQEbAJjb2J3M
	LYsFfxNjHgnLMeoDEE6QPxWIzmqFdZOQo0wa5qT2zd4LE2NqwBHR/D3PUTDl4RTT4N3hevYeanwAb
	Xxg4yMgUNlWFMWPd2cwlfCQc0LrEcz9Oc302i1yds6gIprSo+ogKokILynNxdlpPe/1E0T1r0g7NB
	N7VrC6JlxC2/o6UTraTO8S8cQoVO6cnAg71ZK9uexawmYCZalPk9dmfqrBwp4USckzcW4mtPYI2tM
	X+99h4FlWXPMW9Rz1cGlcMzb+BKzTSt9bxG10JEkRsfBvM4p5S2MXp0fbYXHMpDT+k87j7sPTRR67
	rO/QTZN+/4UgPJ4H8f1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gysZo-0004RE-BQ; Wed, 27 Feb 2019 06:20:20 +0000
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gysZk-0004QV-SF
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 06:20:18 +0000
Received: from yto-m4.gw.nic.fujitsu.com (unknown [192.168.229.97]) by
 mgwym02.jp.fujitsu.com with smtp
 id 4a63_d201_feccf6ff_fea9_43f6_915f_439f4fedfc30;
 Wed, 27 Feb 2019 15:20:08 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 96F0940A9BC2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 15:20:06 +0900 (JST)
Received: from G01JPEXCHKW16.g01.fujitsu.local
 (G01JPEXCHKW16.g01.fujitsu.local [10.0.194.55])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 077F2BD66DF;
 Wed, 27 Feb 2019 15:20:05 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw16 ([10.0.194.55]) with mapi id 14.03.0415.000; Wed, 27 Feb 2019
 15:20:05 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'James Morse' <james.morse@arm.com>
Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Topic: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Index: AdTENhuVebuKtHOoRzCPb6sZ5vznO///+H8AgAAo/wD//jk2sP/v2FHAgCMpHID//QDzQA==
Date: Wed, 27 Feb 2019 06:20:04 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A3336C8@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
 <d391d125-86a9-82e3-5add-10a15e578dd7@arm.com>
In-Reply-To: <d391d125-86a9-82e3-5add-10a15e578dd7@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_222017_156446_B97744BD 
X-CRM114-Status: GOOD (  23.87  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Will Deacon' <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of James Morse
> Sent: Tuesday, February 26, 2019 2:29 AM
> To: Zhang, Lei/張 雷 <zhang.lei@jp.fujitsu.com>
> Cc: Mark Rutland <mark.rutland@arm.com>; 'Catalin Marinas'
> <catalin.marinas@arm.com>; 'Will Deacon' <will.deacon@arm.com>;
> 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>;
> 'linux-arm-kernel@lists.infradead.org' <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
> 010001
> 
> Hi Zhang,
> 
> On 23/02/2019 13:06, Zhang, Lei wrote:
> > Zhang, Lei wrote:
> >> I think you mean it may be a problem to modify the KPTI trampoline
> >> because some patches about KPTI will be merged to mainline in the near
> future.
> >> I understood that.
> >> I should discuss with my colleagues whether we can set NFDx=0 all of
> >> time on A64FX.
> >
> > The result of our investigation also supports your suggestion.
> > We surely agree with you that your proposed method (never set NFDx=1
> > on A64FX) is the best to resolve this erratum.
> >
> > For this erratum, James's patch should be merged to mainline instead
> > of my previous patches (v1 to v4).
> > Since KPTI fully covers the effect of NFD1 for A64FX, KPTI is
> > recommended to be used in conjunction with James’s patch.
> 
> >> And thanks for your patch.
> >> If we can set NFDx=0 all of time, I will review, test and report the result.
> >
> > I have already tested James's patch on A64FX, and the result is no problem at
> all.
> >
> > Tested-by:zhang.lei<zhang.lei@jp.fujitsu.com>
> 
> Thanks, I'll post it properly with this tag.
[>] 
I saw v5 patch you posted. Thanks a lot.

> 
> 
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> >> a4168d366127..b0b7f1c4e816 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041
> >>
> >>  	  If unsure, say Y.
> >>
> >> +config FUJITSU_ERRATUM_010001
> >> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur
> wrongly"
> >> +	default y
> >> +	help
> >> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
> >> +	  On some variants of the Fujitsu-A64FX cores version (1.0, 1.1),
> memory
> >> +	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
> >> +	  This fault occurs under a specific hardware condition when a
> >> +	  load/store instruction performs an address translation using:
> >> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
> >> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
> >> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
> >> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
> >> +
> >> +	  The workaround is to ensure these bits are clear in TCR_ELx.
> >> +	  The workaround only affect the Fujitsu-A64FX.
> >
> > I think it is better to add a notice here as follows:
> >
> >   Recommend to enable KPTI (UNMAP_KERNEL_AT_EL0 = y).
> 
> That unmap option is on by default, you can't turn it off without
> CONFIG_EXPERT. While I agree, I don't think we need to spell this out.
[>] 
I agree with you (that there is no need to mention here). 
Thank you for your suggestion.
 
Best Regards,
Zhang Lei


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
