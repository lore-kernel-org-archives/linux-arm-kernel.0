Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1955CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:50:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98FA21720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HjZtZhC6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpP6v3CO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98FA21720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PgM6UOdbAph+Pr09oX/oSCwub+RjLPvTiD6n6XYGopI=; b=HjZtZhC6Dx9CIx
	X+JisBmgfOHDAES8k1++JMq6Sq7lbWir1DvWv0YoWEvVNgIkqgXX1Fld8aIFgZEua3iJgPvna7ACz
	M0aOfiHP5zlIDJieKBSlbi3Unzq/obldjcgBp1oKv5kG9Ivi/HhRRWQbLewUAEITcnonGibw1ffla
	cUJTP6QkQX14FFZJsbs3uSTBJ+MljacEnZ7vGUC6hNZV+I2XmKEbVNuJCxClEEzlAsIH/5uT+vREp
	leiWK1pOjz5gGCBOmvSWsrhRQTgWd+yp4ClX50tcbZC2douK0UcuR2ANqxLvtzd3Url/J6vqsLqUj
	nmuzE5U+JpJKPMMPw6Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9Zo-0004Ji-Tm; Wed, 26 Dec 2018 13:50:24 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9Zl-0004II-9N
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 13:50:22 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so20284169itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 05:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rpefWYxTp7K5+y32hWQHW+Yxgg8596jDt8IjeQS2Lqk=;
 b=fpP6v3COoYlw/6EUG8iSCrroLZuU0AFy683JPU7y+/A1Ebn10N4PMSziJfoZZly10k
 AZLDiBQ+2rb9bvHtooT/QrniD7nxa9w7F2RMZMnSDWstXLmRY8lc7vpXa3+HkhDHjW83
 WVm15pMZu7MkpEXzIXBqg52DVswYBTQQ6cPFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rpefWYxTp7K5+y32hWQHW+Yxgg8596jDt8IjeQS2Lqk=;
 b=Bb0J1BJ27AHirPD/PdY+hZEIFmGhZqOxnDLYTBKur+3srgvGhH0oGKP7x8TXX3Mlvu
 eiQ5qXnn5Mm5Ik+Ez/Ba0bRG0jqVtiCn7ePlCi4d7/maNrtz4mIN05DNafwZDoFHUv2Z
 twHipqIcV8eljwguFytoiCA3biqjyWMnqKM5VNFTPI5ljgsdAeVy5MDQXELW9CxcBPeA
 F0t0fNOU8UMDbWhqsKNeXheRQ1PAvamZLQrn8AXy/0vcVAGcwsiNFwFcAsq68RMMMjEm
 uMEj1EuJaz202XfhE5tTd0ZO5BexJQytN3tjn97mLreuJOFarDZHjPF1xqYmaRwzYIA8
 h+uA==
X-Gm-Message-State: AA+aEWb5gOJl7M4p3uJCJADFQi31UWqA2UlMUkEGz7xrRyJiCLqdkOdj
 RAQOoutY9XOKLBukyfb7VfuZVE3vRTOfcFNaN5Pfuw==
X-Google-Smtp-Source: AFSGD/V4qfZKQ3Fs601aUjLgQTZhbuWkbOlnZFz50z6f0mwRym+rcYpQfo+XD6WZnxI2SxfdoPoXr3oGnr8fsqYWLP8=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr14064037ith.158.1545832209400; 
 Wed, 26 Dec 2018 05:50:09 -0800 (PST)
MIME-Version: 1.0
References: <BLUPR13MB0289A32373545C7FBE3400CBDFBB0@BLUPR13MB0289.namprd13.prod.outlook.com>
 <CAKv+Gu_m353cv=Pf2cEUDLn8=5YTLjLDDO23n=P14nWXydQWDQ@mail.gmail.com>
 <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB02892B82F5EB663B2FECF20EDFB40@BLUPR13MB0289.namprd13.prod.outlook.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 26 Dec 2018 14:49:58 +0100
Message-ID: <CAKv+Gu-YTdQmhU_br4amNZYn12=6Amr7w=wP57DyNn7_axptCg@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in
 linear region
To: Yueyi Li <liyueyi@live.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_055021_405198_2E62797C 
X-CRM114-Status: GOOD (  14.95  )
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

On Tue, 25 Dec 2018 at 03:30, Yueyi Li <liyueyi@live.com> wrote:
>
> Hi Ard,
>
>
> On 2018/12/24 17:45, Ard Biesheuvel wrote:
> > Does the following change fix your issue as well?
> >
> > index 9b432d9fcada..9dcf0ff75a11 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -447,7 +447,7 @@ void __init arm64_memblock_init(void)
> >                   * memory spans, randomize the linear region as well.
> >                   */
> >                  if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
> > -                       range = range / ARM64_MEMSTART_ALIGN + 1;
> > +                       range /= ARM64_MEMSTART_ALIGN;
> >                          memstart_addr -= ARM64_MEMSTART_ALIGN *
> >                                           ((range * memstart_offset_seed) >> 16);
> >                  }
>
> Yes, it can fix this also. I just think modify the first *range*
> calculation would be easier to grasp, what do you think?
>

I don't think there is a difference, to be honest, but I will leave it
up to the maintainers to decide which approach they prefer.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
