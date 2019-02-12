Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F343AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD4F222C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eswIPm8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD4F222C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1dQS6kYvALIyCDuty8IygeiTrWS7RKy+cNm3YuHqnD8=; b=eswIPm8u6Wduz2
	oNGTH9JlzuQlO1GgMha/bu8qawg74nLUkXypFWA6PLFGtiv478r2rJckiWJXtjEOURd4yHenNZ94M
	eGJ0Rzyja8lVzJQPtDkw5C7LrOWjymujPRycqnUEFq9qU0LNaPnhIEBPfXf+1rK9I6cmQpCtMrwYO
	YXYCCcyDvwQluuvxPI7qncYEyjR0ujhzBXQomjFfyjuMSD6354L5esl0RILc+D+wCXg22O+jMGqdX
	g9W7/ICwoIOYxlHcp238A9qto6Pt+pHLAlKDTx9tYmst8qTdjrxo78JRslHPkjm2JsLwUuthxw92x
	K8abnMOIW7eMRUOHYTWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gth77-0003qX-Nf; Tue, 12 Feb 2019 23:05:17 +0000
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gth74-0003k4-7R; Tue, 12 Feb 2019 23:05:16 +0000
Received: from mailgate01.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x1CN4rMO001098
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 Feb 2019 08:04:53 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1CN4rYH004424;
 Wed, 13 Feb 2019 08:04:53 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1CN47JL023191;
 Wed, 13 Feb 2019 08:04:53 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by
 mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2334655;
 Wed, 13 Feb 2019 08:03:14 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Wed,
 13 Feb 2019 08:03:13 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To: Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Topic: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Index: AQHUuQb/BT+pA4VdFkyjzG4/innmbKXP0wNAgAzVznSAAC8oAA==
Date: Tue, 12 Feb 2019 23:03:13 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
In-Reply-To: <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.73]
MIME-Version: 1.0
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_150514_496608_BB620DDA 
X-CRM114-Status: GOOD (  11.68  )
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
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 "anderson@redhat.com" <anderson@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
> mentioned that the changes look necessary.
> 
> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html

> > > The increased 'PTRS_PER_PGD' value for such cases needs to be then
> > > calculated as is done by the underlying kernel (see
> > > 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> > >
> > > #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))

Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
It is used for pgd_index() also in makedumpfile to walk page tables.

/* to find an entry in a page-table-directory */
#define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))

Thanks,
Kazu

> > >
> > > Also, note that 'arch/arm64/include/asm/memory.h' defines 'MAX_USER_VA_BITS'
> > > as 'VA_BITS' in case 'CONFIG_ARM64_USER_VA_BITS_52' is set to 'n':
> > >
> > > #ifdef CONFIG_ARM64_USER_VA_BITS_52
> > > #define MAX_USER_VA_BITS      52
> > > #else
> > > #define MAX_USER_VA_BITS      VA_BITS
> > > #endif
> > >
> > > So, makedumpfile will need this symbol exported in vmcore to make the above
> > > determination.
> > >
> > > [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
> > >
> > > Thanks,
> > > Bhupesh
> >
> > Thanks
> > Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
