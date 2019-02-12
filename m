Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C42C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6032521773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q8feNMD7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTygBZyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6032521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9roqgQTJWOd88kJWISEcMDTmG2Sx1ov+bjC1Kz44ZrM=; b=Q8feNMD75Xr7tv
	AKRTnplnyRTGqqHVGCKWw2WKBkNEeWDqpzyZKwkumNcebSH+y6VC8iHuqnV8T5Yq8F7giH4RWyXs+
	h5OLuZX4ZeuoHtpCdmH2aArkW9c3XJLEGf4ppdJ5wFz5m5IF7YmDXevEyYrHZHBE3rtXSr2vkPfl7
	G04R0mtnZIAs4+z86cP5fb7g9Fq2DVS7N6EuARCpQ72yiORByWpC/GGWcS7sf3YYHZlCHzGSUIo1G
	3zuMS1eDQwEjteZcTG3JWNElSBv7zVAadiYELm+ZXEDa3icj/rLdXpUKL2j9E2hAV9zOmI4zK6til
	7pRQsQCAmvvBKsLvHgfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSAa-0000js-Rz; Tue, 12 Feb 2019 07:07:52 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSAY-0000jL-0m
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 07:07:51 +0000
Received: by mail-it1-x144.google.com with SMTP id z20so4989880itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 23:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yJSK7vyM21/4No0uZ8AwiACHLCifL2VdE7QHrfCrZXM=;
 b=gTygBZynREQjQpJ345uFIBoUr/kMlCCLVQlgmSXCSOUobePwbta8Ki7y34b2UkBAh4
 IJUsOVcU68RuIY2IMYz4iTia8ZEOuzBEhi+fKlBfdcibomcukoPkdE40YD+0kk9PCDiI
 0HYOAuf64riR+hDpfB6k7/fPRIj7G0KFq/HA40+JY2ade7f1n/giO9LBo+jp7A5En0+y
 qtjLYxEjtuENfP8gX6YgVLCjksQ6Sox/Bbr3YTmYJs1B7OOIUEv9fsSH/WSFortoZWTx
 MNdZq7jgzMNzrEqlCz1sDShUhCaKngft9Mf99zNSql2ZHm6yeXA3FByyDd79qXo97Hzx
 +XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJSK7vyM21/4No0uZ8AwiACHLCifL2VdE7QHrfCrZXM=;
 b=FOWqRMQOkO0eUN9/iM0qLzImPhjO+8HG98Vuj2U2Jco9557wu7h7ag/Xcl/EQjS5Sa
 Q2IRBmaUJdxHHocaaBgEDt+4CDXPEPFJ058lQwnVx0hiaxuTWzMZ/bgpW792eJqGFRhS
 nVywnICW0mzC8a9+r1YjmQwMHfyPUyvnFBnKvI8dFNignkA70HF0hW18Rx0p8OYCdiMy
 XF2mOtY1pn84YIlt2ilFAawPdMblMXHjP49SaAK22XsSxnTr6VV7a1FsTYhcnO522FfP
 cdAK0vCHnpLxJ7zUGBjyL7XU2flzwzj7JJZyO8julkACX/EM1DwVBAbx8Jk4EdUaRlpI
 MaPw==
X-Gm-Message-State: AHQUAuZg/mdXL7XP8CMh7fLsbUduTS2ElEOVLa+qdsMyTUUPthogmk6Z
 eWTuU9Do9axy63hhWQAEyLdlQ8hpeexp2qutdaoL8uJ0
X-Google-Smtp-Source: AHgI3IZFOhN5i1bzfjSAeGWF6FtGZOytc3yGit6dQRWfFZWgvsuqh8L6YBNcc3LpLVjag1sG6KiklTKrieRNRlfFft8=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr1373731ioj.60.1549955268086;
 Mon, 11 Feb 2019 23:07:48 -0800 (PST)
