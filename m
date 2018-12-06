Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:35:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A36220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="geBDLYfZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QHnyJ6/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A36220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q924U3ixlW5N2JQ4PFaby1iTscuEekOWUuzRFRMSymA=; b=geBDLYfZ1OzJ89
	BOXV6BTyyNQ6XRZztRWiecpNh6eR7QHK4TXHZ63AUKkX2/OSAh89lzZpjbLm6gIq4vmZsxtU5gjc5
	v3o6h8/NkzZb/OlBZjTfGVSMLLhWsgft+8pXEyBf/hYyJ2XND90BUiCeib4Vo2l5X6+p4ZZ2r/jim
	+9rg1yXdCorQQtsReolIia3etcV2ZjhRc7X5hfbQROpA5qhLqQJqcQEQvBOmz6yfl7DNQ6iMffw1L
	1OXPCcjippwNl+cOwJTwyPjToOUDku0SBPnWak1KvPVl8TUhNKogtLAnwavB0qX9RZsehllHaNm23
	Ub2xo+S78FJShlpnEw1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUssD-0006Xr-T8; Thu, 06 Dec 2018 12:35:21 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsrj-000578-7Q
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:34:52 +0000
Received: by mail-it1-x144.google.com with SMTP id a6so1120661itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 04:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nM+uQOx9zVJ8TTDrLmJDveS5niw0RvoquTiTM/JIbLw=;
 b=QHnyJ6/yH1EW8wjSmjDnHSybVF3eCxoG9OkhLo5sURlwI01Pae6pEQvUlJsCDaHhwL
 G5Cd0KNGuaAj/ArVykwK2mLAPerPTIgmOQ5Q1on6L+lMwIiASbdSu37Fs//KLDjiC04l
 gn9wWyu3uDky0aLZ1hvFbH9Xc+fTbWS4EoIIS5s4DtydWN3R8iypwu3sV2u1f17zvwNG
 npmu2Pho+qxFun7F39seB2GkAAI5ILuX8ogvU3FI6GeHMZWdBv5PSt08LQO8bp8fsiwv
 L+nhIJ01aqxbN1cSawS17opGL3Mx73CqRDXsS2KC9lyrvN+/i9V8NQp6xW2gi+Fs7rdC
 JkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nM+uQOx9zVJ8TTDrLmJDveS5niw0RvoquTiTM/JIbLw=;
 b=PqqCLLr6BV3N34A68xSzpXAzpZcM/yVVrijyKhnPYj4iA5E8b+EdcKzL2tIa9I4KHf
 UDnDJ3rvoCXPWVcD0JXc92aLAsgjpe6XQX3nAv6r5HPjS2OjgezLnwXUXTt4JJUmuLvk
 61cVVlM4btUVTgOlIRLFQPh/bbGpp54fRxQk3jgB+ohAUpGiGoda9P72GHN/p0uUSn4t
 x9RJKoYl3mEi7puKvC3g6FvhxB5/Vk04mp69DZm7hHYYHXqDR5Bjd4bEaV6XwpI9KaBu
 GCWwTyxAxxO419HWPn8WsIk72O+vrKIXJFR/n+cRTcWOxMYol5ebLknjPqPLxSnvr3Ez
 xAEA==
X-Gm-Message-State: AA+aEWadtknjw+hIZWS4yW6GG35NmDZVDp5Kuxce2oJS9HaSCwM0dusR
 Nf13QQAE7/mg2KiB+NK/x78xx9++dTp0HAqfQgAP9w==
X-Google-Smtp-Source: AFSGD/VcGSD8ikWZwwSM3NrN8u9F7ooCVd7MOzvHziuFtTWLcldbEDKMv2fzZYPc4Ei/J45KpUmfQ3cx0v8+PATAUoU=
X-Received: by 2002:a02:93c2:: with SMTP id z60mr24418458jah.51.1544099679394; 
 Thu, 06 Dec 2018 04:34:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541687720.git.andreyknvl@google.com>
 <4a4063a3e074608b99cf22ab447fecc36d056251.1541687720.git.andreyknvl@google.com>
 <20181129182218.GH22027@arrakis.emea.arm.com>
In-Reply-To: <20181129182218.GH22027@arrakis.emea.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 13:34:28 +0100
Message-ID: <CAAeHK+z3uJrkwunH6DDuJOVg_trk6pmKgN4QLx7LnDLEP1TSDw@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] arm64: add type casts to untagged_addr macro
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_043451_290436_F50C537D 
X-CRM114-Status: GOOD (  18.96  )
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
 Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 7:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Nov 08, 2018 at 03:36:08PM +0100, Andrey Konovalov wrote:
> > This patch makes the untagged_addr macro accept all kinds of address types
> > (void *, unsigned long, etc.) and allows not to specify type casts in each
> > place where it is used. This is done by using __typeof__.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/uaccess.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 07c34087bd5e..c1325271e368 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -101,7 +101,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> >   * up with a tagged userland pointer. Clear the tag to get a sane pointer to
> >   * pass on to access_ok(), for instance.
> >   */
> > -#define untagged_addr(addr)          sign_extend64(addr, 55)
> > +#define untagged_addr(addr)          \
> > +     ((__typeof__(addr))sign_extend64((__u64)(addr), 55))
>
> Nitpick: same comment as here (use u64):
>
> http://lkml.kernel.org/r/20181123173739.osgvnnhmptdgtlnl@lakrids.cambridge.arm.com

Will do in v9.

>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> (not acking the whole series just yet, only specific patches to remember
> what I reviewed)

OK.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
