Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE44C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:04:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98CE2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="shoVoiZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98CE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bh6f7C0exUmGcbzJlb3MhWp2t7LVWo1d20jk8X9l8pI=; b=shoVoiZJCjGIXH
	R5K2nTQUfizKR68Pt/J/WSj0Ar66nBmo7TaYsxDnEH9zZvMHSMRyAVX5ROmeccqbgtu7UEIArvGv0
	xCrfnOHDjrZnC5WjYayWQLtwCmjK4gAP/9O/sQAiZgD8ROrO57nLk6GJVu2lk/JjrxAG3Rfa4oKa/
	ogLzjmQ1w6IEpupkvGZeuYTNLYs29A0fgHFBsuJxsUupj2fRm3wUknq29d2Yda+OGTKfzNQ2fXbmv
	d3MzybP91aw2JyNIdPgmTXpmHBDqoOzhdFBu3VwYkS6MohLtqGxJToJ8CGzWYVSkZeae5nZeaDuJZ
	27MuoBctct+rW/DmpDOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwte5-00081Y-F7; Thu, 21 Feb 2019 19:04:33 +0000
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwtdx-00080d-P0; Thu, 21 Feb 2019 19:04:27 +0000
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x1LJ4BpH032368
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 22 Feb 2019 04:04:11 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1LJ4B1M028703;
 Fri, 22 Feb 2019 04:04:11 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1LJ4AQ3027539; 
 Fri, 22 Feb 2019 04:04:10 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by
 mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2672039;
 Fri, 22 Feb 2019 04:02:59 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Fri,
 22 Feb 2019 04:02:58 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To: Dave Anderson <anderson@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Topic: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Thread-Index: AQHUuQb/BT+pA4VdFkyjzG4/innmbKXP0wNAgAzVznSAAC8oAIABSBsPgAAUpACAAmuuAIAAB78AgAb61tCAAlbQAIAABiWAgACai5A=
Date: Thu, 21 Feb 2019 19:02:58 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03568CA1@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
 <891eaf5a-aede-364d-6465-832e377c3e29@redhat.com>
 <1481013752.3226345.1550767349644.JavaMail.zimbra@redhat.com>
In-Reply-To: <1481013752.3226345.1550767349644.JavaMail.zimbra@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.132.89]
MIME-Version: 1.0
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_110426_037578_252BEE37 
X-CRM114-Status: GOOD (  25.37  )
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
 Steve Capper <Steve.Capper@arm.com>, catalin marinas <catalin.marinas@arm.com>,
 ard biesheuvel <ard.biesheuvel@linaro.org>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

-----Original Message-----
> ----- Original Message -----
> > Hi Kazu,
> >
> > On 02/20/2019 02:17 AM, Kazuhito Hagio wrote:
> > > Hi Bhupesh,
> > >
> > > -----Original Message-----
> > >> I am not sure you got a chance to look at the two regression cases I
> > >> reported here:
> > >> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
> > >>
> > >> Unfortunately the above suggestion doesn't provide any fix for
> > >> ARMv8.2-LPA regression (see text under heading '
> > >> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')
> > >
> > > As for MAX_PHYSMEM_BITS, I realized that ppc64 makedumpfile can detect
> > > it because there is only one SECTION_SIZE_BITS for ppc64. I think we
> > > can use the same way as set_ppc64_max_physmem_bits() does also for
> > > arm64 for now. I'm going to write it for kernels not having
> > > NUMBER(MAX_PHYSMEM_BITS) in vmcoreinfo.
> >
> > I see two drawbacks with the above approach:
> >
> > a). This means that other user-space tools like crash-utility would
> > still be broken and would probably need to find MAX_PHYSMEM_BITS for
> > arm64 via a similar (hack'ish ?) approach.
> >
> > b). I am looking at the makedumpfile code for 'MAX_PHYSMEM_BITS'
> > determination for two archs as an example:
> >
> > ppc
> > ---
> >
> > int
> > set_ppc64_max_physmem_bits(void)
> > {
> >          long array_len = ARRAY_LENGTH(mem_section);
> >          /*
> >           * The older ppc64 kernels uses _MAX_PHYSMEM_BITS as 42 and the
> >           * newer kernels 3.7 onwards uses 46 bits.
> >           */
> >
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
> >          if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
> >                  || (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
> >                  return TRUE;
> >
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_7;
> >          if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
> >                  || (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
> >                  return TRUE;
> >
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
> >          if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
> >                  || (array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT())))
> >                  return TRUE;
> >
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
> >          if ((array_len == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
> >                  || (array_len == (NR_MEM_SECTIONS() /  _SECTIONS_PER_ROOT())))
> >                  return TRUE;
> >
> >          return FALSE;
> > }
> >
> > x86_64:
> > ------
> >
> > int
> > get_versiondep_info_x86_64(void)
> > {
> >      /*
> >       * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
> >       */
> >      if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
> >      else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
> >      else if(check_5level_paging())
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
> >      else
> >          info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
> >
> >      ...
> > }
> >
> > Looking at the above, two questions come to my mind:
> >
> > - Do we really need all the above complexity in user-space code, to hoop
> > across various kernel versions and perform allocations for something
> > that can be so easily exported via vmcoreinfo? Also we need to see how
> > portable is the above code for a new kernel version - IMO, it will need
> > another fix patch when we update to a new kernel version in near future.
> 
> I agree -- not to mention that the "kernel version" way of determining things
> does not account for distribution-specific backports.
> 
> >
> > - Also do we need to replicate the above implementations across
> > user-space tools when they can also utilize the vmcoreinfo information
> > to determine the PA_BITS range without any additional arch/kernel
> > version specific details as the single point of obtaining this
> > information from the kernel?
> >
> > So, in view of the above, I would still advocate that we use a
> > vmcoreinfo export for 'MAX_PHYSMEM_BITS' as well to have a uniform
> > interface for the same across all user-land applications.
> 
> Again, totally agree.

I also agree that we should do so. Then it will be better to have
it in kernel core code, not in arch-specific code.

Although makedumpfile may have to have the kludge for kernels that
support 52-bit PA and don't have the exported MAX_PHYSMEM_BITS
sooner or later..

Thanks,
Kazu


> 
> Dave
> 
> 
> > Thanks,
> > Bhupesh
> >
> >
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
