Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C773AC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F0620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eKzYeDc/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPUotTRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F0620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=crBJ9JzAmmZXOplmo73c7c0vm+/xiL/ps8Fjvb6G5C8=; b=eKzYeDc/Pa7uG0
	kmBnLsdG/fW90mY9Emz0JmblIDvQVQVJ3FbLscbOT/nC98xHG3z6fNBsrh8lNf5bdWL+9sInlk2og
	J8X/FXo5hVX6piFmT9gmZ4bcyWW6ee3kRzljuMOkLOvORYqedKUqe420iu/1bhz8u1sfDOtOw6Fkt
	9DtmV0ErtJ2xfdYBpKpbLK00VnUCaHD3KRnvv5xGZyIPYaJAKcsaaPVlwPWxEtXnB9pjfg8DFkDhd
	Zt3Ho0X9CMzptx+9d3ovLirttbg2hO43pzMXOrJZBh/j8H8oOIYmZe5t0joffyXQyjb8GRvNsHEzO
	N3E5wNMDEulDrb9YW6/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXC1x-0006F5-M8; Wed, 12 Dec 2018 21:26:57 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXC1u-0006Ea-QC
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:26:56 +0000
Received: by mail-yb1-xb41.google.com with SMTP id d136so4559869ybh.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5+BEnt5TG3QOBL/f8mAJzw3vK7N3jl5vCJSfFl08wQY=;
 b=QPUotTRVuRp9KxDZx+5x+wBVFbeT04GHuk4L3BknKaVJKmddGfZqdq/rTjvIWER3OJ
 3PCnXgXdxeDcAI664xzlmEf8wPfLtGiXdciZgtuHqFIB+39SSWll0r7bhFlJmJINTEV6
 0vlpX33NvjWOeMmRFXp1Q9vGPqFa/9kgbYWTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+BEnt5TG3QOBL/f8mAJzw3vK7N3jl5vCJSfFl08wQY=;
 b=W8+M8RpN/fxsoJXBY6gwXOzQBNsz0Fqcsc+GFWWx5MwcPB2nYMFq0E2BLwOkkjAxtf
 wm8fe0Urv7KwpEoe7SccTyvfRwXF9jw5OrjXvdqxMG47F+89wBnT/4VNl/j0Ns4wLign
 NcWTDyo8xat+nVd4L20O8zlAAuDgCHnvxQKpRTFI6NQlaJMH+HCvuZMZfwS5n1t51VXd
 RUmJgW94w+5Y73KWuS97mE8FSoWbu0AWfUYVaDTHG6NZZVBxfxPJt+q22reUgU/OqEOm
 zfEhH3fmC0y3U4wySCARVC7J+cIOuPOT3gHSndBST4lArGvFUZKitCVPuQXRhsitLZVC
 9JHQ==
X-Gm-Message-State: AA+aEWbyd+8whci9PgGLpOA6RaM/6C/MvdaFxRqESwAb975136EqpcKK
 TNupz2JxfC/oKNMlE+OQYZWvtw8KToc=
X-Google-Smtp-Source: AFSGD/VuhXHu1aPkTAPXlH1o1k8i0EC9xoW53BuAgvZmzXZZkl1x6sfC1RuNQYM4/Np9AZ4tBzAKLg==
X-Received: by 2002:a25:2207:: with SMTP id i7mr3937722ybi.365.1544650003141; 
 Wed, 12 Dec 2018 13:26:43 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com.
 [209.85.161.53])
 by smtp.gmail.com with ESMTPSA id p201sm6855225ywe.45.2018.12.12.13.26.40
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 13:26:40 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id l200so7609810ywe.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:26:40 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr22076490ywj.47.1544650000024; 
 Wed, 12 Dec 2018 13:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com>
 <20181209103740.GB30658@n2100.armlinux.org.uk>
 <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
In-Reply-To: <CAGXu5j+WLpjNq0p41eu+VeZxV3yeTB19uNYxCQevbcDYkv7gJw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Dec 2018 13:26:26 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+FzZ7FuhLvfR6Lm_d7dN2Pc3qn7xaqV6HLp6xtGy+kGg@mail.gmail.com>
Message-ID: <CAGXu5j+FzZ7FuhLvfR6Lm_d7dN2Pc3qn7xaqV6HLp6xtGy+kGg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
To: Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_132654_867322_EBEF97E6 
X-CRM114-Status: GOOD (  16.64  )
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
Cc: kbuild test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 LKML <linux-kernel@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>,
 kbuild-all@01.org, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 2:34 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Dec 9, 2018 at 2:38 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
> > > Hi Ard,
> > >
> > > I love your patch! Perhaps something to improve:
> >
> > Hi,
> >
> > This looks to me like a false warning - how can a patch touching arch
> > code affect the result of lib/test_ubsan.c?  Please can you double-
> > check this result?
>
> Yeah, no idea. Do you want me to toss this into the ARM patch queue?
> If not, I can this through the gcc-plugin tree.

Since the ARM changes are relatively small, and it adds a new plugin,
I'll take this via the gcc-plugins tree for -next now. Please yell if
this should be done differently.

Thanks!

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
