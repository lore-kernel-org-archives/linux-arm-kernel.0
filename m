Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E60C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:03:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A9F2064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ga8Z/Yn+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdOECRj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A9F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7n7QiBfb8nZC8lIcC+XJ+T12373zTt9QrXUDXKl+Q4o=; b=ga8Z/Yn+Y5CgkA
	BnT2oLv113DX5CfgaHkuZwhSwExQgDfF2jENhq8zmsZVRrsSzVW4NeILAkrTlpqUetBJip7WhFVF5
	jigus8yNJaP7Asbb0CryP6CyXE3N8dLeAioVuD9NhzC8ZV6kqqbpi3hTm7hoNs6LXbOsXeRpxoGZ+
	AwR4pfz2RfEKftsx4sfkzLnaY9o5s6bxb0RilRdp01PtzLvyIwnc5DVSjis+GD8z7JYNdO+HJbw7v
	AWWSupfL/i2aZ/a2DofFSVtX/fHO1bs2/Hw3YA1CXhKj/u2yHwJ9erKKXd4TWAi2KlcynI+v4MfOz
	gx3UA8q+sHjqSkTlXwxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveqB-0005tF-Um; Mon, 18 Feb 2019 09:03:55 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveq2-0005oK-5v
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:03:48 +0000
Received: by mail-it1-x144.google.com with SMTP id r11so39467879itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 01:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=13tnwd1CUYTUqpZR9+HRFMpBLW/jCSuZDplAOqrgI1M=;
 b=VdOECRj/e9b/jpyMMNBgUBM7iAwLV8vgMMwJcq00uClifm12lC49Oh5IQfLJRSziSc
 i7ITYsJQrbc+iHOfK7KThlSTiZVpx4xpMsRAwK5VEpJWmj53eawXof34A0rBq47QQJ9X
 o+KMa5nmqZd2QeDILwp4/GuV80ys1Bazws2fEbEe/FTnQ5SZ04e0pX7Zeu/K8niXI7ta
 igodjejo6IVsfBW8Nb1Q0eaT4E8m/zTHZCpEHpPjw1gxwxB1SEO4BmmRyQoyI7XGr6jl
 HyTo1+6wR0Idv9Pyq60e5yWbozer05Aq0x2DtnHsvaZP+jkxn9oOhlMcAGO1ZPpxyLz7
 +lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=13tnwd1CUYTUqpZR9+HRFMpBLW/jCSuZDplAOqrgI1M=;
 b=DjJJz9+RokmYJKkR5EGkvi52wdFNCIo27+jKsM9/GIzT8zj5ZdmyNupLLotowonMZB
 9KFtH/x+IhYsHYQ3GZ3M4uP/Wuvo6NL5QSup8+Rrcvaf0WB/W0Ld8PoT9ij5O0cRX+w4
 fQbmVCXzYP51PV8p/i+oozP9TbN/GFiLKkY3GEbDtlEUdF/ci45y1lfwaK8uU3T1Q7S3
 XvFotJ5k74AAr+EZHhsRZ08AQ7L1VW2b0YWF3ESOKfF8iSmDpy0RDi9QXFs30+oRPT8T
 NctQqXJ2JwM10926yBTFGf0bi2H/Ws6luXj2d0CbAFojeza/xJRXMOlRrrNsC4jnPjpu
 EIlw==
X-Gm-Message-State: AHQUAuaD7abdPn/frHlITI7YeSS1JwWGfS8YW0VI8g1Xd6X1xzyKR/ra
 Dn8wkA3RY7hNZCLLXYNJSyIFCbKEPNy40vlf1Ioteg==
X-Google-Smtp-Source: AHgI3IYseAtLEmNMeRk/gul6tjRfD5tZHjXZXf71rRN2G3h76DBqNwBpCji3IoxHt2Cf9SCZztDkENd/yX12pejxNPQ=
X-Received: by 2002:a24:45dd:: with SMTP id c90mr5965214itd.71.1550480624727; 
 Mon, 18 Feb 2019 01:03:44 -0800 (PST)
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
 <CAKv+Gu_jzU934k=SU-0bpF7NrqZ-KW2u_G3a+WDkxs+O6bzQow@mail.gmail.com>
 <f42aa98b-3d43-8f63-7636-9fa630a060e4@huawei.com>
 <CAKv+Gu9XDneyLwidA+fGkpgJOb0owegYHNPJ2iLfqAovZox9GQ@mail.gmail.com>
 <CAKv+Gu-NuJCkeWqdK_pi4Vm7tyM4X=ZKqWdYg-m=Go2O6_fUrQ@mail.gmail.com>
 <f4b7b467-410c-9454-535e-f8a413297fa1@huawei.com>
 <5531d4f2-c4cd-822e-3c0f-b3cba6dc8e91@huawei.com>
