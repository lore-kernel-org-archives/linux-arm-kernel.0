Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8837C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97167208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SKwS34Gp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFm3bXZn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fH8wewH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97167208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+0GbPe0NLSp9YcpEW5q7HgFx8pYIIRh7j6oUv+OgXX4=; b=SKwS34GpQIQ7JE
	x+obI4FLCSOpumOEnz/8MFBNAAKYZyMpiEKJ4ISBLWiuE+oVq/97MK7j7V5y13RwpkdeCTB6yoZWE
	Ju1J5CJRVqqmCpQjFh+ZLuCfyHQd4pnQ+ZYvszza7lw68l9kyLYxLR9teP2cnogmBgqoK5N+ZOkBr
	7PSECACIi9ndInWacmMO/7WKYYlUZAXDP4Wk3aPmDtSBXDfgmwbA+yiFjsIObQSMuSXrno91zOYbx
	UXN6SqAe0PvKxJG1aNlw3TrF0+NIIqyPGktNN0LPSMAt/tyqa7TyMzpN/eWnUPH3eNrndHBr5J728
	6htjmn7igZgZcqZmXelA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkR4-0007Mp-Ss; Tue, 11 Dec 2018 15:59:02 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkQ0-0006Vx-Eu
 for linux-arm-kernel@bombadil.infradead.org; Tue, 11 Dec 2018 15:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a7GgIEdfZjoPzHXKjruKKF4bLDJm5C4iEVQoLgxYlNA=; b=QFm3bXZnu4VTDC08m6NfSZoTU
 SpVCdmmDU6bN5vUI7EzE7b0h2XVQmAIucz3FJrYaEqnEWkm3jr1Eksysq9aESLA1UzU5iS/0ayisK
 0JnJc21SvTZO6sGcdIkdLVBF77J55cR55nho/K6ahy05VzRoA2zU8gLkduSQyPWU0pADQdS5oOBaE
 QFRllpFK8yPrAt5ivBZILN3eXqi6bRzwKSL3MP0W5JePkPpLEAiYSi8nzaPloK18mOvfCuo2Nz1cR
 ukx1hstbJduD8KYGLPsG9bHPI0kvaCBLAr+eoA/HHbJLDPIyaCwYCpFoPv+dV16juaseGTMUJ3k+H
 g8RkmSUww==;
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkPx-000867-Q5
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:57:54 +0000
Received: by mail-it1-x141.google.com with SMTP id h193so4560328ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a7GgIEdfZjoPzHXKjruKKF4bLDJm5C4iEVQoLgxYlNA=;
 b=fH8wewH9gmW8AIjXG6YvW2fWZybyPGueW2f9j6NdlkI3Z7ckHNTRhh1FJ6eIawfQic
 9vGKLZP3xeEqyD4xNOnZBTlsbEKV+lD5egwUeZHOdL3PAmAdnXsxdfpZsUciZYOmBEMI
 AbooqmZp9PEpsHNoceG1/b+l2lQg6cZe1w82YxIEomS4n0b3Sb+jsVUjGa4MP50xfK+Y
 Jsihn+2y8LcLv0/YUn6Bxfh8Dv1RDipi/PRCJYfAz6btaSMsIpAvXjTVA1E1d9q+TdzZ
 Zqg5kWBek54CrgILRXCSWZBXQNIFeeEpeOxyncmdwOXbdciTJjxNfxut3FzYEx0IVBpv
 ba3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a7GgIEdfZjoPzHXKjruKKF4bLDJm5C4iEVQoLgxYlNA=;
 b=I6zAT36//xUbhjhqW0J1shVKrreHy/7a7KfTN7DouNtZzb2aj9a4uu1eesrlAhLber
 bagiO4DB0ajaN5NsR9MJFNIEm31hP8EdtdEhv4nnNmTPIoidZs8jRxtZeShJrqp9xxqc
 qE0psVZ+JYe/62oUcPQ+D2uzWeLK5oRWbhd/3SsmJV3l+6pk2rloMJpdYUduUTOHTbN8
 WN9ID56Z4hNdgnfaFPXPV5tAygrm8bkUj3+K3f8CcjZ61imhCPaKK3t1f4rAAkRdJXSD
 V2U3eXpLZX/ftZijG6pCMprPNNwnpVHcJu3gD+w2vjwHgDcAFN7H5CkrIds8xMZhM2u/
 M+Dg==
X-Gm-Message-State: AA+aEWayCQALSHobrTMUtCqHn6xvDunMpztoGmuVz1JfvkeVdJJRhi1q
 F0yIzLmXnauswcRvKqr/zZO865uenhwBzjkC6dG1bQ==
X-Google-Smtp-Source: AFSGD/Xa42s7qlran/2s4FWOHYk5xWmochjhyXZBVfzlmdyFZy2EvirPhMaWO+rQ7u7Ip2B7ZNTDTDx6JtS+Ar/D0xc=
X-Received: by 2002:a02:93c2:: with SMTP id z60mr14982400jah.51.1544543859038; 
 Tue, 11 Dec 2018 07:57:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com>
 <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181211151829.GB11718@edgewater-inn.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 11 Dec 2018 16:57:27 +0100
Message-ID: <CAAeHK+xxNsOfaUZhcErc+fjEEv0YZ-dbQ0fTXzQUO4dZbM-GgA@mail.gmail.com>
Subject: Re: [PATCH v13 00/25] kasan: add software tag-based mode for arm64
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_105753_954236_23B87FDF 
X-CRM114-Status: GOOD (  21.14  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 4:18 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Andrey,
>
> On Thu, Dec 06, 2018 at 01:24:18PM +0100, Andrey Konovalov wrote:
> > This patchset adds a new software tag-based mode to KASAN [1].
> > (Initially this mode was called KHWASAN, but it got renamed,
> >  see the naming rationale at the end of this section).
> >
> > The plan is to implement HWASan [2] for the kernel with the incentive,
> > that it's going to have comparable to KASAN performance, but in the same
> > time consume much less memory, trading that off for somewhat imprecise
> > bug detection and being supported only for arm64.
>
> For the arm64 parts:
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> I assume that you plan to replace the current patches in -mm with this
> series?
>
> Cheers,
>
> Will

Hi Will,

Yes, that was the intention of sending v13. Should have I sent a
separate patch with v12->v13 fixes instead? I don't know what's the
usual way to make changes to the patchset once it's in the mm tree.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
