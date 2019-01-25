Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4ACC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:51:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D327218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h71It76Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D327218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lM5vW0znka9VdxF4+8EXusCmjeI5KbfxcXRcCMbsdoA=; b=h71It76YZWqUAS
	eqhT5UtFw2Lq/ksCYs/yn9VINwlxyGWMffZeuxgo+EaMz2YFyiSk2M7xvrNS8JnNueUyotMUOWRS/
	x4EWd4RVCdUMERyNdWszFuNR5kOMeereIAnTC/huY/QZLm4LlVYUz+ntfF1oWTMAvNjCKDnmlO0bG
	QmtimedW6co/sPc47pDJ4DizKcKYd2umENZGhseNFOVtqvXnKQ9PGYSq9nF4TWNXWU9RtXv730KUA
	L91Z5RTkbCkPLeeaVr+d7kl9Tpxd3z3xbCSjVlHW3w7S2kkKfk/12d54r3HJ+LNwSq76piTHB7bxS
	VgR/F5ft9POciIZWT1BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvKo-0000Vn-9z; Fri, 25 Jan 2019 06:51:26 +0000
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvKk-0000UX-Oo
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 06:51:24 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by
 mgwkm02.jp.fujitsu.com with smtp
 id 6e5d_80ce_a4577ed7_c7dc_422e_a722_dcd292b193ef;
 Fri, 25 Jan 2019 15:51:11 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CBD1AC00B9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 15:51:11 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id D60AEBD6795;
 Fri, 25 Jan 2019 15:51:09 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Fri, 25 Jan 2019
 15:51:09 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>, 'Mark Rutland'
 <mark.rutland@arm.com>, "'james.morse@arm.com'" <james.morse@arm.com>
Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Topic: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Index: AdSvK6W0/Nm6810RQFa/OOuw1JbhXP//gw+A//n57fCADGG/gP/+BGiA//lIR1A=
Date: Fri, 25 Jan 2019 06:51:08 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A6045@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
 <20190122152339.GD52887@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A3BED@G01JPEXMBKW03>
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A3BED@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_225123_054891_0C0E4FC1 
X-CRM114-Status: UNSURE (   6.26  )
X-CRM114-Notice: Please train this message.
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
Cc: "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Mark, James

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> Zhang, Lei
> Sent: Wednesday, January 23, 2019 9:51 PM
> To: 'Mark Rutland'; 'james.morse@arm.com'
> Cc: 'catalin.marinas@arm.com'; 'will.deacon@arm.com';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'; Zhang, Lei/張 雷
> Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
> Fujitsu-A64FX
> 
> At first thanks for your comments.
> I thinks James's comments is quite similar with above comment.
> I am reviewing this point now.
> I will respond to your questions after I check this.
As your comments, this patch cannot avoid this problem
completely. So I will post a new patch to resolve this 
problem in different way.

Lei Zhang
zhang.lei@jp.fujitsu.com



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
