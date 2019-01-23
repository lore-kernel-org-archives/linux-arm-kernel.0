Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A480C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:51:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A50721726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="autQAD5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A50721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j7lAr9o33fWs8hx1C0ltfmsGwqfQhzTyTPKfoySVQVo=; b=autQAD5tgSW3FM
	ZR1HD8SSUPg5GDHgv+ch8QTLfohK7IFnf2JT1BhvCgfeN1EBBX9u3AbwKrcyucYtVzPW5Iqtoh9ja
	tLmYx/Hym0maMkPcTaWOnUkpkGgkPA+c+c8h5uLeuiaUeZJpdXFEX39gHmTGYyfAqfuOJhELJroCv
	8j8sn9r/7MVzuY8jgtFuPYFdTMsu9XTvO5giIgfHW1hLwRKPu1nTrsjqWLrXouEyzil4PHw6UTteR
	NolCW9VapzJuF5mbl3H4oV20ekspWQ046iJpvY8UTDiUcQdy6fA2G4ZqSxcNR0MARDzWWJZB9mjHz
	zJJOKjUrM8Bocis2kOPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmI06-0002X0-O8; Wed, 23 Jan 2019 12:51:26 +0000
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmI02-0002W7-QK
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 12:51:24 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by
 mgwkm04.jp.fujitsu.com with smtp
 id 3bb5_12d9_ad77d546_ac5f_48b3_9e12_9f2505fb50cd;
 Wed, 23 Jan 2019 21:51:12 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local
 (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 890B8AC011B
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 21:51:11 +0900 (JST)
Received: from G01JPEXCHKW17.g01.fujitsu.local
 (G01JPEXCHKW17.g01.fujitsu.local [10.0.194.56])
 by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id 58EC2328726;
 Wed, 23 Jan 2019 21:51:10 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw17 ([10.0.194.56]) with mapi id 14.03.0415.000; Wed, 23 Jan 2019
 21:51:10 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Mark Rutland' <mark.rutland@arm.com>, "'james.morse@arm.com'"
 <james.morse@arm.com>
Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Topic: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Index: AdSvK6W0/Nm6810RQFa/OOuw1JbhXP//gw+A//n57fCADGG/gP/+BGiA
Date: Wed, 23 Jan 2019 12:51:08 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A3BED@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
 <20190122152339.GD52887@lakrids.cambridge.arm.com>
In-Reply-To: <20190122152339.GD52887@lakrids.cambridge.arm.com>
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
X-CRM114-CacheID: sfid-20190123_045123_083738_F5364CF7 
X-CRM114-Status: UNSURE (   6.28  )
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
 <linux-arm-kernel@lists.infradead.org>, "Zhang,
 Lei" <zhang.lei@jp.fujitsu.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Mark, James
> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Wednesday, January 23, 2019 12:24 AM
> To: Zhang, Lei/張 雷
> Cc: 'catalin.marinas@arm.com'; 'will.deacon@arm.com';
> 'linux-arm-kernel@lists.infradead.org';
> 'linux-kernel@vger.kernel.org'
> Subject: Re: [PATCH] arm64 memory accesses may cause undefined fault on
> Fujitsu-A64FX
> 
 
> As above, I'm very concerned that this could be taken from kernel
> context. There are a number of cases where we cannot handle such faults:
At first thanks for your comments. 
I thinks James's comments is quite similar with above comment.
I am reviewing this point now.
I will respond to your questions after I check this.

Thanks
Lei Zhang



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
