Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:50:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097A820836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PsNHf5IH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="t05Y81Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097A820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3nC/mI1UdMVka3bhcljY4WEa+E9RJsm8XrWM8hLX9Ak=; b=PsNHf5IHEepzIh
	MREOr0XPctmHWOSXUNaNPUgPiR8efJkcrKyHftHARJjICO/l1N7Na6SpsXi4qo5m7T8p9XK0/ZU38
	QK85eQ3j6MAkTG/rqWOZAMmB0MYEBhtcINKAHqO4lc1G9VoEZzdJKoiGpM5tadUw8w94YaieiSZxg
	d/A4u54hzfa1zqvnn1zH859aKax0v/bTL4+MTUa0YVQR13JKpAkL9bSd1T/aPPQNky5iZl8DKc2mQ
	Mv2RpUUfLyT+ruMb+wwwuNFg7MKhdmcOw7VDE5Ojlhtx8VIIromO0QMIDhiMf9m1sUJ3DCT/nMT5U
	cNw4fCWzUtbIffinLEeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giMUq-0004St-P7; Sat, 12 Jan 2019 16:50:56 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giMUo-0004SV-1V
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 16:50:55 +0000
Received: by mail-yw1-xc43.google.com with SMTP id h32so7071957ywk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VaO7ZxXFClP1+k1Rrf7irHfcf76KrsN+FQv9UEeh0gk=;
 b=t05Y81BuMZSuJ3Qf03/s29f5cEJAeohwbr5hZJc2RrcPRO6eHvSCEwsoBZ8TncZdL9
 PmSFv57lPf98jmd7DJUXckoKesFwgGPp40VY4Gblne/wQyqG/r/MqToljc9zsCz0qxKp
 aRnm5M1tt5gMo/vHEU2zJp8W2o3GF8OgA4ajXs0FGG40PWe6hFw+ca4OkI60pLBD3kWB
 2n2BGWP7tzRyD26c8OTdhD2D0L1F4/eMN6vCzDo06ugdYINGlLUAp76YatbfknmKYRpH
 RxNfLgU6S5LVmaxnqLCcIX5XK4x4ZS2dNEqHJe3KNImCAkYzyXEhDG7xdyu1Mm9rEMYB
 k3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VaO7ZxXFClP1+k1Rrf7irHfcf76KrsN+FQv9UEeh0gk=;
 b=msMDSBpt4BEvb6E1x9OYbDTkle+0RgbOX2jCx9ihwEAHtMgEOcsSp+IGP947LgjtCM
 sstEFSRRN5EEliHiIM1YLLdEjYT2AEH3cO11U0NgS0fw5/8iQepEyo7Gs4gS0D6g9ORH
 5b5nhSOVgsHvllBuXP9n4unbeBqdjSwXpKu+2ncKvcYXF8bP4M1nGxnV1i5vTMaH5fiO
 GC8e1Bd5HxFKxk0WWsn77duM4jn+rNEyWg4yw2AaQvj0sAoOkET7/gdOlS3k3DyhVrbw
 A3wj7N404QEi8BSPfRa7foo96HsQmXrfyxGGmeiKHVq+3L8RsKTZH86ATWu8r6ukxzi3
 i4UQ==
X-Gm-Message-State: AJcUukdpvsmgnHhld85qP5SyIcMtgsfMZeHO1LJ4cI088BuAWJI9hJmj
 KgxFKO6Db0AQPPNoHSSU5TGTw5M2RLEhzdXomocm/w==
X-Google-Smtp-Source: ALg8bN6XzD17LVLAX7m/kSOcIUQ121Lu7vVxRfY/g+CIrLDeBR87sI3stQrULnEovy6QxqBn0V1BYoxbhWieErSfFEc=
X-Received: by 2002:a81:60c4:: with SMTP id
 u187mr18077076ywb.345.1547311853069; 
 Sat, 12 Jan 2019 08:50:53 -0800 (PST)
MIME-Version: 1.0
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
 <20190112154944.GT6310@bombadil.infradead.org>
In-Reply-To: <20190112154944.GT6310@bombadil.infradead.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Sat, 12 Jan 2019 08:50:42 -0800
Message-ID: <CALvZod5XfFujzzMC0n2dZmofjof0juWw45RF4475CAEu9nAv3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To: Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_085054_105511_27A364F5 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: mark.rutland@arm.com, Michal Hocko <mhocko@suse.com>,
 linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, will.deacon@arm.com,
 christoffer.dall@arm.com, Linux MM <linux-mm@kvack.org>,
 kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com,
 linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>, ard.biesheuvel@linaro.org,
 linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 LKML <linux-kernel@vger.kernel.org>, james.morse@arm.com,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 7:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
> > As far as I can see,
> >
> > #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> >
> > So what's the difference between:
> >
> > (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
> >
> > and
> >
> > (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT
>
> Nothing.  But there's a huge difference in the other parts of that same
> file where GFP_ACCOUNT is _not_ used.
>
> I think this unification is too small to bother with.  Something I've
> had on my todo list for some time and have not done anything about
> is to actually unify all of the architecture pte/pmd/... allocations.
> There are tricks some architectures use that others would benefit from.

Can you explain a bit more on this? If this is too low priority on
your todo list then maybe me or someone else can pick that up.

Shakeel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
