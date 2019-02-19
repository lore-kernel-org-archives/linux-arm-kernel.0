Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766CFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:48:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344DA21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ia1gN0OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344DA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LxzdAsKc1flHHOC0Cv5cTBXm32eyYGN0sxn/2u/vx8g=; b=Ia1gN0OKWdzTCe
	k6igGKXxvZDU7b1A4rXbDjCGAKDq6tNAGiqZoZHSdegVVA6Wa2ciMZYAUTqVP4Yltq3mijMAMOJpq
	Q9/H/zprV0fa39HfQj9wW0IuGCStjZExguZdlDZ6q0pfQBhN/p4zcxy1XMYoxKUEiy0JmoRoLkzcL
	K6l0NHMMNT0x4k5O1yeVCwxapv0+bACWxqytFY/LtK/0uxp35RaUc8rph1K46tBPzvzl+TOxaY+bW
	8988Ap2jW84kmKkEK06+s5blwjBfTJA3hD0t8dVPuoNjahTxB3ZsCTbWmAMah6BYgpj0eumtm070P
	Q6ER8NW/bfXT1QICJdvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwCJu-0002gd-UH; Tue, 19 Feb 2019 20:48:50 +0000
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwCJl-0002fb-I4; Tue, 19 Feb 2019 20:48:43 +0000
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x1JKmLWj005810
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 20 Feb 2019 05:48:21 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1JKmLUJ030082;
 Wed, 20 Feb 2019 05:48:21 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1JKmLBq003773; 
 Wed, 20 Feb 2019 05:48:21 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by
 mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2582941;
 Wed, 20 Feb 2019 05:47:18 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Wed,
 20 Feb 2019 05:47:17 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To: Bhupesh Sharma <bhsharma@redhat.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Topic: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Index: AQHUuQb/BT+pA4VdFkyjzG4/innmbKXP0wNAgAzVznSAAC8oAIABSBsPgAAUpACAAmuuAIAAB78AgAb61tA=
Date: Tue, 19 Feb 2019 20:47:17 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
In-Reply-To: <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.134.2]
MIME-Version: 1.0
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_124841_822424_C6CA121B 
X-CRM114-Status: GOOD (  10.19  )
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
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <Steve.Capper@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>,
 Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bhupesh,

-----Original Message-----
> I am not sure you got a chance to look at the two regression cases I
> reported here:
> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
> 
> Unfortunately the above suggestion doesn't provide any fix for
> ARMv8.2-LPA regression (see text under heading '
> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')

As for MAX_PHYSMEM_BITS, I realized that ppc64 makedumpfile can detect
it because there is only one SECTION_SIZE_BITS for ppc64. I think we
can use the same way as set_ppc64_max_physmem_bits() does also for
arm64 for now. I'm going to write it for kernels not having
NUMBER(MAX_PHYSMEM_BITS) in vmcoreinfo.

Thanks,
Kazu

> 
> After going through the regression reports, I think exporting
> 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is sufficient
> for the above regressions (without over-complicating the stuff) as
> ARM64_TCR.T1SZ and friends seem to arch specific as compared to
> VA_BITS + 'MAX_USER_VA_BITS' .
> 
> Thanks,
> Bhupesh
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
