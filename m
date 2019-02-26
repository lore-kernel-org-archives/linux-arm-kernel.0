Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:39:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1493C2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n9H4xcyO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qrniw8KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1493C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3OnMEmrp/r9NA9N724VPFSm/yc2QoXBzDSDYpojqiwQ=; b=n9H4xcyORmtIY0
	h8lw6Ex+xYyj2fajRguS6IFg/NvDThUHVdKtBOZJw3AdJZDaP7HRFYm2nbA2GdYj3gasfr8QYPiLo
	rPA/IAM2vtqbmETYc2+zsCNhAqezdq5bbC9FgXGw4kCBxQZKQ5A8NIqPQUfF5fhM9UOUGr2+9+tgI
	tZBXwK/SiqUCdQytol+ZwJIIoh3wzMBm458cPTNoO320bpAuR3nzPrC8ISNbD/zN5mTI9d/3WTb+u
	5GOJfrmBRCf3p076ZvGgH1d1eevReceokJHx2v4yoKaXELiZPc5sZSOGXExAWL6VAylCULQNDaETR
	89aZ8uKQ22jhlI7oOsRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydtD-0008CA-0n; Tue, 26 Feb 2019 14:39:23 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydt9-0008Bi-P0
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:39:21 +0000
Received: by mail-pg1-x544.google.com with SMTP id m2so6314995pgl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dfiBLpo8ppzHN31Df3pK9Pue7IUmmemEwHEq/+qIHW8=;
 b=qrniw8KQBsnVcBdkLwXYTHP1tzALWjLL3wqY47zLDB86u7VpyXqsBCFNMPUvx2rcQ5
 tleEIn43VcQEIxdaz5Lq3qoXKxfo59ovHYPtXDa7JwcKInE8AMfYDGNxNizwMWMWQjde
 EhSO6jW2VXILtMDY8JQSd+bipZZVCQ+CR0EOZ2zJgqQHGK2gbFfefcVUCOF/9F/FdN4j
 khe0Gzu8tDmq3gffWUNVCHAG7gYifd/AMvfrRv8bNWrE6v7GDGV6bjcxEvsAriDj0zwX
 9ukzSjG/hOjO6EfG3Aixqm8fiGMNQyIAiftpSDpkdyIWPy343s9BUOUiQ9YAblVGHraC
 nJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dfiBLpo8ppzHN31Df3pK9Pue7IUmmemEwHEq/+qIHW8=;
 b=SIuseA6MAkN98sFwiXUwGZKKmXWC4Dc70bGjOixn9Qjy+2at0Il0S/l0ekL0I1QK7H
 Y/rHs1tW43XGQJmr6+ZpdWjqwVySPGih3obe3o/LMnSz7okB+/0MCSToQrclGGekwvba
 2GFgJIPDpfcec3NbO7Vsz62BEFfxJTtJFJN9yl1IwXI0rZDxJYN4YVjTN/h+ukN41db6
 GBSHi3le+svqnTy4x/eQAukrfT2ds3G7lFXpoRlcnN3Qcu9h9n+zHgAlfctVPO0pFJoh
 WkX+7WtyiOtezY1m4r4AwNc+QkZuW0U+u/bUBM5NC1SVo8xYUJBHqjRZGWJ5q9uPTk/M
 zgJA==
X-Gm-Message-State: AHQUAuY+jWr0pI/lFfsV27rZJ2/1byT1ML9Hf14wjL4lhMzuTq7RrfQQ
 B5KM6Z9UdiRxHZDvhFv5RMpauHFpwo+lmvaUd8olwg==
X-Google-Smtp-Source: AHgI3IbzQ3IeJ3DdtureLg8xHbfzWl4k26RcwSMIdPdFZQbQ2oXfH0JWdLJfU9vlDhlDrZoE5TP5lbkNIdumuA65DBY=
X-Received: by 2002:a65:6651:: with SMTP id z17mr23465185pgv.95.1551191958932; 
 Tue, 26 Feb 2019 06:39:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com>
 <8343cd77ca301df15839796f3b446b75ce5ffbbf.1550839937.git.andreyknvl@google.com>
 <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com>
In-Reply-To: <73f2f3fe-9a66-22a1-5aae-c282779a75f5@intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 26 Feb 2019 15:39:08 +0100
Message-ID: <CAAeHK+yQU8khtOoyDKqmHterCa16P7oWe9AMiPnrxE+Gyb_7aw@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] fs,
 arm64: untag user pointers in fs/userfaultfd.c
To: Dave Hansen <dave.hansen@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_063919_832808_E4C777D6 
X-CRM114-Status: GOOD (  12.75  )
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
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 23, 2019 at 12:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > userfaultfd_register() and userfaultfd_unregister() use provided user
> > pointers for vma lookups, which can only by done with untagged pointers.
>
> So, we have to patch all these sites before the tagged values get to the
> point of hitting the vma lookup functions.  Dumb question: Why don't we
> just patch the vma lookup functions themselves instead of all of these
> callers?

That might be a working approach as well. We'll still need to fix up
places where the vma fields are accessed directly. Catalin, what do
you think?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
