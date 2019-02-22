Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC88C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB33207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FpbGdZOX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3TmaqAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB33207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uYTjrI6yxNb1zjilsSz6dPG7d20/uewQby9GPh1+Gjg=; b=FpbGdZOXMS1/Hm
	g7NzbpnYTAqKzV7DNzzTkdcsaRttr20aiYEvaWTkMTskImdatmZ/DxighaGq7b0Q52skrwmLbBJED
	l3cMf+o3LlZqSCwPTUO8Z8l8HuD9eAHdCBQ2A1VpQQ4bQEmyL0VY6pigmVH/+JXde5gpL5zTUqQa5
	Q1fIa+XqN7CAq8yiWqEq6kcXWyTtk535kl4UGY/y4YR9GsmL2xmnjyfgyrCOpQSnPsK0nrJ8BoWoA
	nXMUEGr9vxpUZSBpyVc7EKpt7WJyUFjqjvh0NsifjtYJsP9hAjCQEkIDOA6CdQ5J/P6cLJUtsre0g
	HGIoI7K92GTjg7LgEJbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCZH-000607-23; Fri, 22 Feb 2019 15:16:51 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCZE-0005zl-10
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:16:50 +0000
Received: by mail-pf1-x443.google.com with SMTP id s22so1257602pfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vo6jhFpbADqF/a0Ruw2bj4J5FVM9bvOetl2FepVuCV8=;
 b=K3TmaqAD4pXvm/GlBWOLi3KMMA3nE1BcVO5H8tvU6WLblDnG6rU5iQDEcf+DenGjg/
 KPBbaD/8Ufw7zsYwK3LHwKAGate7bhzVZvAM7dVb73c7t3ViHwYtk3KN3MQyiWf5ViLB
 lI33EzlB7Lp1o/q9BZudcdhoCMMcz6pQLrSp0UbWMq9mtoyG4uorMiL9svUzcIa7nOv1
 0Fas/qtQlGh0mUU2vhqHgiAA27XlZvAAsaGOR2l8gAhc/gb0y8s+owi+uNNY2lwlKnnU
 lB71JS+fKzNQWR6j1I7kY9bqUJk3JJjdSa3qIcnN/ih8DdMdwDP1z1iLDZUjxcVJOh/1
 2liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vo6jhFpbADqF/a0Ruw2bj4J5FVM9bvOetl2FepVuCV8=;
 b=gw6mGp+ZV6OIdn437UH/WtbKZzyJj9sSiNFnQiUonMGFJpVTIIra2tv0340DcZJrqT
 +Ml8B4U1BsQt3fhQ6V1Ks8uInDrdjhgKYTnBEcxmCqylClP2aFaDlgsCKQ8rQwlQJo+T
 Xes+aKMvrBNv0iWcaQmvRjU6uEsKFvq6iWc0iu+QqrAC4HBi0IOF5FHe9U3h49DDZ8LD
 8w3iVswYZKLPlE4qzktcSeCbnvoSpVV+JRubJSlTI+JO8qzCiILxQnrYqmmPU4+uyxlZ
 A6caA5VNHMDSc2iNu/ELqZqv6JN1rBuLETxmZ24fwhgIzU/R79sKzvyssRaQ1fHqNbGv
 9/gg==
X-Gm-Message-State: AHQUAuay/kmnvTPb59g8xFbLdvt2rnkpIDfq97Vlu05fxDzGRkXoNw6R
 qXI5nmYCj5z78l6d8HFojRe5PF+PFs1qA9GXeFw=
X-Google-Smtp-Source: AHgI3IZeQgqWVtrcsfm2Tm2BWN3Prl48FQfg6UjzpDJVhVgiMrpi7spJkXwnpCmoaBF9grx4xygB0oWfMnVdUG2nFc0=
X-Received: by 2002:a63:d347:: with SMTP id u7mr4363863pgi.383.1550848607431; 
 Fri, 22 Feb 2019 07:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
 <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
 <572a6ce3-23f6-7b16-a070-4d4a81ee4335@redhat.com>
 <CAOLK0pzXnvk=FsfjH07jUyRJGpeiNG7-9vR9Vo0mLJtdPnt_7Q@mail.gmail.com>
 <d9043bc8-d006-bf64-2047-79a9b6f98183@redhat.com>
In-Reply-To: <d9043bc8-d006-bf64-2047-79a9b6f98183@redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Fri, 22 Feb 2019 23:16:35 +0800
Message-ID: <CAOLK0pyGhbd43rVPZE7waaStUkGVYVgakG2VgqtME4PxNTOY0w@mail.gmail.com>
Subject: Re: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct
 mmu_spte_page
To: Paolo Bonzini <pbonzini@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_071648_086401_723924B3 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
 catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@arm.com,
 paulus@ozlabs.org, "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au,
 the arch/x86 maintainers <x86@kernel.org>, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
 benh@kernel.crashing.org, jhogan@kernel.org, linux-mips@vger.kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 11:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 15/02/19 16:05, Tianyu Lan wrote:
> > Yes, you are right. Thanks to point out and will fix. The last_level
> > flag is to avoid adding middle page node(e.g, PGD, PMD)
> > into flush list. The address range will be duplicated if adding both
> > leaf, node and middle node into flush list.
>
> Hmm, that's not easy to track.  One kvm_mmu_page could include both leaf
> and non-leaf page (for example a huge page for 0 to 2 MB and a page
> table for 2 MB to 4 MB).
>
> Is this really needed?  First, your benchmarks so far have been done
> with sp->last_level always set to true.  Second, you would only
> encounter this optimization in kvm_mmu_commit_zap_page when zapping a 1
> GB region (which then would be invalidated twice, at both the PMD and
> PGD level) or bigger.
>
> Paolo

Hi Paolo:
             Sorry for later response and I tried to figure out a bug
lead by defining wrong
max flush count. I just sent out V3. I still put the last_level flag
patch in the end of patchset.
Detail please see the change log. Just like you said this was an
optimization and wasn't 100%
required. If you still have some concerns, you can ignore it and other
patches in this patchset
should be good. Thanks.

-- 
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