MIME-Version: 1.0
References: <1546739729-17234-1-git-send-email-huanglingyan2@huawei.com>
 <CAKv+Gu_wsK1UNXSp=5Hvd7XCHKC3cVkYjTYHhvqM4Xt09A9iKg@mail.gmail.com>
 <9129b882-60f3-8046-0cb9-e0b2452a118d@huawei.com>
 <20190108135444.GB14476@fuggles.cambridge.arm.com>
 <cd5bb83e-bb0e-b348-5365-095c5fcd9648@huawei.com>
 <20190116164657.GA1910@brain-police>
 <58c28adf-a01a-bb36-4def-866375e93aac@huawei.com>
 <CAKv+Gu-MUDT-pAE4kwHbCsW2MSYBCDB3N1reRgeFL1EwiNQvxQ@mail.gmail.com>
 <d97f1ba1-1b73-1bde-cd8f-de55115acd9e@huawei.com>
In-Reply-To: <d97f1ba1-1b73-1bde-cd8f-de55115acd9e@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Feb 2019 08:07:35 +0100
Message-ID: <CAKv+Gu_jzU934k=SU-0bpF7NrqZ-KW2u_G3a+WDkxs+O6bzQow@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_230750_060225_FE287C28 
X-CRM114-Status: GOOD (  25.61  )
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

On Tue, 12 Feb 2019 at 03:25, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>
>
> On 2019/1/18 19:14, Ard Biesheuvel wrote:
> > On Fri, 18 Jan 2019 at 02:07, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
> >>
> >> On 2019/1/17 0:46, Will Deacon wrote:
> >>> On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
> >>>> On 2019/1/8 21:54, Will Deacon wrote:
> >>>>> [re-adding Ard and LAKML -- not sure why the headers are so munged]
> >>>>>
> >>>>> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
> >>>>>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
> >>>>>>     Please change this into
> >>>>>>
> >>>>>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> >>>>>>         len >= CSUM_NEON_THRESHOLD &&
> >>>>>>         may_use_simd()) {
> >>>>>>             kernel_neon_begin();
> >>>>>>             res = do_csum_neon(buff, len);
> >>>>>>             kernel_neon_end();
> >>>>>>         }
> >>>>>>
> >>>>>>     and drop the intermediate do_csum_arm()
> >>>>>>
> >>>>>>
> >>>>>>         +               return do_csum_arm(buff, len);
> >>>>>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
> >>>>>>
> >>>>>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
> >>>>>>
> >>>>>>
> >>>>>>         +#undef do_csum
> >>>>>>
> >>>>>>     Can we drop this?
> >>>>>>
> >>>>>> Using NEON instructions will bring some costs. The spending maybe introduced
> >>>>>> when reservering/restoring
> >>>>>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
> >>>>>> is Only used when
> >>>>>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
> >>>>>> checksum.c will be used in
> >>>>>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
> >>>>>> to have the oppotunity to
> >>>>>> utilize the general codes.
> >>>>> I don't think that's how it works :/
> >>>>>
> >>>>> Before we get deeper into the implementation, please could you justify the
> >>>>> need for a CPU-optimised checksum implementation at all? I thought this was
> >>>>> usually offloaded to the NIC?
> >>>>>
> >>>>> Will
> >>>>>
> >>>>> .
> >>>> This problem is introduced when testing Intel x710 network card on my ARM server.
> >>>> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
> >>>> machine and then receive.
> >>> In the marketing blurb, that card boasts:
> >>>
> >>>   `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'
> >>>
> >>> so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
> >>> this given that it /really/ shouldn't be used on arm64 machines that care
> >>> about network performance.
> >>>
> >>> Will
> >>>
> >>> .
> >> Yeah, you are right. Checksum is usually done in network card which is told by
> >> someone familiar with NIC. However, it may be used in testing scenaries and
> >> some primary network cards. I think it's no harm to optimize this code while
> >> other ARCHs have their own optimized versions.
> > I disagree. If this code path is never exercised, we should not
> > include it. We can revisit this decision when there is a use case
> > where the checksumming performance is an actual bottleneck.
> >
> > .
> The mainstream network cards has an option to switch the csum pattern.
> Users can determine the one who calculate csum, hardware or software.
>
>         ethtool -K eth0 rx-checksum off
>         ethtool -K eth0 tx-checksum-ip-generic off
>
> What's more, there's some network features that may cause hardware
> checksum not work, like gso ( not so sure). Which means, the software
> checksum has its existing meaning.
>

This does not make any sense to me. Segmentation offload relies on the
hardware generating the actual packets, and I don't see how it would
be able to do that if it cannot generate the checksum as well.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
