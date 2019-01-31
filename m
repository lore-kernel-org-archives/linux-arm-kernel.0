Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40460C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5B82087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JgEPUKok";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcLLdT9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5B82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1qN9pe4/OH8ygzanxdZ3u+qoHNLIgl63SX3NdX4rhtg=; b=JgEPUKoksgd4q0
	AOHhLtj7NYgUdhdiyIHsiIisyytkFZ8N/LAeUwkHrhxegcn+qHVAhFEJCwibwwUMfJJvStbXXxLu6
	zM9kB9foKslrtQM3mZa/kbszbMQT80m/pRE2enZcd5e44drRe5Lghjh4BUihxCyo4WgVslMqMf4GA
	ZLaYW6nEGnEk6jjcxQftHHRlor2mbRyLi+nW2OEOhCMwteg3XtBtRDhRzJA5OB8CporQN1p95c59f
	vvceCAjsQdws0+8o6CtaPzGBJOJFwScfrv1lWiyNHu3QpUZwpf4uV1Ecf3aUDnCt+hfvjf4zjErhA
	HMHZzcl3f2Edfca6xyww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAnB-0002Ro-HU; Thu, 31 Jan 2019 11:46:01 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAn8-0002RT-8g
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:45:59 +0000
Received: by mail-io1-xd44.google.com with SMTP id m19so2391201ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Se37DkAzmG8Re0tNDcDE+NMRwds5kKz3h/p0nImakfw=;
 b=JcLLdT9UeG5kdQ/EJyO8Tpj2g2U95TjQgTMGfrYqRi5m2rbIL9RayN5Hj6WwCQ8BEc
 hfy5qTl+d1PbcToSaMIEyF0T76JMCWC5pD5bMgqrinJT/COdWqwuoc45EcPh295YOUdF
 Z6tlhB3a2H3v0EVkmuCaiakAOH3cge6nT8afg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Se37DkAzmG8Re0tNDcDE+NMRwds5kKz3h/p0nImakfw=;
 b=Sh3EF48K7uqdXdKbDmQkPTlfZLOfwHl1NT9KiiWLI6drqtOCMpO7CYzPxTTE/LBSS7
 dcbvL1ITMJpTSJyAatVHot1fP2Mlb4L0E9H5YNnDyeeMXEsJSClC4BFsRaYJ18DlyjN6
 fPoKLfp5kI4pK9TvmJdOa90MDfIvthbWhy5/qWFHm5QizoiPEJBDeDCDm856bokR0hGL
 dVWF/GgPhYCfxkRbs8ev4SHpSW8yOv/Ak+v7JSvSbS6zi5OWs9AXi8JK66SrzyH3Anox
 Awr4zlUP14N5fOBsGp+6tvRS+2boLxqOB2wlO/TUlb7K7ju7ia0Iov/R5NBCmj+GIZ5J
 sqpw==
X-Gm-Message-State: AHQUAuZoleYqDMg8wmenGhwr7yU4WLu1QsdMrfR86ljMgfuTCa+MgpWh
 MrOAH1HP5Rl+wv4KJADYTZuk92t/JmMc0JR6A2d6xScJ
X-Google-Smtp-Source: AHgI3IbEJom0danOQy04nS4FMlahrprO4Ol0x0BM230pTAjeZoiT4mU+Z/+5/1ECRkUXOa6UhvBkIPWUv2R6jhvC20g=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr4996154iob.170.1548935157104; 
 Thu, 31 Jan 2019 03:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
 <20181217150205.27981-2-ard.biesheuvel@linaro.org>
 <0ca1ffad-9588-dd85-9276-98644d089b6c@arm.com>
 <CAKv+Gu-q7KOMPWK+g+AAFZtJKSFAEHGMB1ANz3oDLd48UsPjTg@mail.gmail.com>
 <a4661531-259b-eb6a-1b2c-43b9bfa00ee0@arm.com>
In-Reply-To: <a4661531-259b-eb6a-1b2c-43b9bfa00ee0@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 31 Jan 2019 12:45:45 +0100
Message-ID: <CAKv+Gu80YOXDQTCudzP4pzYqfNR-GZ9XX6XB7L4_NukAoUqD4A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] arm64: kvm: expose sanitised cache type register
 to guest
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_034558_311600_115D679C 
X-CRM114-Status: GOOD (  16.53  )
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
Cc: Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 12:44, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 31/01/2019 11:24, Ard Biesheuvel wrote:
> > On Thu, 31 Jan 2019 at 12:22, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >>
> >> Hi Ard,
> >>
> >> On 17/12/2018 15:02, Ard Biesheuvel wrote:
> >>> We currently permit CPUs in the same system to deviate in the exact
> >>> topology of the caches, and we subsequently hide this fact from user
> >>> space by exposing a sanitised value of the cache type register CTR_EL0.
> >>>
> >>> However, guests running under KVM see the bare value of CTR_EL0, which
> >>> could potentially result in issues with, e.g., JITs or other pieces of
> >>> code that are sensitive to misreported cache line sizes.
> >>>
> >>> So let's start trapping cache ID instructions, and expose the sanitised
> >>> version of CTR_EL0 to guests. Note that CTR_EL0 is treated as an invariant
> >>> to KVM user space, so update that part as well.
> >>
> >> I'm a bit uneasy with this. We rely on the kernel to perform this
> >> sanitization for userspace when absolutely required, and this is so far
> >> the exception.
> >>
> >> If we start trapping it unconditionally, we're likely to introduce
> >> performance regressions on system where there is no need to perform any
> >> form of sanitization.
> >>
> >> Could we instead only do this if ARM64_MISMATCHED_CACHE_TYPE is set?
> >>
> >
> > I suppose. Note that the next patch relies on the trapping as well,
> > but we could enable that piece for only 32-bit guests.
>
> I think that'd be fine. 32bit has no EL0 access to this, so it shouldn't
> see any major hit (nor should it use S/W ops, but hey, odd fixes).
>
> Do you mind trying to have a go at that?
>

Not at all.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
