Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4190AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:18:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081CD21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6ylEtq7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jKQxnJ/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081CD21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mq0zxxEtHaVsq36xyWG1Aqti/qyoln1N/ru8FqEpawc=; b=Q6ylEtq7T3OB1C
	vbJ6FfT2a0VRBlEig+rkIknmsCgAVBPDK2jR8tuZCSPCq3sggESt6Dw28sITpgdmsKKYPg0whyCEj
	suliGTaX0vCLfn6wIalm/JUCGmPdD6iKn0RdasqYEhgVr/UjHRO8MsNe1bjYnKjJDR06Nh4vW8wIK
	VGJrPcjnxDD9RrNuVZGzuThKVhdRU1cjZZZZnMG12LpWrSmHtoONBvdUkWyCYpG8s0ebo3PXyjf5M
	qj4dRyW9q9Lk34FgT6zGpugUZ6Aeb07M77JpuLt0NSk1fd/CIqh13ScNCzMfL8QZWuntDZMO3ypHv
	WpVtUWcyuDbqRUHHSUOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gygNN-00060X-CS; Tue, 26 Feb 2019 17:18:41 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gygNJ-0005zw-O7
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 17:18:39 +0000
Received: by mail-pg1-x542.google.com with SMTP id h11so6532898pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OOLLQFuNWZNcLbvoTKuul2PBnwLCZZV2yl5Rkby6ik0=;
 b=jKQxnJ/2x4dghTfRCCMI3Ml+fWRz4qrTqCcicLGZ011UNcos0yKVjUpXrkbq1VSVeW
 thw1sbzK7pCfkew2gQKrUI4Um5IJtqCZYZl1rRF7/8YMUzhpPVGNh8aOoaGrih+yhLcy
 LCoJSquWccU9cGAkJnes4V09W4/XvNYzxNcibfJSCuI99Gg6RPHY5pmjvUZ1DuZqFDit
 ziJwyd/cyIJEi3eTWqcjGCyQMJaZAOTApXtCDMV5IOpvOaGfw5zzajED6bFcBJNSmM3I
 YcDKPQPB7vjE9vMtguW2z7/5cxVHfa+F/TkDtfCUR0jZU+bpcDyeyF4vkjHEHWHZXTfm
 OCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OOLLQFuNWZNcLbvoTKuul2PBnwLCZZV2yl5Rkby6ik0=;
 b=cE0Ur7pEObQ2FWf9EmuW7OaWu+pNxo1aTlOHHjn2czknZW1jks+/OCF9OOaH2TrJcS
 erLwZiY8MLeYzTBPWTxju3UnlMMBKvCpeWVvC/U8OtITZFCo5e21Ck4q2O1fiNRQFGnU
 V3TxAkGYRmv/UebJqt6I8tHOe9TKxwQy1zEK4i/SdMsNfTIfcoOHvV5DUIWYAiMbIMYt
 EeXwFVSO4yMUtK7ftFAbZOj9DdLnFbLOXffQc+LUY3wOr1CmqmwjvTBL6Q8xBoFyaD0X
 R8StOFvUDHCgP13ynzMB07RSibajkPu6J8zyiZkFNx8Y1f8M1jXSLtX1ku1frXWc64hJ
 LTEg==
X-Gm-Message-State: AHQUAuZm5wk0mfFTLXp7MNPIvL9irEHgbnbep2DVsbWwdB1jyDQXM440
 JLd96gTMwYFpqB7oc9+5EX8UtIX0q/6bzhFR+izHGw==
X-Google-Smtp-Source: AHgI3IaXslkW65Krggxq02hHR+yQdwUvqf+Fm8usmvuxZoEAwJCPo0+6iEl0097nd7G7eW84XOO0Y0ABXCeIR1f9/5I=
X-Received: by 2002:a63:d80b:: with SMTP id b11mr25226432pgh.168.1551201516864; 
 Tue, 26 Feb 2019 09:18:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com>
 <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
In-Reply-To: <2ad5f897-25c0-90cf-f54f-827876873a0a@intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 26 Feb 2019 18:18:25 +0100
Message-ID: <CAAeHK+xCi2MxaykYWCz9mwbOzNpjrFcHex7B-VXektNNWBT+Hw@mail.gmail.com>
Subject: Re: [PATCH v10 00/12] arm64: untag user pointers passed to the kernel
To: Dave Hansen <dave.hansen@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_091837_841535_C533CA0F 
X-CRM114-Status: GOOD (  17.10  )
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

On Fri, Feb 22, 2019 at 11:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > The following testing approaches has been taken to find potential issues
> > with user pointer untagging:
> >
> > 1. Static testing (with sparse [3] and separately with a custom static
> >    analyzer based on Clang) to track casts of __user pointers to integer
> >    types to find places where untagging needs to be done.
>
> First of all, it's really cool that you took this approach.  Sounds like
> there was a lot of systematic work to fix up the sites in the existing
> codebase.
>
> But, isn't this a _bit_ fragile going forward?  Folks can't just "make
> sparse" to find issues with missing untags.

Yes, this static approach can only be used as a hint to find some
places where untagging is needed, but certainly not all.

> This seems like something
> where we would ideally add an __tagged annotation (or something) to the
> source tree and then have sparse rules that can look for missed untags.

This has been suggested before, search for __untagged here [1].
However there are many places in the kernel where a __user pointer is
casted into unsigned long and passed further. I'm not sure if it's
possible apply a __tagged/__untagged kind of attribute to non-pointer
types, is it?

[1] https://patchwork.kernel.org/patch/10581535/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
