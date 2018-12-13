Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF132C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:43:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F7220849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l5p31xjX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7530Jh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F7220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pzJoUbkv5qPx0mieyuy5K4Q9uSQCTtrbIUnbWyrG1PE=; b=l5p31xjXOB2PF0
	BAr3dBII/UBSoh8tcGAEspSIJ8IuzgvJ3LCrL/lXcBTcAc/hoQOBlzqa0F6bS3T1hfZQord0hl2kw
	ssuB8yllHx7H9tZ7Ck/sUJADL2mhfktIO7JO/OUiTlYepglwCYt08m3AQ/7spImU4sxDI+nhmg1YS
	U4n40vgHw3sNx8O5OcYo50KLDzKp0LvtNYJJtj8ct5HGJCaVweuHGvB3yBXTmFtjqX82CpoGTpJma
	EhX5kC3e5MGTt+Ig8eKT64hNVihIAmqJ49p5hzfRn0Nb1aoCky0KSxUwOT8UYD3GTe2nYIOMj7EIG
	hCBvungdaIJ0r+SxQNrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPOa-0002uh-PQ; Thu, 13 Dec 2018 11:43:12 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPOI-0002fI-KV
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:42:57 +0000
Received: by mail-io1-xd43.google.com with SMTP id f14so1338531iol.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 03:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vHILa0maDEVF+5AKosOo5qYLT9cx7o3s+HOObjNFVkw=;
 b=h7530Jh4zKznByUUzGRXWJkCO63NnbYTucPtKHt5ctkn5HyIbUY7YbBI173cRWOJj+
 rbwqLAUt8UfeMJvzBgfOKBRGpdWZP5SIZln4AMyuTiHi5I0zrSJY/knNR7PnM73/7ohp
 ZQCWia5nZpEa0lqH5GPAXt007keQqRNor36sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vHILa0maDEVF+5AKosOo5qYLT9cx7o3s+HOObjNFVkw=;
 b=HizTOVi2OZsz3j+wC8V52X/lh9Kwb9gIL8HoGZn9KBfM/JoQnhO65AFd/mgAQ89nSA
 cGW1Nao0wTnRNgaPaCeFz/E0edpXIceJDGftDvOGLdadsGY0KMYR6/SpQjHAklxAsSou
 jYMa3LtEEx/L/r3pDtInhNlOpOPP/z8ljomyRmqZpOpUgSSvA/1oUalc8mCAZS/BnhnQ
 1NupU29Lq404ZpLCY/2D9fA+MJuoGLLd1MPtWQmIWPhOYvXNxX4tVFpomAmQiL2PxqVi
 RRDew4YnKHzVQdU9IohTpCtJUTU39Ep8UNBfR/tfpgHB0HBSiFhY8IZdVdFj29WNIo4x
 plSA==
X-Gm-Message-State: AA+aEWZI8IxW4gdxbt26Kng/rbmKnT3UhzOhBy5dzRE1EXCmVxAZx9LJ
 qcYjtuSVp8KbuL2Ug3lglV2I6T5QzZi3y8ySmpcoYWw8
X-Google-Smtp-Source: AFSGD/Udz1egqYZNGQRMAMiGoLcTu7e04N2RYq0T/YqLKJXycRps1yZ4dyIhrJ1HJVngBkujFysy3PZ3FvFI3hK/bGk=
X-Received: by 2002:a5d:8415:: with SMTP id i21mr19866326ion.173.1544701363550; 
 Thu, 13 Dec 2018 03:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20181210152855.3634-1-ard.biesheuvel@linaro.org>
 <20181210154808.GF30658@n2100.armlinux.org.uk>
 <32bfc5c2-1004-b1c2-7b68-cf3dfb05ce13@arm.com>
 <CAKv+Gu-x7G8_Zndn8H=PB7WOx1fFhpCHTsANkkoATFjozJh8wA@mail.gmail.com>
 <f7ede136-2b1e-9758-b82c-7d645c9c7dda@arm.com>
In-Reply-To: <f7ede136-2b1e-9758-b82c-7d645c9c7dda@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 13 Dec 2018 12:42:32 +0100
Message-ID: <CAKv+Gu-3FXk-n4+f0BeCSSnWnLOd5zqwC0_G3xDk8Psv-oQ6=g@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: skip cleaning of idmap page tables on LPAE
 capable cores
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_034254_735677_E59BF417 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 at 12:40, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 13/12/2018 10:57, Ard Biesheuvel wrote:
> > On Mon, 10 Dec 2018 at 17:13, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>
> >> On 10/12/2018 15:48, Russell King - ARM Linux wrote:
> >>> On Mon, Dec 10, 2018 at 04:28:55PM +0100, Ard Biesheuvel wrote:
> >>>> Since only LPAE capable CPUs may execute under virtualization, and
> >>>> considering that LPAE capable CPUs are guaranteed to have cache
> >>>> coherent page table walkers (per the architecture), let's only
> >>>> perform this cache maintenance on non-LPAE cores.
> >>>
> >>> That statement doesn't stack up.  What about Cortex A15, which is a
> >>> 32-bit core with LPAE support?  TI Keystone2 SoCs fall into this
> >>> category.
> >>
> >> As already documented in dcadda146f4fd25a732382747f306465d337cda6
> >> ("arm/kvm: excise redundant cache maintenance"):
> >>
> >> <quote>
> >> Per ARM DDI 0406C.c, section B1.7 ("The Virtualization Extensions"), the
> >> virtualization extensions mandate the multiprocessing extensions.
> >>
> >> Per ARM DDI 0406C.c, section B3.10.1 ("General TLB maintenance
> >> requirements"), as described in the sub-section titled "TLB maintenance
> >> operations and the memory order model", this maintenance is not required
> >> in the presence of the multiprocessing extensions.
> >> </quote>
> >>
> >> Furthermore, as per B1.6 ("The Large Physical Address Extension") from
> >> the same document:
> >>
> >> <quote>
> >> An implementation that includes the Large Physical Address Extension
> >> must implement the Multiprocessing Extensions and therefore cannot
> >> include the FCSE, see Use of the Fast Context Switch Extension on page
> >> AppxI-2475.
> >> </quote>
> >>
> >> So on a core like Cortex A15 where we have both MP, VE and LPAE, we
> >> should be able to assume a coherent page table walker.
> >>
> >
> > Thanks Marc
> >
> > I'll drop this into the patch system.
>
> Cool, it'd be useful to have this from an architecture compliance point
> of view.
>

As in, the avoidance of set/way ops invoked from the OS? I think there
are other places that would need to be fixed if that is what you are
after.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
