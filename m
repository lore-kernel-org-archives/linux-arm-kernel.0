Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E87C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:07:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A634720675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiEoeqmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A634720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Vp3f1E+mKaODxOz514RlvCPQuX7foqpTvxop7LYmdc=; b=FiEoeqmGfMVxWV
	ouF2okE9RLA+gAP7r3GrdgXYzqy7AkNovDsnc5gjjECxWHWclXQ1vcPRt7OcsP9/9+DovcJK6AV/5
	qiIGO2ugv0DhtJQk/ee9RYX6qL1OYa22uiDNFv02f0UkUJAG3dW4nNHxjLKxPkhTkQn3Z/yHsDcGS
	1RNGBgEX/VBl2Orxq6oJ5o79J6whtkE0A5OB3pD5C1wy/pTuHbdY0P5MVZ+1PU7oJdJgt0orfZ7UY
	KQVFRlQcUEpvB09p3JLmVoUGN8Hq5IlD5uqNzuQNUJQxXDP2xIhYysQkRaUjpM0I0Cbu3h9PsYN0s
	4x/uY12DxXM9RK0Uqktg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX1L-0000zE-Pg; Sat, 23 Feb 2019 13:07:11 +0000
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX19-0000qY-6r
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:07:09 +0000
Received: from yto-m4.gw.nic.fujitsu.com (unknown [192.168.229.97]) by
 mgwym01.jp.fujitsu.com with smtp
 id 34c3_ec67_65acab05_ef48_4f44_aa0c_7120c8baeacf;
 Sat, 23 Feb 2019 22:06:49 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 325DC40E9D24
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 22:06:48 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id CCE723283A0;
 Sat, 23 Feb 2019 22:06:46 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Sat, 23 Feb 2019
 22:06:46 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Topic: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Index: AdTENhuVebuKtHOoRzCPb6sZ5vznO///+H8AgAAo/wD//jk2sP/v2FHA
Date: Sat, 23 Feb 2019 13:06:45 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A319D26@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A311EAE@G01JPEXMBKW03>
 <20190214155605.GC27547@lakrids.cambridge.arm.com>
 <90347cf4-4d7b-d553-d4db-1bacd000ff75@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A313313@G01JPEXMBKW03>
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
X-CRM114-CacheID: sfid-20190223_050659_677241_1570EB7D 
X-CRM114-Status: GOOD (  17.54  )
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
Cc: 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Will Deacon' <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Zhang, Lei
> Sent: Friday, February 15, 2019 9:36 PM
> To: 'James Morse' <james.morse@arm.com>; Mark Rutland
> <mark.rutland@arm.com>
> Cc: 'Catalin Marinas' <catalin.marinas@arm.com>; 'Will Deacon'
> <will.deacon@arm.com>; 'linux-kernel@vger.kernel.org'
> <linux-kernel@vger.kernel.org>; 'linux-arm-kernel@lists.infradead.org'
> <linux-arm-kernel@lists.infradead.org>
> Subject: RE: [PATCH v4] arm64: Add workaround for Fujitsu A64FX erratum
> 010001
> 
> 
> I think you mean it may be a problem to modify the KPTI trampoline because
> some patches about KPTI will be merged to mainline in the near future.
> I understood that.
> I should discuss with my colleagues whether we can set NFDx=0 all of time on
> A64FX.

The result of our investigation also supports your suggestion. 
We surely agree with you that your proposed method (never set NFDx=1 on A64FX)
is the best to resolve this erratum.
	
For this erratum, James's patch should be merged to mainline
instead of my previous patches (v1 to v4).
Since KPTI fully covers the effect of NFD1 for A64FX, KPTI is
recommended to be used in conjunction with James’s patch.

> And thanks for your patch.
> If we can set NFDx=0 all of time, I will review, test and report the result.

I have already tested James's patch on A64FX, and the result is no problem at all.

Tested-by:zhang.lei<zhang.lei@jp.fujitsu.com>


> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig index
> a4168d366127..b0b7f1c4e816 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -643,6 +643,25 @@ config QCOM_FALKOR_ERRATUM_E1041
> 
>  	  If unsure, say Y.
> 
> +config FUJITSU_ERRATUM_010001
> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
> +	default y
> +	help
> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
> +	  On some variants of the Fujitsu-A64FX cores version (1.0, 1.1), memory
> +	  accesses may cause undefined fault (Data abort, DFSC=0b111111).
> +	  This fault occurs under a specific hardware condition when a
> +	  load/store instruction performs an address translation using:
> +	  case-1  TTBR0_EL1 with TCR_EL1.NFD0 == 1.
> +	  case-2  TTBR0_EL2 with TCR_EL2.NFD0 == 1.
> +	  case-3  TTBR1_EL1 with TCR_EL1.NFD1 == 1.
> +	  case-4  TTBR1_EL2 with TCR_EL2.NFD1 == 1.
> +
> +	  The workaround is to ensure these bits are clear in TCR_ELx.
> +	  The workaround only affect the Fujitsu-A64FX.

I think it is better to add a notice here as follows:

  Recommend to enable KPTI (UNMAP_KERNEL_AT_EL0 = y).

> +
> +	  If unsure, say Y.
> +
>  endmenu

Thanks a lot.

Best Regards,
Zhang Lei 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
