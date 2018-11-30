Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF17CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:30:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B137720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dk4qF8ir";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYpPqkXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B137720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2qWhHYzGIcL4tsYAI3ggGoYh7bFMWGHTGW+utfxHayA=; b=dk4qF8irIhn0hC
	4rTZmgHiY3B+c2ogOUQib9Qq4gnms8E4onUivjQU2X1o+pOR2GKB7LduDCS99lfHLHBc42dXqMhD7
	K2SZ+GeyTRneGZqPzbPktulpPkUwUWMtYxCF1bHKcalSiWmpgH0oebhrMlicRzYjxsJnZGDI52ajm
	n73eNThHjgFW10anHn/7FrlpSMk0qXbm09SEcTrw5WytV0bWazJREzzZfdwgzYLWkTPayhjIoX+KF
	adEuiabM/stBK0ZCwQPopJX0Ay/L9dQRSDQxGPfsHwb2E8JfDO10ZwWvTcw2xS+eGvoZPs006SorJ
	WSvK0yDICSidRFc+JhiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSisL-0004av-SI; Fri, 30 Nov 2018 13:30:33 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSimc-0005Wj-Ns
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:25:17 +0000
Received: by mail-it1-x142.google.com with SMTP id x124so1978163itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aUwrGEaE794VcSyPe8DKD9ri2UW1S8KPy+ph3Jh9G6Y=;
 b=ZYpPqkXUHEqKZpjlf3cB2T4sqTynqqE3ACNyaCL4StTYsXDMiOBEix/SZjs++eW+mJ
 JvFfxLMjlZPCCpUsosOqY4sgQHPckz39onr1nMaxEGEkjaJX29yL1/esWaT/N5ys2IjJ
 pfBzMf/OqcRj38umL4AnBMLsxBUmBi3jsrMws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aUwrGEaE794VcSyPe8DKD9ri2UW1S8KPy+ph3Jh9G6Y=;
 b=N+TwNdO5JPWnbR2jZEWIoatl6juX8f9028TAfOfAzj8Ty6hcMn7HgPh/TIAYt/7CQE
 RprTepb9ecNYp9sUgUZNwpgYEaR2tlZDk9zMBlmVcWLCVcAipEO4oBjxWpn3gqaja81R
 rWO5kXz3YuR/4LimQSR2YV1TTjB9TJBsmwGdW9Qj9ZP3D9IgVA/r8jQtmwDNqrZpXLBX
 dhr6T6kmagvD0ESgzRtxMTutQysBqpF1tTUg83s9+jjtxatH3K2bOiPZtA++qmekBEar
 30RqV4lImHRhv9fDfewU2i5MoBwHe7AMEWr+ZIrNzEDfv3E0hS/8QVcpdO3IhI1A3FJ1
 yg2Q==
X-Gm-Message-State: AA+aEWbyjE7Fyk4uaDOjSUXrbELtVgfJ6+CSDT7hXbuC75QrjWf1vsUQ
 o5vJx1hNpOqhyblCXtrIF5bzusmEDZ6w0QNNRp15ltds
X-Google-Smtp-Source: AFSGD/Ul9MQGPUQu3Za/e3AvQ4isv+wWgFWZ3U0xt2URjz1b/2ujUZi2lpqOsp+i4HlppuhHy/jcVOT7eA2d82PUR04=
X-Received: by 2002:a24:710:: with SMTP id f16mr4562738itf.121.1543584267745; 
 Fri, 30 Nov 2018 05:24:27 -0800 (PST)
MIME-Version: 1.0
References: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
 <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
 <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
In-Reply-To: <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Nov 2018 14:24:16 +0100
Message-ID: <CAKv+Gu82Dzyc_WvhvVhdJe7n+rTF4LgwiRENofmgPHHND-gjVA@mail.gmail.com>
Subject: Re: Unexpected variation in SYS_ID_AA64MMFR0_EL1
To: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_052439_426061_7E452835 
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.w.gonzalez@free.fr,
 Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 at 14:23, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 30/11/2018 13:12, Ard Biesheuvel wrote:
> > On Fri, 30 Nov 2018 at 13:15, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> >>
> >> Hello,
> >>
> >> On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:
> >>
> >> [    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
> >> Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
> >>
> >> TGran16, [23:20]
> >>      Support for 16KB memory translation granule size:
> >>          0x1     Indicates that the 16KB granule is supported.
> >>
> >> Since this is a pr_warn, I get the feeling something is not quite right.
> >> Is there something to fix? Is it a problem that the big and little cores
> >> don't support exactly the same granule sizes?
> >>
> >
> > That looks like a false positive to me. We should only care about the
> > page size we are running with.
>
> Unless you run a VM, which is going to use 16K translation.

Good point.

> But this may be
> fine with the current kernels, where we emulate the SANITISED registers
> for the guests.
>
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