In-Reply-To: <5531d4f2-c4cd-822e-3c0f-b3cba6dc8e91@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 18 Feb 2019 10:03:32 +0100
Message-ID: <CAKv+Gu_Jte_vUJfiXXWaGfBiBj8eAxZxMkLogbvBtWphv-cesA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_010346_258664_C047F295 
X-CRM114-Status: GOOD (  36.93  )
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 18 Feb 2019 at 09:49, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>
>
> On 2019/2/14 17:57, huanglingyan (A) wrote:
> > On 2019/2/14 1:55, Ard Biesheuvel wrote:
> >> (+ Ilias)
> >>
> >> On Wed, 13 Feb 2019 at 10:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>> On Wed, 13 Feb 2019 at 09:42, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
> >>>> On 2019/2/12 15:07, Ard Biesheuvel wrote:
> >>>>> On Tue, 12 Feb 2019 at 03:25, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
> >>>>>> On 2019/1/18 19:14, Ard Biesheuvel wrote:
> >>>>>>> On Fri, 18 Jan 2019 at 02:07, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
> >>>>>>>> On 2019/1/17 0:46, Will Deacon wrote:
> >>>>>>>>> On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
> >>>>>>>>>> On 2019/1/8 21:54, Will Deacon wrote:
> >>>>>>>>>>> [re-adding Ard and LAKML -- not sure why the headers are so munged]
> >>>>>>>>>>>
> >>>>>>>>>>> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
> >>>>>>>>>>>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
> >>>>>>>>>>>>     Please change this into
> >>>>>>>>>>>>
> >>>>>>>>>>>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> >>>>>>>>>>>>         len >= CSUM_NEON_THRESHOLD &&
> >>>>>>>>>>>>         may_use_simd()) {
> >>>>>>>>>>>>             kernel_neon_begin();
> >>>>>>>>>>>>             res = do_csum_neon(buff, len);
> >>>>>>>>>>>>             kernel_neon_end();
> >>>>>>>>>>>>         }
> >>>>>>>>>>>>
> >>>>>>>>>>>>     and drop the intermediate do_csum_arm()
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>         +               return do_csum_arm(buff, len);
> >>>>>>>>>>>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
> >>>>>>>>>>>>
> >>>>>>>>>>>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>         +#undef do_csum
> >>>>>>>>>>>>
> >>>>>>>>>>>>     Can we drop this?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Using NEON instructions will bring some costs. The spending maybe introduced
> >>>>>>>>>>>> when reservering/restoring
> >>>>>>>>>>>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
> >>>>>>>>>>>> is Only used when
> >>>>>>>>>>>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
> >>>>>>>>>>>> checksum.c will be used in
> >>>>>>>>>>>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
> >>>>>>>>>>>> to have the oppotunity to
> >>>>>>>>>>>> utilize the general codes.
> >>>>>>>>>>> I don't think that's how it works :/
> >>>>>>>>>>>
> >>>>>>>>>>> Before we get deeper into the implementation, please could you justify the
> >>>>>>>>>>> need for a CPU-optimised checksum implementation at all? I thought this was
> >>>>>>>>>>> usually offloaded to the NIC?
> >>>>>>>>>>>
> >>>>>>>>>>> Will
> >>>>>>>>>>>
> >>>>>>>>>>> .
> >>>>>>>>>> This problem is introduced when testing Intel x710 network card on my ARM server.
> >>>>>>>>>> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
> >>>>>>>>>> machine and then receive.
> >>>>>>>>> In the marketing blurb, that card boasts:
> >>>>>>>>>
> >>>>>>>>>   `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'
> >>>>>>>>>
> >>>>>>>>> so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
> >>>>>>>>> this given that it /really/ shouldn't be used on arm64 machines that care
> >>>>>>>>> about network performance.
> >>>>>>>>>
> >>>>>>>>> Will
> >>>>>>>>>
> >>>>>>>>> .
> >>>>>>>> Yeah, you are right. Checksum is usually done in network card which is told by
> >>>>>>>> someone familiar with NIC. However, it may be used in testing scenaries and
> >>>>>>>> some primary network cards. I think it's no harm to optimize this code while
> >>>>>>>> other ARCHs have their own optimized versions.
> >>>>>>> I disagree. If this code path is never exercised, we should not
> >>>>>>> include it. We can revisit this decision when there is a use case
> >>>>>>> where the checksumming performance is an actual bottleneck.
> >>>>>>>
> >>>>>>> .
> >>>>>> The mainstream network cards has an option to switch the csum pattern.
> >>>>>> Users can determine the one who calculate csum, hardware or software.
> >>>>>>
> >>>>>>         ethtool -K eth0 rx-checksum off
> >>>>>>         ethtool -K eth0 tx-checksum-ip-generic off
> >>>>>>
> >>>>>> What's more, there's some network features that may cause hardware
> >>>>>> checksum not work, like gso ( not so sure). Which means, the software
> >>>>>> checksum has its existing meaning.
> >>>>>>
> >>>>> This does not make any sense to me. Segmentation offload relies on the
> >>>>> hardware generating the actual packets, and I don't see how it would
> >>>>> be able to do that if it cannot generate the checksum as well.
> >>>> I test on my platform of  IP-forward scenery.  The network card has checksum capability.
> >>>> The hardware do checksum when gro feature is off. However, checksum is done by
> >>>> software when gro is on. In this sceney, do_csum function has 60% percentage of CPU load
> >>>> and the performance decreases 20% due to software checksum.
> >>>>
> >>>> The command I use is
> >>>>         ethtool -K eth0 gro off
> >>>>
> >>> But this is about IP forwarding, right? So GRO is enabled, which means
> >>> the packets are combined at the rx side. So does this mean the kernel
> >>> always recalculates the checksum in software in this case? Or only for
> >>> forwarded packets, where I would expect the outgoing interface to
> >>> recalculate the checksum if TX checksum offload is enabled.
> >> OK, after digging into this a bit more (with the help of Ilias -
> >> thanks!), I agree that there may be cases where we still rely on
> >> software IP checksumming even when using offload capable hardware. So
> >> I also agree that it makes sense to provide an optimized
> >> implementation for arm64.
> >>
> >> However, I am not yet convinced that a SIMD implementation is worth
> >> the hassle. I did some background reading [0] and came up with a
> >> scalar arm64 assembler implementation [1] that is almost as fast on
> >> Cortex-A57, and so I would like to get a feeling for how it performs
> >> on other micro-architectures. (Do note that the code has not been
> >> tested on big endian yet.)
> >>
> >> Lingyan, could you please compare the scalar performance with the NEON
> >> performance on your CPU? Thanks.
> > OK, I'll test it on my CPU. The experimental platform should be built again.
> > I will inform you as soon as I get the results.
> Below is the results tested on my platform. The performance of your patch is really nice.
> The 2nd colomn is general do_csum now in Linux. The 3rd is your patch. The 4th is
> neon realization. Last is neon realization without kernel_neon_begin/kernel_neon_end.
>
> 1000cycle  general(ns)     csum_ard(ns)    csum_neon(ns) csum_neon_no_kerbegin(ns)
>    64B:          75690                 40890                76710                  57440
>   256B:       171740                 54050               109640                 63730
>  1023B:      553220                105930               155630                93520
>  1024B:      554680                103500               148610                86890
>  1500B:      793810                134540               164510               104590
>  2048B:    1070880                167800               178700               119570
>  4095B:    2091000                299140               249580               189740
>  4096B:    2091610                296760               244310               183130
>
> The reason should be analyzed that data width of NEON instruction is twice than the
> general registers while performance is not. The kernel_neon_begin/end() seems to cost
> a lot. Other reasons may include complex code implementations due to lack of experience.
>

Thank you Lingyan, that is really helpful.

It is clear from these numbers that the overhead of using the SIMD
unit is not worth it for typical network packet sizes, so we should go
with a scalar implementation instead.

My implementation was transliterated from x86 assembly, so I am pretty
sure it is correct for little endian, but I haven't tested big endian
at all. I will try to find some time this week to test it properly,
and send it out as a patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
