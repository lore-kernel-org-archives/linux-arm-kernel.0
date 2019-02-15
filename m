Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3741821A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Suw0IbCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3741821A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3ZkbdmR7aZG9s+XxJSbaYJxOUDKgzDL6zTdX8+S3Al0=; b=Suw0IbCSR+/IYO
	5NAM2y4+cK8F47mOtfPyPiGklmYm/rjJGenZ28P484Q9GkrNDhuAzARqtkNRomGcA7AOixAcBFXRm
	pRIGeNAWxOl5zPnV/RFQIU8GoxCd1N4eq6aAs31JaM0q4RIvCEPYs6XsnWDoGBMIZGDGbXrg3Oxz1
	l8nZR+XlY3wRdnliIM69V8K75nK0WttjAgW7kfP3CSAUmyw3uTHC92eiPbPEfu+Wh+gM/DownPxei
	yhn1KAmuZfdlPUMO1ZNb+D8gmqhxYRtim2SZ4K9niy9oPzqgIWFar+1MKZlVRGTSa5b2S7g/F7KZC
	t5YGzjwmMRAp1AaOw8sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhoX-0006q0-AV; Fri, 15 Feb 2019 18:02:17 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhoR-0006oz-TW
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:02:13 +0000
Received: by mail-lf1-f66.google.com with SMTP id q12so7873806lfm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 10:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a6nB+8VN0gTdBNT8NeBAeCswRcmI7H1hb3v6s4di2ug=;
 b=gf/htONafEvx+heL5Xx7h/UKCJ/ZxXmv17C7VWfw8t4hZuAhpaJc8MwtbCs39n4Xtm
 zsAR74A0rPkIyu9vFWNtKpUPYEK6Elf0+F7KoOnfCKAedjfljaA4/KOQnsH6IRatLeXd
 tlmkv0O84Ibvhgloy5V8TJqBclXlArMOBM5uSpIb9YmxYT7Wg+FPYsT5xw97p5ecBNgp
 8O1J7Pkvsk5oXy1Ui031h3rG52S9tAanXlqnC14pYNOlYuD/09RRHYrdkB/tNDfCOYCt
 PUd4YEZVjCZGuu1BKgTSzWvQTZ3P+lHrhgYHM6vGrIiA+nYFPptxy9FRfv1go0h0NVXr
 OhDw==
X-Gm-Message-State: AHQUAuYPXw3gtdBary38+qDtAx0MVDkBAv68F1JHWJUdM1th6+cLpAES
 1voslAjAvcyLTZVXSQVAOSYR/JDZqCsUOUjIBBa6Bg==
X-Google-Smtp-Source: AHgI3Ib/GGJdvOrEwSssCLonQftK7k+huk2mVMHDYkjwhM9ZuB0u2lIt5OiUnCuRMJ2ajNpiEwvWU/GpLFKdCgfFB40=
X-Received: by 2002:ac2:4154:: with SMTP id c20mr6646225lfi.108.1550253729426; 
 Fri, 15 Feb 2019 10:02:09 -0800 (PST)
