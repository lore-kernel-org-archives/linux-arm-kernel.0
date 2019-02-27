Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63995C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:18:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E0E20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dzTnzk5Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k5of6qjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E0E20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=XHGfFAv1eY0lCD38NAM4OkxTa+Blp6XAqELqVyYryT0=; b=dzTnzk5ZiQUYhT
	dbM1iDPPJrINXGmBTcnqJBk+maFnG7qA1znhSdaEeHPrJTfi5Y1grKCWx5uaHHLbnk9am8jYWMFyn
	VMxHh+8e2Cu4VUBeTVPczWJdlXrTydsHY3Fwt/YIlO0NbR5UMqMwwwO15ZyFvffUKWs3rjhL6ZIUz
	UBXEtYcgyLDoJa2Qvwb6cg9PcHQXERnJb8DenoTyPCuY4dXgt42ljktqUWt5gj9hhvRkgTkaOqTX2
	zWrUJNrpCvwVmVGgTwngSHs54qWYab/HEbovWhO5poFd2CAQWdvRN2JF+zBYucwEvzAeh+MwfjR+O
	5OlnzIdNQkHK0BC0qghg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3mt-0000T0-Ds; Wed, 27 Feb 2019 18:18:35 +0000
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]
 helo=smtprelay.synopsys.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3mq-0000SH-FH; Wed, 27 Feb 2019 18:18:33 +0000
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com
 [10.13.135.209])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id 6D16C24E0DA5;
 Wed, 27 Feb 2019 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1551291508; bh=3Izw665ZZgQEjbSE8CmRnZ9pKkiBA01cgGaMPRuksQg=;
 h=From:To:CC:Subject:Date:References:From;
 b=k5of6qjcnGOCE4OtuX4syNNcfm+iwtEFk9QAcd4ySNtJfthcWh+Wg3RlWca/WsOVP
 k8xz8fO/Cn1BTWUZ2Y2ASE7uzAVVal9+kgVtXEAlDPDMt5QGPlSnTXIR/xwWrCd0ki
 yH01k1BOznXaY9OjjzjQRn08rSX/zVgw4teD4hvhPGtKB14TtyzovQRYsVyqCiPtmK
 qsPJQbl5Wa3VJPR54SAiYzTk24F+ZPq+rYneCxVtXioAhpr5mHmVT5dbQXIDGYPk5B
 yZQ2hBH8zd3O73ODMl9wSVGh1X6et1XThvERgZXkw0RnT37ftIXJohr4GhSVZci0aA
 uODcwlEL/C2NA==
Received: from US01WXQAHTC1.internal.synopsys.com
 (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id BA747A005D;
 Wed, 27 Feb 2019 18:18:24 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id
 14.03.0415.000; Wed, 27 Feb 2019 10:18:04 -0800
From: Vineet Gupta <vineet.gupta1@synopsys.com>
To: Steven Price <steven.price@arm.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
Subject: Re: [PATCH v3 02/34] arc: mm: Add p?d_large() definitions
Thread-Topic: [PATCH v3 02/34] arc: mm: Add p?d_large() definitions
Thread-Index: AQHUzr7PbHQ5S+UVlUyl9IbMWKnRrQ==
Date: Wed, 27 Feb 2019 18:18:03 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146437D4C@US01WEMBX2.internal.synopsys.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-3-steven.price@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_101832_520241_43C606E3 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "x86@kernel.org" <x86@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Vineet Gupta <vineet.gupta1@synopsys.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/27/19 9:06 AM, Steven Price wrote:
> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information will be provided by the
> p?d_large() functions/macros.
>
> For arc, we only have two levels, so only pmd_large() is needed.
>
> CC: Vineet Gupta <vgupta@synopsys.com>
> CC: linux-snps-arc@lists.infradead.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
