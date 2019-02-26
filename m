Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECA9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E73420C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUX+peFt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XRKcLkoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E73420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J2UHpB/qarLxksD49IQt+pkpVvLITtYiI/pxNSZepR0=; b=eUX+peFtYTA6EE
	SnLrQwoEbSuIoAS4hKAHXJaeQAA77gg9IOLjN3k/P+uBx3Zy7t/MRJO6jUMMEaGtSAsG0IJdlu3kf
	PmpOiB+bO44h34tcZf9xYFLvujWk5lWs/6JP8eySjpkzWZjI/M2pMOmDk7EmKB/rnZ68ETci19Q6J
	a7Fgj0htyM2tXaSYx9Z6jfKqHS8r6wcu/WPt7iivChEmf9A8d6cQpTmBIeoT73lEDBiNRw9F9cmBU
	0POKjxdE5CrhxKd0abQh5dnmcNKWSDzmg+BrMrqby8K6+FFl9f0dsVkDxBKhhE10N3/mr0RH5ETY9
	xcb2Mwhx7ZWA7i072K6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydpv-0007r1-89; Tue, 26 Feb 2019 14:35:59 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydps-0007ps-GF
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:35:57 +0000
Received: by mail-pf1-x443.google.com with SMTP id g6so6319062pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AUt4iAfRYbk6BwjoCKxvIK1Q45AuJd2RFSG+AdGqGGc=;
 b=XRKcLkoJARsdGGCLNMsEu1Vu8sk3uYCwX73ehOf3+cVLv75cO4w/3UTqMluqhaIGyh
 cCy4xvROzeQSaFXI2Iu8ow09wzrfeUVrM4ZBHYRiwLLWx0shcllKfcDdFKilrD1Kr8Mf
 pLE8gRxiLBO8WSSp7OrsZFKA+euo20XGdvScqo95ZZCUwpBjOnXMacjezDCcsLkt/Mth
 pHEFCvychKIJQf6QLymBizZy5Tzkwkra5iyXKKlgGp2QSjfkxadk85kayKTWgP4jHqma
 lYOKPh4aOy50Vdd3ysijeaTRxrjd48CuRB+UX9PdLo8hQkWNFjb25zGeU7TCq+mn7l5N
 FWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AUt4iAfRYbk6BwjoCKxvIK1Q45AuJd2RFSG+AdGqGGc=;
 b=DTLR7KvS2ma4h1aoYE9xRDuH2jKXeJnkDyUnq62Ramr+/d1SnsfVdY96vo4kHeMobQ
 w26wR3f3yMvhTuoZIUXnw6anC4Bct+/jB/NnmK05xvJwHPkUg7nppBrO/lXKIFayJPmt
 +VEyizCR9zrXN3qjniYAvCJ56bbIkqRQI3hfLwABOaOkZlu16OPLVEv+cS+HXFZT7IG/
 z2O3tcX4ZUvKgdHddK9N/NfBHPNMCCIgN0jLa9FaCi5wVr4IC6PWZ7KE3Fgc+VDINhff
 QYX4FsSNZQZYI3PmrZd8+xmFG5jhTFngbZwYCoM9rysLIfx1mVFfEiVX//l08iWPporh
 OxVA==
X-Gm-Message-State: AHQUAuYf6kLlTezgpBw6/ErA04ZEiNHjiOYCa0QdgTpNc5i2cCIzldVk
 Lr9txztTmF+Mx0m6X67PJPvKwQNykwQv51S0FfvdJg==
X-Google-Smtp-Source: AHgI3IbiQNlPq53/tUpD5IAq8EfXkU5pkBI8V4LoDzop7lQaXJ2OSriJDpc1tkZELm721YxkXsfJtn4Ts8mziEe1cTs=
X-Received: by 2002:a62:6383:: with SMTP id
 x125mr25941741pfb.239.1551191751796; 
 Tue, 26 Feb 2019 06:35:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com>
 <a958e202cdbe6e1bac8a37b7f3d9881d1b22993d.1550839937.git.andreyknvl@google.com>
 <a38275b0-f6cd-20e1-3c48-544846586a16@intel.com>
In-Reply-To: <a38275b0-f6cd-20e1-3c48-544846586a16@intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 26 Feb 2019 15:35:40 +0100
Message-ID: <CAAeHK+wLm7zSUC8dJv3LgdyvpkBN8u_24ene6b91PgM570VWbQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/12] fs,
 arm64: untag user pointers in copy_mount_options
To: Dave Hansen <dave.hansen@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_063556_562634_CA74AAE1 
X-CRM114-Status: GOOD (  16.11  )
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

On Sat, Feb 23, 2019 at 12:03 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2730,7 +2730,7 @@ void *copy_mount_options(const void __user * data)
> >        * the remainder of the page.
> >        */
> >       /* copy_from_user cannot cross TASK_SIZE ! */
> > -     size = TASK_SIZE - (unsigned long)data;
> > +     size = TASK_SIZE - (unsigned long)untagged_addr(data);
> >       if (size > PAGE_SIZE)
> >               size = PAGE_SIZE;
>
> I would have thought that copy_from_user() *is* entirely capable of
> detecting and returning an error in the case that its arguments cross
> TASK_SIZE.  It will fail and return an error, but that's what it's
> supposed to do.
>
> I'd question why this code needs to be doing its own checking in the
> first place.  Is there something subtle going on?

The comment above exact_copy_from_user() states:

Some copy_from_user() implementations do not return the exact number of
bytes remaining to copy on a fault.  But copy_mount_options() requires that.
Note that this function differs from copy_from_user() in that it will oops
on bad values of `to', rather than returning a short copy.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