MIME-Version: 1.0
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
In-Reply-To: <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 15 Feb 2019 23:31:56 +0530
Message-ID: <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_100211_983789_2CB9DDBE 
X-CRM114-Status: GOOD (  37.02  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <Steve.Capper@arm.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 Will Deacon <will.deacon@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "anderson@redhat.com" <anderson@redhat.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi James,

On Fri, Feb 15, 2019 at 11:04 PM James Morse <james.morse@arm.com> wrote:
>
> Hi guys,
>
> (CC: +Steve, +Kristina) "What's the best way of letting user-space know the MMU
> config when 52-bit VA and pointer-auth may be in use?"
>
> On 13/02/2019 19:52, Kazuhito Hagio wrote:
> > On 2/13/2019 1:22 PM, James Morse wrote:
> >> On 13/02/2019 11:15, Dave Young wrote:
> >>> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
> >>>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
> >>>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
> >>>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
> >>>>> mentioned that the changes look necessary.
> >>>>>
> >>>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
> >>>>
> >>>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
> >>>>>>> calculated as is done by the underlying kernel
> >>
> >> Aha! Nothing to do with which-bits-are-pfn in the tables...
> >>
> >> You need to know if the top level PGD is 512bytes or bigger. As we use a
> >> kmem-cache the adjacent data could be some else's page tables.
> >>
> >> Is this really a problem though? You can't pull the user-space pgd pointers out
> >> of no-where, you must have walked some task_struct and struct_mm's to find them.
> >> In which case you would have the VMAs on hand to tell you if its in the mapped
> >> user range.
> >>
> >> It would be good to avoid putting something arch-specific in here if we can at
> >> all help it.
>
> >>>>>>> (see
> >>>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> >>>>>>>
> >>>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
> >>>>
> >>>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
> >>>> It is used for pgd_index() also in makedumpfile to walk page tables.
> >>>>
> >>>> /* to find an entry in a page-table-directory */
> >>>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> >>>
> >>> Since Dave mentioned crash tool does not need it, but crash should also
> >>> travel the pg tables.
> >
> > The crash utility is always invoked with vmlinux, so it can read the
> > vabits_user variable directly from vmcore, but makedumpfile can not.
>
> (This sounds fragile. That symbol's name may change, it may disappear
> completely! ... but I guess crash changes with every kernel release anyway)
>
>
> >>> If this is really necessary it would be good to describe what will
> >>> happen without the patch, eg. some user visible error from an actual test etc.
> >>
> >> Yes please, it would really help if there was a specific example we could discuss.
> >
> > With 52-bit user space and 48-bit kernel space configuration,
> > makedumpfile will not be able to convert a virtual kernel address
> > to a physical address, and fail to capture a dumpfile, because the
> > pgd_index() will return a wrong index.
>
> Got it, thanks!
> (all this user stuff had me thinking it was user-space you were trying to walk).
>
> Yes, this is because of commit e842dfb5a2d3 ("arm64: mm: Offset TTBR1 to allow
> 52-bit PTRS_PER_PGD"). The kernel has offset the ttbr1 value, if you try and
> walk it without knowing the offset you get junk.
>
> Ideally we tell you the offset with some 'ttbr1_offset=' in vmcoreinfo, but if
> the offsetting code disappears, the kernel would still have to provide
> 'ttbr1_offset=0' for user-space to keep working.
>
> I'd like to find something future-proof that always has an unambiguous meaning,
> and isn't a problem if the kernel variable/symbol/kconfig names change.
>
> With pointer-auth in use too you can't guess which bits are address and which
> bits are data.
>
> Taking arch-specific to its extreme, we could expose TCR_EL1, but this is a
> problem if we ever switch that per task (some new bits may turn up with a new
> feature). Some of those bits vary per cpu too, so we'd have to mask them out in
> case user-space tries to conclude something from them.
>
>
> My current best suggestion is to export:
> from core code:
> * USER_MMAP_END, the maximum value a user-space can try and mmap().
> This would normally be TASK_SIZE, but x86 and powerpc also have support for
> larger VA space, and its plumbed into mm slightly differently. We should have
> one arch-independent property that covers all these. On arm64 this would be the
> runtime va bits for user-space's TTBR. (This assumes the value isn't per-task)
>
> arch specific:
> * ARM64_TCR.T1SZ, the va bits mapped by the kernel's TTBR. (We can assume we'll
> never flip user/kernel space). This has to be arch specific, it will always have
> a value and its meaning comes from the ARM-ARM (so linux can't change it in the
> future). It should be the same on every CPU.
> * ARM64_TTBR1.BADDR, the pa of the kernel page tables, which implicitly has the
> offset. Again this always has a value, and its meaning comes from the ARM-ARM.
> If we ever get clever with different page-tables/TCR values on different CPUs,
> these two should come from the same CPU.
>
>
> I think this gives you what you need if user/kernel may both be using
> pointer-auth and both may be using 52-bit va. I'm pretty sure the 48:52 bits can
> be picked at boot time depending on the kernel kconfig and the hardware support.
>
> Does anyone have a better idea? (or a corner where this won't work?)

I am not sure you got a chance to look at the two regression cases I
reported here:
<http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>

Unfortunately the above suggestion doesn't provide any fix for
ARMv8.2-LPA regression (see text under heading '
(1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')

After going through the regression reports, I think exporting
'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' to vmcoreinfo is sufficient
for the above regressions (without over-complicating the stuff) as
ARM64_TCR.T1SZ and friends seem to arch specific as compared to
VA_BITS + 'MAX_USER_VA_BITS' .

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
