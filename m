Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B80C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:48:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD57E2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iG31v01J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpqAYoYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD57E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7xZ7NSQm9QEmhImCIccNAANkieiZkX09ww6aL1F049g=; b=iG31v01JY208w6
	QxPj8dtoxUNVmE9qKEdekDU9ZQKY4KgdkZs8ruQBvWPQTLiHOJRdPEn1QzwQeVtNV5R+JGszLhdKX
	XxwzDsZo2rJPZ7JKcou1sVUiQ8F4Lwo6W+jrgjMIiKjAe/hQVEKwJTM+2l6owecmMUQcxoxbezCiw
	dGITiF+wCCb/I22zd5pjb9kTV0lZrC2bTc+79jUwjOqLZFAOReJ0GEihHuLJd+QGhbvgyBZMuU4ba
	Rn4/vxvOBMWJ0kJ3Kn65DnCWUI8ENbQ3zhHUshk5VSkWk4QW+1ghhz/+GfT7i4aS6xZ5PWyrd+/uV
	Vr+iaIEzIDO7DJZh1kaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLiu-0007cE-Sd; Thu, 13 Dec 2018 07:47:56 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLir-0007b8-Pd
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 07:47:55 +0000
Received: by mail-pl1-x644.google.com with SMTP id u18so655168plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 23:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U1kdblOkJeUGCFzl5KLv1H49TEpdl9qC6nK7L+3L29c=;
 b=TpqAYoYwMe1TJDoCr58p8u4c15c86tjuJio3/1Um7s9VeQMthzh84tY1nz/a74ZQxf
 MyvzBmj+EE/ZiEYbonVNj+PmNsVClYy1b14oQJAv2onUlwDS55YdHkWpnj4dpPAnvacM
 o/AoSNObkNYx66T/5FmPq3PhYzTv4hcle+nY6WzqoRFufR5Eah8MI/wyE3vfwgwidnYf
 OKSIbP0njF4oFHHqh5W8kGbIRdfQMhgyR3i6XX0CnAjkRvqvu3mTZikVUMzlNpAYrrMg
 aJVyi0JQfUAh5R5hZ3KxSiXN+eBjSOAQYWJOnRjfQ0dH003JGBrhvSkxJau7Z3UuXV6h
 8IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U1kdblOkJeUGCFzl5KLv1H49TEpdl9qC6nK7L+3L29c=;
 b=HwIULVfOKpoVD0s7Yn2dASw9VpW6u1TyRhZl3rGdzPjjECyd+jx0ehFA/NPDy+j4S/
 0Hy0DjXaKk8vLvzU1WzYu58TPfaJG0sUM5+Im+zBt97nbTxUgveCeKmaFVKFR+6F1a0B
 1/U9+nWZ36nXcqWz8Xstnp0o9V0gYgl+fRQ7FCYR5l0gAJoxLzNctnTd16yWI5QkZCK9
 kKXJdT/H4Ry+LPE/cdr1ag2VNsGF5beyghsPbJxWhrzpABx6djtZxibaoLIIX/p6pDZP
 LX9amOiy/BmurW0fzCEx7O9RRfKij7edUrP3SBWBH1+s0jAn640cwW4AW0JTkIgWaMrY
 lv5Q==
X-Gm-Message-State: AA+aEWZWrjPEgtvgMeOt23FRo+6u1EDr0FctaL6QgGkeF4y48t8+PIiu
 zhq/T6J4b0XMf5ZO1I7nvpIcdJRUUy6tjzVVwMwmFg==
X-Google-Smtp-Source: AFSGD/XaHQurPfiJZl0nifD8SVpllsWxHwP1gQEAMsEgMubG9uFN1wv4BtJUNE8J6a9nm+2+ylSuJ8ODlQsaQfiABOY=
X-Received: by 2002:a17:902:d806:: with SMTP id
 a6mr21675813plz.172.1544687262841; 
 Wed, 12 Dec 2018 23:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
 <20181206132113.2691-8-Tianyu.Lan@microsoft.com>
 <20181212050353.GF22265@blackberry>
In-Reply-To: <20181212050353.GF22265@blackberry>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Thu, 13 Dec 2018 15:47:31 +0800
Message-ID: <CAOLK0pyKsS2hLagZ6pumMdfRokPig2P+KJambVOq7p+NU-OqgA@mail.gmail.com>
Subject: Re: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
To: paulus@ozlabs.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_234753_835878_665BD696 
X-CRM114-Status: GOOD (  12.50  )
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
Cc: linux-mips@linux-mips.org, kvm <kvm@vger.kernel.org>,
 Radim Krcmar <rkrcmar@redhat.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, christoffer.dall@arm.com,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, mpe@ellerman.id.au,
 the arch/x86 maintainers <x86@kernel.org>, linux@armlinux.org.uk,
 michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
 benh@kernel.crashing.org, jhogan@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 kvm-ppc@vger.kernel.org, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 ralf@linux-mips.org, paul.burton@mips.com, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Paul:
             Thanks for your review.
On Wed, Dec 12, 2018 at 1:03 PM Paul Mackerras <paulus@ozlabs.org> wrote:
>
> On Thu, Dec 06, 2018 at 09:21:10PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > The patch is to make kvm_set_spte_hva() return int and caller can
> > check return value to determine flush tlb or not.
>
> It would be helpful if the patch description told the reader which
> return value(s) mean that the caller should flush the tlb.  I would
> guess that non-zero means to do the flush, but you should make that
> explicit.

OK. Thanks for suggestion and will update in the next version.

>
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> For the powerpc bits:
>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>



-- 
Best regards
Tianyu Lan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
