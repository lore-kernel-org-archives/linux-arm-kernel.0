Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA85E2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHaa7EkV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEiA/aO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA85E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zNv/2arZmhMkaYUwWaphnjVi8P0X1JAE0yvfEjp3E6g=; b=SHaa7EkVlwmrn/
	YR9ln2siSQKJmoO1SWMdsFg0/Y2Htk0frgZdaV2rKRAju/IJzul89V5gejKDBI+nFpB0avkFFR6al
	a/LjB0HQQ/Gz26n2UeEXFdaZNVtCCkeYtHwaEJc2wbKUgAozs6H52A1goUkHoOoOhxvHHYsQ7eR1y
	XhaYOXebA4ciidemp46XMIWPE6XW1hHvvVPZOdU4oPmkZMl3rPMXHCj//t1ERYjt53GixTP1nN+n4
	zpZw3Fs4FnQ5LxeQvpIyXPvSf9PMcYIOR3RJ9qQxxRi2jITlWLr/IlgHTFUugAefM66wtR72fFDzr
	c3I4hwBx2+Dcmi/88FlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjfz1-000566-OG; Wed, 16 Jan 2019 07:51:31 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjfyy-00055f-QD
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 07:51:30 +0000
Received: by mail-it1-x141.google.com with SMTP id i145so1660304ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 23:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7XT7jZZ1KVvwJQprqHTVEfavipuUF6Dnl96nB3egJmI=;
 b=MEiA/aO55PvUS/MupCPg9KzGZlspdTMND+8hFUqzgDay9Zp9ugeEaNMXSp8+GBur7S
 4uoN62fj6evhLktpHApTtX9P9ygy3bSSyrYRWTHMuR1cqZ1tvIRZUi5TwlTcFRDWpuhJ
 agsE83413pOZthNSJuTPGi7ujklEkUo/uQpFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7XT7jZZ1KVvwJQprqHTVEfavipuUF6Dnl96nB3egJmI=;
 b=ik3V8YLfebdDebGBpMVhLVEQIG+8u7zvmimEk/RkWj75QfmEktSFmcNRJh326WuTCi
 0Km4tnt0iUNR0O+wfA55z1eWWqPaZxNVC/d8dq/XF4Yi/QB/uvmhPV11XgBqdanRymAs
 cY4382qETOj52ybPj1C8HTRISeTc6kBGCt5qKbT33nmWiSDD0rDRNpGepRs5lbmYwK8p
 mD7nUfqMp+hkTjypKlflSlFlH7MBfwP7c9QbFTR5xvmPJ3acnpS7abY6kXvMYhOq5UTq
 glMv6pACJ/Rl8j9o1A9O0KnFd6o51klp0s39PahD+B251lWH2r6MCXAdWUJ/ebwhrTne
 THug==
X-Gm-Message-State: AJcUukcW7HGQ/6euKwDazah0xZOIHe0/EG1xBolBTaHSY9qpUKMbn0yX
 t9KB/pvvr2fus6oWXFwxd/RjmeZPGwuqO68T+yFgjg==
X-Google-Smtp-Source: ALg8bN44DvQCdxWT4wJ5kHWaz4SBhYyIyXo9PX2yiG3/ACbRNwwKp8CKMRcrrmcFKDEtNM9Nx05xSHXq4DEzTdr9ET0=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr4988806itk.71.1547625087024; 
 Tue, 15 Jan 2019 23:51:27 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
 <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB028993B73A531E5C7EA62DCEDF820@BLUPR13MB0289.namprd13.prod.outlook.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 16 Jan 2019 08:51:16 +0100
Message-ID: <CAKv+Gu-0JUqihHGQt+YyvUHRTizTOWywXqMaE4RiXOjQ7xi7zA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To: Yueyi Li <liyueyi@live.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_235128_884698_4809712B 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "markus@oberhumer.com" <markus@oberhumer.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 04:37, Yueyi Li <liyueyi@live.com> wrote:
>
> OK, thanks. But seems this mail be ignored, do i need re-sent the patch?
>
> On 2018/12/26 21:49, Ard Biesheuvel wrote:
> > On Tue, 25 Dec 2018 at 03:30, Yueyi Li <liyueyi@live.com> wrote:
> >> Hi Ard,
> >>
> >>
> >> On 2018/12/24 17:45, Ard Biesheuvel wrote:
> >>> Does the following change fix your issue as well?
> >>>
> >>> index 9b432d9fcada..9dcf0ff75a11 100644
> >>> --- a/arch/arm64/mm/init.c
> >>> +++ b/arch/arm64/mm/init.c
> >>> @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
> >>>                    * memory spans, randomize the linear region as well.
> >>>                    */
> >>>                   if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> >>> -                       range = range / ARM64_MEMSTART_ALIGN + 1;
> >>> +                       range /= ARM64_MEMSTART_ALIGN;
> >>>                           memstart_addr -= ARM64_MEMSTART_ALIGN *
> >>>                                            ((range * memstart_offset_seed) >> 16);
> >>>                   }
> >> Yes, it can fix this also. I just think modify the first *range*
> >> calculation would be easier to grasp, what do you think?
> >>
> > I don't think there is a difference, to be honest, but I will leave it
> > up to the maintainers to decide which approach they prefer.
>

No it has been merged already. It is in v5.0-rc2 I think.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
