Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB46C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAAB20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BjWfVYqI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nINlQ++D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAAB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s55UnVxptvL616pNb7eMHa3Xvkee5NXm923tk05r77Q=; b=BjWfVYqIghy9TT
	qMJBbK4kDsQShJF8dvTKtv2Y/WfH4wHCMW9NcG7fHst1r31+nqAb5hTcrgExp9QojtjesEggwehAs
	CFMZzeULaZih6FguPjA8sDPWULt2l9kf1ZvvQpJqcI8hZ+VyT5W4n/EgJW+HGttWRF5i8lb14P0oC
	DVVZCld/WPOCm66Guj18knQEGeYBTQhPWzobp+inSbUpM96Umh0BsEx29loewVJ/UdqaAT5qyotW9
	i+Pm8z41gigm+ySeDhYZwdH8sf9uotoqwUsDo2DjZDYzeleOVB3Wv5szprBop9q11Pvs/qxeR8d5n
	ExFKwhhp2vkv3ECY9vbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqla-00081s-TZ; Thu, 06 Dec 2018 10:20:22 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqlX-0007gO-AK
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:20:20 +0000
Received: by mail-it1-x142.google.com with SMTP id x124so16564102itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qMLX7TZgGimHpOPxJ6kf9Gyqt7YLykVCggBq8z/2DPk=;
 b=nINlQ++D+/shIxgOMKvy2sqsuA0UcM6LgdCMXam3mX6f0qNCRtICzkK+cD0qDRUeym
 N4HQKf1ua05IzqSRb84TTyGK0f1aotpGruvCow11Ol+K/FmWe5zemmwA2VtpcfoXMVUV
 ShmC8TZkEaMMBdrtFzPFVzzqFb2MjpP6XaUZGv3ToA8pcl3CF9ogyiFDvKehemJ6e+tU
 GoquIWdl92+ABFOSi6naZEgd615nk8U2HbElPG3A5Qw3hcBGFKVG6hepUAyzzajue+LK
 3it+GfnQaKjGwSpLlZQQiI1iuLUs890rUiM8qQnzymv4zRrFWl8+T6RW3wn9c+iDtieo
 7kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qMLX7TZgGimHpOPxJ6kf9Gyqt7YLykVCggBq8z/2DPk=;
 b=i1HqUjoFb9x00fZCXYM+8HkRng1GFk+B3i02NnTCRmqihtUe0QsTgov0rzjDyPX2ko
 EPB+qL+385b7SCvqZZ+TBPvWuJudzQGIrsNa81GXZZEUm/ENjMsxhQ82ffq8oA1s0TrK
 Kz3HTmlPi504Z2Fp7VlYMmOHd1Loi+v2yAu1WyVUYvGZ7SqXvasJALO2kWiPfBfURj44
 pG8j84mjF509piTXfGUeQys5KK1q2DmzZBgGPqYt7kJ07d1bHnfCrNV/5RWXLOvfcnzR
 MFfdkTHMfpdtoDbb376A/97/lqmnFuk3zlh6SCx9pORud6O7gYvBXtYYHcvEdrVmtR5b
 SuvQ==
X-Gm-Message-State: AA+aEWZxss3nH06aBSUqOjSksj1bQeP7EsBgN1Ox39Uqwce0ycgs92zF
 4JpVdtLDnse0xfAxkwA25BQzSXBLcDqBMi6RQLUMZQ==
X-Google-Smtp-Source: AFSGD/V0S/VS0r8YYqUJXBp2ufBpxX2HkEz6m2+mhQ1R0QsMnoWizbVgluEHuL+4DwwDPGClzxOCNIoxDwAepSixwt8=
X-Received: by 2002:a24:cb02:: with SMTP id u2mr16244774itg.87.1544091608562; 
 Thu, 06 Dec 2018 02:20:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com>
 <996c9b3898bb3c5de977d00215ddc4bf8cf154c1.1543337629.git.andreyknvl@google.com>
 <20181129180134.GA4318@arm.com>
In-Reply-To: <20181129180134.GA4318@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 11:19:57 +0100
Message-ID: <CAAeHK+yN6Jrk6G6OjbkMHwCxkuQHfrz8PXtPTUdrfsHaru_eKA@mail.gmail.com>
Subject: Re: [PATCH v12 23/25] kasan, arm64: select HAVE_ARCH_KASAN_SW_TAGS
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_022019_354237_99232255 
X-CRM114-Status: GOOD (  16.42  )
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

On Thu, Nov 29, 2018 at 7:01 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Nov 27, 2018 at 05:55:41PM +0100, Andrey Konovalov wrote:
> > Now, that all the necessary infrastructure code has been introduced,
> > select HAVE_ARCH_KASAN_SW_TAGS for arm64 to enable software tag-based
> > KASAN mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 787d7850e064..8b331dcfb48e 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -111,6 +111,7 @@ config ARM64
> >       select HAVE_ARCH_JUMP_LABEL
> >       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >       select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > +     select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>
> Can you do if HAVE_ARCH_KASAN instead?

Will do in v13, thanks!

>
> Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
