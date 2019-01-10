Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9969FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:43:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A25E20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PmkMfXnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A25E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KaGZTMjsx75rCVE2IlQAAfqxUjQ3T4fZSi+WRyONYNM=; b=PmkMfXnQNN2DoV
	JWtpGP3BIaE3p13ZV4dJCmX19YUBMj9LSVYKH/y/WH2z6qzkanLF6N07n/UH44cr0vC9RoHWyFUI1
	VE3KIT/7ZaKxxwkxTg1ySf1BoutaUJfk8TV2g94TWjXvRXhgv/RzLDvifmvcz45jVrlWM/WUj95Uj
	k25CothabTB8ZvV1GJiyYn4280DIUhvCd4elhnC7MxZ5GG6HhS5nEX+mj3M2QK3n6D7VpPfq6p4YW
	QxwSE8eeipAPZ2QB1MacNtXJFjDafxkuXLZWs8+7dWfWgHz42h72rsNHqC7iLbRXoXBhdntMiXtPi
	va1uOyR5e/AARnzS3Uzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgEY-0000X6-Qr; Thu, 10 Jan 2019 19:43:18 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgEU-0000We-T8
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 19:43:16 +0000
Received: by mail-ot1-f65.google.com with SMTP id n8so11022081otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 11:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sPgfEhYHHNB7vBHfMgCSXcBGQ+fLWI4pdLUmG15pdOo=;
 b=Nk0BM/OfeSIN29DUphpIh7orpgwrq8i6cCyJoGhPyN5k/kkwbb3AFimJBOoL4KPmKm
 PkO3BeLE1Gb8FtnlbCg/bygNXxGPDdiJfupfCQeUFDXeeBvjf3ShHbkW5K5sUKhoG1l1
 USyvMkjBXWxJMayZZlcINDSNBQs9fURrXFvn9LweRzVFqT48PuOeSlGlzul6p74onsOp
 6A1g3URDkXNGDsEbGiUovtPuYf1PrrZsXcdP4W7oVZPWDAWP8DfN7C3sh8cYro370MYY
 5mRTWd0sBUSSxwE9iXk8O+WVBJ+bM+XE0pUf4RF4/G5d5kCNPMN1xdcQXjvObKOVJThS
 04ig==
X-Gm-Message-State: AJcUukdJoO8YCalceewH40Ok062W4+6KxGD8IdqSbMqMYTJk1ilyTlAN
 MlkT3Yiz6GNTNbsfbtDFuNUMc9Ux
X-Google-Smtp-Source: ALg8bN5V16k2VNA2gpaq4xnBQrP/nT+E0VFCT7r74ybes7y8emiIid14wssT+iT8xTsWBoKT4dNuWA==
X-Received: by 2002:a9d:6552:: with SMTP id q18mr7851263otl.128.1547149393601; 
 Thu, 10 Jan 2019 11:43:13 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com.
 [209.85.210.43])
 by smtp.gmail.com with ESMTPSA id d66sm36152096oia.29.2019.01.10.11.43.12
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 11:43:13 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id t5so11039709otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 11:43:12 -0800 (PST)
X-Received: by 2002:a9d:2387:: with SMTP id t7mr7303236otb.68.1547149392367;
 Thu, 10 Jan 2019 11:43:12 -0800 (PST)
MIME-Version: 1.0
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
 <20181222075944.GA26155@osadl.at>
In-Reply-To: <20181222075944.GA26155@osadl.at>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 10 Jan 2019 13:43:01 -0600
X-Gmail-Original-Message-ID: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
Message-ID: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
To: Nicholas Mc Guire <der.herr@hofr.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_114314_940175_729D6F32 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 22, 2018 at 2:02 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> > On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > > devm_kstrdup() may return NULL if internal allocation failed, but
> > > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > > can be used here, which will only copy the reference.
> >
> > Is it really going to only copy the reference?  That would require that
> > is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> > of the kernel image.
> >
> I had tried to figure out what is RO and what not but was not
> able to determine that - from the discussion it seemed that the
> assumption of RO is correct though I did not ask if it would
> satisfy is_kernel_rodata() so that explains the incorrect assertion.
> see https://lkml.org/lkml/2018/12/6/42
> So then the only option is to check the return and cleanup
> on allocation failure as the orriginal patch proposed.

Thanks for the good discussion. I will drop the previous patch. But
would it also be good to just have "soc_dev_attr.machine = machine"
directly?

Regards,
Leo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
