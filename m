Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80C7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:22:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56412087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sKKxqQP7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bW4QzMDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56412087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+Dj60mMhEydBbIkcOzWq8aMLmfvfgYSkSObFcFvJdY=; b=sKKxqQP7jxNyjL
	gJUNUeOMIuHWIHnU5/6rl/1XgzUZxKR+Gq+4MHTJhR6OgClGB1DL9scZ7p/3R5yTW+zXJ/wQOnjTg
	p33R49B4AOd+7FZ3+PYNo2xSZvI0nCNQc2whTZ54nlPPzdmCaKvPCIESOo5FFlmOISXlpPM08OwuJ
	iybxyo5fd/OKo0pgjXyN8KGkn8fy6Gb1MdHXy43JafDAbpN2624qKwaKt49ODGdWaI/aB1OnKVjTF
	6vJe7mq9MBjHJj9DTyTFKFBGZZPyki8wo95K2haeZY+hZTLQ9hDosgPTTAo/Hg65q0cjDxUG6VjrD
	ulNtp3gJJa388eHoGtLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggu9H-0008VF-JG; Tue, 08 Jan 2019 16:22:39 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggu9E-0008Uj-BI
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:22:37 +0000
Received: by mail-it1-x143.google.com with SMTP id w18so7072400ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PTAdbkr7rQ0ihlDAyq3EixUD3j6N4rUQ844uXqKkLrg=;
 b=bW4QzMDOLEW5vW6WfwQ00/c1aSPTUhzJrc4lgfv2Mm/xzAx5ukgl0YJHPwvyNtrXgE
 udOVtGJWG9s8ZtxEaTxePHyMp4aJKszshXXs2KnL2DmvzWZQipCJMab4MKcU4VwJUULl
 TNWfwl5h6qrW5K0yfXk8BVwTKmi8QcSDqtGMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PTAdbkr7rQ0ihlDAyq3EixUD3j6N4rUQ844uXqKkLrg=;
 b=rz1DKE7J+OyoRHWSRNW8Qd/nsMooeZKvPdUdXZGV74V8xDLg8CGSVhJhGKKazUMVO7
 TOdfo0T9L//UyYNzoGJ658t6q7KhS2ea9oWQg0ds+E/vUuevyiV1bI88EBjRsadeo4fR
 CBJU7jiusg2ou0sSJ96eFUPtTpMix3K/eddd60mPqJqnMTcJFz2USRxssITRT2rK9qjw
 eYnYL0+75egXX63z17ELcabC5hekx4FUWy8Lr5CTXVivszVIL6qwPyakJ9iU+rU18gVv
 v0XIShn0kc6O8r4icyXdLDft2o+gwBAfxgljHXTdGguj7929KhTWmcmbE7V6pVs0f8PI
 Zz8w==
X-Gm-Message-State: AJcUukcURPZajmZJstURWmZlgg0lZ7hWx0n21IGes/oZH71+11NcM4Od
 dw082G0p1d6zwLsclWU3Kll2tjcXzELRPy8g814gYA==
X-Google-Smtp-Source: ALg8bN6rSYX86/Dc31ErCVkOOvg4OFI/q+A38WlWgYBT2gNvmvrzd9yQ8EWm64SagEyGd36X4U/IX5nYMwg2u9MMcnU=
X-Received: by 2002:a24:710:: with SMTP id f16mr1498898itf.121.1546964555199; 
 Tue, 08 Jan 2019 08:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20190108152829.11579-1-ard.biesheuvel@linaro.org>
 <20190108155321.7us32cbh6jgvwaw5@bivouac.eciton.net>
In-Reply-To: <20190108155321.7us32cbh6jgvwaw5@bivouac.eciton.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 8 Jan 2019 17:22:24 +0100
Message-ID: <CAKv+Gu9rAo3rFg+CC_vojbaSqguZQoCH1wZ3K91od6O9v7CCEQ@mail.gmail.com>
Subject: Re: [PATCH] efi: use 32-bit alignment for efi_guid_t
To: Leif Lindholm <leif.lindholm@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_082236_393285_C701AF4A 
X-CRM114-Status: GOOD (  22.90  )
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
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 linux-efi <linux-efi@vger.kernel.org>, Laszlo Ersek <lersek@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 8 Jan 2019 at 16:53, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
> On Tue, Jan 08, 2019 at 04:28:29PM +0100, Ard Biesheuvel wrote:
> > The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> > struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
> > this means that firmware services invoked by the kernel may assume that
> > efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
> > do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
> >
> > Note that the UEFI spec as well as some comments in the EDK2 code base
> > suggest that EFI_GUID should be 64-bit aligned, but this appears to be
> > a mistake, given that no code seems to exist that actually enforces that
> > or relies on it.
>
> Whereas code does exist that relies on it being 32-bit aligned...
>

Well, not entirely. Code exists that expects that the size of a struct
incorporating a efi_guid_t is not rounded up to 8 bytes.

In particular, there is

typedef struct {
    efi_guid_t guid;
    unsigned long table;
} efi_config_table_t;

and its EDK2 counterpart

typedef struct {
  ///
  /// The 128-bit GUID value that uniquely identifies the system
configuration table.
  ///
  EFI_GUID                          VendorGuid;
  ///
  /// A pointer to the table associated with VendorGuid.
  ///
  VOID                              *VendorTable;
} EFI_CONFIGURATION_TABLE;

neither of which are defined as packed structs, and which are used to
describe entries in the configuration table array referenced in the
UEFI system table, and so size matters. On 32-bit architectures, this
struct would change size if we increase the alignment of the
VendorGuid member, unless we turn it into a packed struct.

In any case, it seems entirely pointless to update the reference
implementation to enforce 64 bit alignment for EFI_GUID in general,
only to create a lots of issues like the above that will need to be
hunted down and fixed. So for all intents and purposes, this 64-bit
alignment of EFI_GUID in the UEFI spec can be ignored.

> > Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>,
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Reviewed-by: Leif Lindholm <leif.lindholm@linaro.org>
>

Thanks.

> > ---
> >  include/linux/efi.h | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 45ff763fba76..be08518c2553 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -48,7 +48,20 @@ typedef u16 efi_char16_t;          /* UNICODE character */
> >  typedef u64 efi_physical_addr_t;
> >  typedef void *efi_handle_t;
> >
> > -typedef guid_t efi_guid_t;
> > +/*
> > + * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
> > + * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
> > + * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
> > + * this means that firmware services invoked by the kernel may assume that
> > + * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
> > + * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
> > + *
> > + * Note that the UEFI spec as well as some comments in the EDK2 code base
> > + * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
> > + * a mistake, given that no code seems to exist that actually enforces that
> > + * or relies on it.
> > + */
> > +typedef guid_t efi_guid_t __aligned(__alignof__(u32));
> >
> >  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> >       GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> > --
> > 2.20.1
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
