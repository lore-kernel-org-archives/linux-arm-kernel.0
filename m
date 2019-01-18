Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D71C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66942086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JxCvu7oy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuKAD/JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66942086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jYM+fUlWHWZ42Pug1uelm/LLNHR3R+RDGKpuEECdfqM=; b=JxCvu7oy/4qm3A
	oSOkrLaEdXrME0ZMAPcoQR2OTucVo4U1qfxTS90hC8PydXbBoOk+wSN//PGu3CCvV950I30dRPxvk
	Hr7jeiuSftY4553JKkhO9j+/rADeEGCTdbhIO9I77c4I/sGrjdWHRMwatPaDBt9HpO4NiKBuPQ9ac
	Fog21KZUgOyttZf7bRC4zteFvGb1h3ZfOwlqFq1EIqXro1wIWp+9YGAKtaYcNdiZaIz+ENmBdB6hZ
	s6KsGCBD1HXa32AR13aZZFtKuOAhLaQo6a8ApXWdejj2DbMjJjNfBVp9DLlU3xiAdBghH+akBMb1a
	oY0ChebJFpZA0TEzUqNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkS6d-0005lP-Sx; Fri, 18 Jan 2019 11:14:35 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkS6a-0005kM-2M
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 11:14:33 +0000
Received: by mail-io1-xd2c.google.com with SMTP id l14so10376140ioj.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 03:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DcAfStfuZcPofxh2FfRFoFvAdVhRD66zw8c9C58eO8s=;
 b=EuKAD/JU6twG5yKxSGs3igAPZaESQB8N4F/BOLBsHBlfNjKt1KZev8md/li1xaeEeu
 KCzEM/zrl4kqYko+UultXrCEHbl0QNkNbNBa6YIaZc2LjNNWe6LIN5R6yrpiBTJL1sb9
 MYS5AsLBf5k1NqNV2vUOOK5cSBmT4T6IHk8+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DcAfStfuZcPofxh2FfRFoFvAdVhRD66zw8c9C58eO8s=;
 b=QrlWOp2l7qqMLLHvWtqwv5FmLxSFb4w7mC/RMyUWD6tg/tt7X3dJsFYBQIhxvb4DUm
 ALwT3VGwH1t0yaHZlfA4hBr+POGYnX6xnoMlmkwBquN7lentxIUY/kC8C/rQFSjQrkcc
 noyrpBZ/3e8w4Q7ZNxjVc3p5/w54ed8VQvBwEPygP+qsMH3YIkHqE+gy/3W7VK78U/es
 e/E+Yd8+riyQ+aHRNS3s4TAfC41se4u5uf3eAkz/bbkXrBBUM6OKRgPcbuHGT/UJHR1D
 ztIS4fQFw86WoyJnDHFbaGdSiYGn/MZTdlVxtmGb44kJfESbfbT2hylfrMLeAGgN8GIg
 DxRA==
X-Gm-Message-State: AJcUukf6p/HNLqEH7jEWsORXHh+iSh/PlTjgDTfGFGsERH+P3XQ/Yaqj
 fc9smpU/kbxcO2oUm2cZ2qU7jwITCAr8EoTGJBJbzg==
X-Google-Smtp-Source: ALg8bN5D2CN94XVaFT+bIFApe7dCOdbWsjfoA0drVLABOzPKi8LNdst0Ho+XeXgU21Zxfo4pmPmYIRFHjrGT5G7GhWU=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr10538445iop.60.1547810070966; 
 Fri, 18 Jan 2019 03:14:30 -0800 (PST)
MIME-Version: 1.0
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
 <20190116164657.GA1910@brain-police>
 <58c28adf-a01a-bb36-4def-866375e93aac@huawei.com>
In-Reply-To: <58c28adf-a01a-bb36-4def-866375e93aac@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 18 Jan 2019 12:14:20 +0100
Message-ID: <CAKv+Gu-MUDT-pAE4kwHbCsW2MSYBCDB3N1reRgeFL1EwiNQvxQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_031432_107578_5B15345C 
X-CRM114-Status: GOOD (  22.38  )
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
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 18 Jan 2019 at 02:07, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>
>
> On 2019/1/17 0:46, Will Deacon wrote:
> > On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
> >> On 2019/1/8 21:54, Will Deacon wrote:
> >>> [re-adding Ard and LAKML -- not sure why the headers are so munged]
> >>>
> >>> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
> >>>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
> >>>>     Please change this into
> >>>>
> >>>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> >>>>         len >= CSUM_NEON_THRESHOLD &&
> >>>>         may_use_simd()) {
> >>>>             kernel_neon_begin();
> >>>>             res = do_csum_neon(buff, len);
> >>>>             kernel_neon_end();
> >>>>         }
> >>>>
> >>>>     and drop the intermediate do_csum_arm()
> >>>>
> >>>>
> >>>>         +               return do_csum_arm(buff, len);
> >>>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
> >>>>
> >>>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
> >>>>
> >>>>
> >>>>         +#undef do_csum
> >>>>
> >>>>     Can we drop this?
> >>>>
> >>>> Using NEON instructions will bring some costs. The spending maybe introduced
> >>>> when reservering/restoring
> >>>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
> >>>> is Only used when
> >>>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
> >>>> checksum.c will be used in
> >>>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
> >>>> to have the oppotunity to
> >>>> utilize the general codes.
> >>> I don't think that's how it works :/
> >>>
> >>> Before we get deeper into the implementation, please could you justify the
> >>> need for a CPU-optimised checksum implementation at all? I thought this was
> >>> usually offloaded to the NIC?
> >>>
> >>> Will
> >>>
> >>> .
> >> This problem is introduced when testing Intel x710 network card on my ARM server.
> >> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
> >> machine and then receive.
> > In the marketing blurb, that card boasts:
> >
> >   `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'
> >
> > so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
> > this given that it /really/ shouldn't be used on arm64 machines that care
> > about network performance.
> >
> > Will
> >
> > .
> Yeah, you are right. Checksum is usually done in network card which is told by
> someone familiar with NIC. However, it may be used in testing scenaries and
> some primary network cards. I think it's no harm to optimize this code while
> other ARCHs have their own optimized versions.
> >
>

I disagree. If this code path is never exercised, we should not
include it. We can revisit this decision when there is a use case
where the checksumming performance is an actual bottleneck.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
