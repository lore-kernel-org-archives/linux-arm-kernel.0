Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D679DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A807020874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EjxnEi7i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="auggXh3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A807020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4Bp3oLbdmHlajoxF8So6YjT7RgoZcWUpTXbnKmxueE=; b=EjxnEi7iygToXy
	XMy+vWwJhpBCGR5JRYQr573dET+E0EAw9qdc7kVPGXIQpJeKYNJcOz1uyF1/STL9IZ62Ehs7GGcAv
	/7GoIZNs/V27VOR9jL0kJRua1S8B/dScH9wQ4YkWNOY8Sysbi4VRRUB4/5B3gO7fcM7BJFrrzlL4Q
	btHXwTzjwRWcOFQE/r+xK8KMGVn+B6gTN+X1avM4DdxBeJTbkVRiNVNEJV2C5zF+q62fjTacKKYDx
	ahafV5OlyVUpXFaZbX6hpPWq3LdUHnPNLe5c65b0f867PKl0Ecz75dUkJlY+nScKlqTq9tjTrk9tY
	a4OvptlTaEfoTmRJDANg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghtTy-0008Ty-NV; Fri, 11 Jan 2019 09:52:06 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghtTu-0008TQ-RS
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:52:04 +0000
Received: by mail-vs1-xe41.google.com with SMTP id x28so8815240vsh.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 01:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6TXYG0bRygv37lt/cmIuFfZcnUSM355T9n2ZJXUOXPE=;
 b=auggXh3eSLNCvw2+OMx6WOeqof/9eRBvDRe3sNrVnKSytLC0n6jddw1GRRW8kAJCfQ
 L1Ci0N/vlIQYbtnCKmcNG5j3YLRFH2ImiXEaRx5OfQIM0yezxdHi/J52vsbCNtAuMB9b
 eZVb5nz9KMlhsBXCglVo/6kBsUM2tESEqqyzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6TXYG0bRygv37lt/cmIuFfZcnUSM355T9n2ZJXUOXPE=;
 b=abFMep0JO4gft9+Jjv9l6C9qofgZAW8+Gkifq/XzPkJC1L9o/IiJYdXP+sWagzqxBy
 JfD1VBLTUIm6Vppn2mj6VoEu9U95IfYxLgsCokhlsWzgAtNgypkOtsSCtHax7XVtylIl
 izWLi1w8foRJW/Qol3djr3ZDqCC8u6mi5SWRjB/ocv8GW2a9KNrBfGxdp5gCISaR+mqh
 hjh+HZz6KoDglPBLHK1beV9LSjQrNobbTp8Hvv5B4qfk0UAvlErQM8TotoMrvfloDs2Y
 Jcq89hgjQgUu4IxzNx8FE+lwZnRQRn5zdeu4diX5erRfrM+socnK9/tCVMBItr3dfoo/
 AcOQ==
X-Gm-Message-State: AJcUukcnSK9eWcnuFWKmu3w2vyYyX14LZTePwq9ISfDB4F7r8DpHd+En
 woXC5Um+XHx6UWbyu0maiInxwbm+nbIefg8XPk0RdA==
X-Google-Smtp-Source: ALg8bN4PF1Axmm3q/vaJb9HeicK/Bp4AvzPVk8dEcLkvR/I3xClXHtXXlYhNB94xF29IhkuBpad6GwZa0XRnf2JuXBQ=
X-Received: by 2002:a67:2045:: with SMTP id g66mr5711533vsg.180.1547200321471; 
 Fri, 11 Jan 2019 01:52:01 -0800 (PST)
MIME-Version: 1.0
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
 <1547123097-16431-3-git-send-email-sumit.garg@linaro.org>
 <20190110141856.p3evqyf34py74gkg@holly.lan>
 <CAFA6WYPHmtY4N9ruGLZ70FNeiDCbQE-fs+EP2px-S+GEj2nPTw@mail.gmail.com>
 <20190111093902.hfxb67txjhhlegzu@holly.lan>
In-Reply-To: <20190111093902.hfxb67txjhhlegzu@holly.lan>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 11 Jan 2019 15:21:50 +0530
Message-ID: <CAFA6WYNp5ve=xZ1bQL+HUGK4Pz7dpzMzWy_fuS0_q8NHaZWL4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tee: optee: add TEE bus device enumeration support
To: Daniel Thompson <daniel.thompson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_015202_897862_932EF20C 
X-CRM114-Status: GOOD (  18.88  )
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
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 11 Jan 2019 at 15:09, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jan 11, 2019 at 12:52:19PM +0530, Sumit Garg wrote:
> > On Thu, 10 Jan 2019 at 19:49, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > > +static int get_devices(struct tee_context *ctx, u32 session,
> > > > +                    struct tee_shm *device_uuid, u32 *shm_size)
> > >
> > > Missing const on device_uuid?
> > >
> >
> > I don't think we should have a const for device_uuid here as this is
> > shared memory struct pointer which is dynamically allocated and used
> > to fetch device UUIDs.
>
> Agree. Perhaps device_uuid is misnamed though (part of the reason I
> misread this is that it is singular so I though it was a single UUID
> travelling into the TZ).
>

Will rename it to device_shm instead.

> > > > +     rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> > > > +     if (rc < 0)
> > > > +             goto out_shm;
> > > > +
> > > > +     device_uuid = tee_shm_get_va(device_shm, 0);
> > > > +     if (IS_ERR(device_uuid)) {
> > > > +             pr_err("tee_shm_get_va failed\n");
> > > > +             rc = PTR_ERR(device_uuid);
> > > > +             goto out_shm;
> > > > +     }
> > > > +
> > > > +     while (idx < shm_size / sizeof(uuid_t)) {
> > >
> > > This is a very uncommon way to write a for loop ;-).
> > >
> >
> > Ok, will add "num_devices" variable.
>
> num_devices might add readability but that is not what I meant.
>
> The most idiomatic way to write somthing that loops for every valid index
> value is:
>
>         for (i=0; i < limit; i++)
>
> You wrote it like this:
>
>         int idx=0;
>
>         /* lots of code between initializer and first use */
>
>         while (idx < limit) {
>                 /* more code */
>                 idx++;
>         }
>
> Sure, they are equivalent but the idiomatic form is easier to read.
>

Oh okay, will use "for" loop instead.

-Sumit

>
> Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
