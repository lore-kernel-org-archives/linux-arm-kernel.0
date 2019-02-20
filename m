Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A5520851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mHVZIpTx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y5OzlUMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A5520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SakPGvkusvMqAbYTGWK2UUg7rjU7NJEiqnVSx0t8EiU=; b=mHVZIpTxU1PXvi
	wtVjYyY+A7IUOeoQBaBOyrOVZw/nwuUlJdWMMI9LU3RwXWnM2r2lhjStR3s00inByvLECoTbVf+Mn
	ZJ61ypLg0eRKHnKuou9NWr/MeAaKI62ovbqyZ09poE9r+ot/CbG+HU+ulfODggutfFHyJhrdGDY35
	PJ4bXNYWUy0eK2Ek0FCXBIEcnrllKzpAdLAT8ooB2B7c6Ywpv90zkgYbKsVm8cB4nwWLvsrusV4fd
	VQygS6mmOuobAhrE0EsZVARDZOD8WnbgiR5MR10s5mDY2LDBiNW8XN+fHRvbHjJFllwNRLIcefkjg
	aBoGMrL3HKq7MIVeB7Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQAQ-0003Yv-Lx; Wed, 20 Feb 2019 11:35:58 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQAO-0003YL-2G
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:35:57 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KBT3WJ014886;
 Wed, 20 Feb 2019 11:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=izfia1KiuXgUV8A8PGApopJeIHuPLnpjxsKgv4nNIEQ=;
 b=y5OzlUMKcL34moZoGjuZxugW6eYBGvN01DyzDcz5j4fe9Jfu6dIOTZjOLnBLrwI1d644
 5zbUk+/GzwSLsv2Ig6Ss4cTsjkbKT2oEn0vYXMXn1NEsasImkzTz4NQ10Sb1+ICr4Jjy
 e2uLSU8r//T7/Qq7owqDFpkBPXwoy8n0SrhG/RG28/s46bkFbDvuF+SQCeko4u43KPrZ
 CC4T/41kdMMVjY2m+p1fVr2HqP1gFaiI1ocSBKqNfxh4H56BIWPwGKHvrMx2o0dZU/7D
 h0BCVGKp9wyn7kCyCrX+tPX/8BjDhaUetryDaI9180HNnI9H0S2emmpOxn4jquOcWEvV OQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
 by aserp2130.oracle.com with ESMTP id 2qp81e95a8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 11:35:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KBZESM026861
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 11:35:15 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KBZDKx017732;
 Wed, 20 Feb 2019 11:35:13 GMT
Received: from [192.168.0.110] (/73.243.10.6)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 20 Feb 2019 03:35:13 -0800
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH 06/13] mm: pagewalk: Add 'depth' parameter to pte_hole
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190215170235.23360-7-steven.price@arm.com>
Date: Wed, 20 Feb 2019 04:35:11 -0700
Message-Id: <52690905-1755-46BD-940B-1EE4CEA5F795@oracle.com>
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-7-steven.price@arm.com>
To: Steven Price <Steven.Price@arm.com>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_033556_193016_2BC27F08 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> On Feb 15, 2019, at 10:02 AM, Steven Price <Steven.Price@arm.com> wrote:
> 
> The pte_hole() callback is called at multiple levels of the page tables.
> Code dumping the kernel page tables needs to know what at what depth
> the missing entry is. Add this is an extra parameter to pte_hole().
> When the depth isn't know (e.g. processing a vma) then -1 is passed.
> 
> Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
> natural numbers as levels 2/3/4.

Nit: Could you add a comment noting this for anyone wondering how to
calculate the level numbers in the future?

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
