Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D62C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:16:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24706222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G7GhUJQ+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCjAGaCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24706222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8HWydaKXrNRbUuvIko9757B2kdRhYV+AwA6AFO31bas=; b=G7GhUJQ+VX2GrL
	6PlzIHnkU2BRGjnj7mdXRHwzs0FdyTgsXznjB7y+JIoLHVU11dkZbI1dtU3gXgPsp3gj2la7Y+awh
	hLnobEuwwZ9mq+u4CiBslnOgPTa8OM9Soz2l2X7YCMD0WtZS7ypiIXVmdUS5rEeDoNrBp4IxgkXzd
	JIdEwgL1tonhCPlyxjUVRLPX7s8GUVOZIzoLuH31Yr5cuqfk2NjIwtBGNl7r9k/NGE6Q9uSh3HZYF
	CmT+rRJ4kEgesykTTsmZDUDOc0J3fhexLhfafIvUB60d2o+ITrTPZVp1VSGct0jJpWUjjZ3qDIoXp
	oxtEmPowSGkZ4lvcevOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqeC-0001Yn-IP; Wed, 13 Feb 2019 09:16:04 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqe9-0001YE-44
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:16:02 +0000
Received: by mail-it1-x141.google.com with SMTP id h6so2791383itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DntHVpTk86mZ4RxeMFiGQk1194YRZlKjvISUFlssN7Y=;
 b=WCjAGaCfVSIyv6KGIf/jdBTArzbFepTnZn9gaKHrWUSKUwHMvcknwvMdQfkI/YZiwl
 /tFsTXELty/77dvJVn/2zVnOaaN5QWq6jJnqUtk+AMl5NAjbcpAQX9/1FQqMh6clPFFL
 lknlHW0gLd2IYaoqUzDLLDmouc1FkThMexVUakFk8iWR2uNLQqkjwJaXXh9cMmwD2dG+
 mo+PubStizzdlxUDJcm8e2po7TRELLYjNZl/7nhIk3KuBqNtHm6B+iGuqR21VsqKU2YW
 h1QJ456X6SdKCp5oZhH5/y8kY594ZnREllZNIMIfjJLfUWb6qSM43vJ88+n/Ud5pUOMk
 aRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DntHVpTk86mZ4RxeMFiGQk1194YRZlKjvISUFlssN7Y=;
 b=s8svA+tfmmJvtYLDhVVlL6qFBWCDZAZ9PPyIxZFS/oYQuZRn7QA2rYuuwxkc0fnzqi
 CjBGlLmc8j2DZy5MneijnRpxAq7DJChCJpwjE/r1ZqfsR0iOS659MMtVSm5QGDhhzM6m
 oKQfYcVr+DcR27MPBA1JiIuUarfTZ9dKE0LvLUjdfGSIYqKSx8G5y3fq7ch6BUp1vGJj
 Cnh/NLgclZMYjNTApfk6alagOfFau8ELbcsjWsZJ80vzyomHWafoztounaUBAQEiD+zP
 Cd7zZB86p3Rod1AnRAcUNBeWbUKfEHWfgrHmrJdoBs2TT5qnvPMPVZUDe2zcgSxlGUSq
 g07Q==
X-Gm-Message-State: AHQUAuaaBmlTMB2lgWF7rMjuIBrS7AuyLF7POjyRqPw+sx8p070g5RHJ
 o9yltFKrES8M2JQhoH8+PQ/olzauu/1hwEIrkXF4CQ==
X-Google-Smtp-Source: AHgI3IZ0sy/MMTW+tvRQh6Ifzi1w0+1YgP4p587cO9+mG+L8d4ryK+L7z5m/xRQuczTjFfV5y1WbOqBHhpxFKlx8Sck=
X-Received: by 2002:a24:710:: with SMTP id f16mr1439612itf.121.1550049359699; 
 Wed, 13 Feb 2019 01:15:59 -0800 (PST)
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
In-Reply-To: <f42aa98b-3d43-8f63-7636-9fa630a060e4@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 13 Feb 2019 10:15:45 +0100
Message-ID: <CAKv+Gu9XDneyLwidA+fGkpgJOb0owegYHNPJ2iLfqAovZox9GQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: lib: accelerate do_csum with NEON instruction
To: "huanglingyan (A)" <huanglingyan2@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_011601_171351_91E15A40 
X-CRM114-Status: GOOD (  29.37  )
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

On Wed, 13 Feb 2019 at 09:42, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
>
>
> On 2019/2/12 15:07, Ard Biesheuvel wrote:
> > On Tue, 12 Feb 2019 at 03:25, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
> >>
> >> On 2019/1/18 19:14, Ard Biesheuvel wrote:
> >>> On Fri, 18 Jan 2019 at 02:07, huanglingyan (A) <huanglingyan2@huawei.com> wrote:
> >>>> On 2019/1/17 0:46, Will Deacon wrote:
> >>>>> On Wed, Jan 09, 2019 at 10:03:05AM +0800, huanglingyan (A) wrote:
> >>>>>> On 2019/1/8 21:54, Will Deacon wrote:
> >>>>>>> [re-adding Ard and LAKML -- not sure why the headers are so munged]
> >>>>>>>
> >>>>>>> On Mon, Jan 07, 2019 at 10:38:55AM +0800, huanglingyan (A) wrote:
> >>>>>>>> On 2019/1/6 16:26, Ard Biesheuvel wrote:
> >>>>>>>>     Please change this into
> >>>>>>>>
> >>>>>>>>     if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) &&
> >>>>>>>>         len >= CSUM_NEON_THRESHOLD &&
> >>>>>>>>         may_use_simd()) {
> >>>>>>>>             kernel_neon_begin();
> >>>>>>>>             res = do_csum_neon(buff, len);
> >>>>>>>>             kernel_neon_end();
> >>>>>>>>         }
> >>>>>>>>
> >>>>>>>>     and drop the intermediate do_csum_arm()
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>         +               return do_csum_arm(buff, len);
> >>>>>>>>         +#endif  /* CONFIG_KERNEL_MODE_NEON */
> >>>>>>>>
> >>>>>>>>     No else? What happens if len < CSUM_NEON_THRESHOLD ?
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>         +#undef do_csum
> >>>>>>>>
> >>>>>>>>     Can we drop this?
> >>>>>>>>
> >>>>>>>> Using NEON instructions will bring some costs. The spending maybe introduced
> >>>>>>>> when reservering/restoring
> >>>>>>>> neon registers with kernel_neon_begin()/kernel_neon_end(). Therefore NEON code
> >>>>>>>> is Only used when
> >>>>>>>> the length exceeds CSUM_NEON_THRESHOLD. General do csum() codes in lib/
> >>>>>>>> checksum.c will be used in
> >>>>>>>> shorter length. To achieve this goal, I use the "#undef do_csum" in else clause
> >>>>>>>> to have the oppotunity to
> >>>>>>>> utilize the general codes.
> >>>>>>> I don't think that's how it works :/
> >>>>>>>
> >>>>>>> Before we get deeper into the implementation, please could you justify the
> >>>>>>> need for a CPU-optimised checksum implementation at all? I thought this was
> >>>>>>> usually offloaded to the NIC?
> >>>>>>>
> >>>>>>> Will
> >>>>>>>
> >>>>>>> .
> >>>>>> This problem is introduced when testing Intel x710 network card on my ARM server.
> >>>>>> Ip forward is set for ease of testing. Then send lots of packages to server by Tesgine
> >>>>>> machine and then receive.
> >>>>> In the marketing blurb, that card boasts:
> >>>>>
> >>>>>   `Tx/Rx IP, SCTP, TCP, and UDP checksum offloading (IPv4, IPv6) capabilities'
> >>>>>
> >>>>> so we shouldn't need to run this on the CPU. Again, I'm not keen to optimise
> >>>>> this given that it /really/ shouldn't be used on arm64 machines that care
> >>>>> about network performance.
> >>>>>
> >>>>> Will
> >>>>>
> >>>>> .
> >>>> Yeah, you are right. Checksum is usually done in network card which is told by
> >>>> someone familiar with NIC. However, it may be used in testing scenaries and
> >>>> some primary network cards. I think it's no harm to optimize this code while
> >>>> other ARCHs have their own optimized versions.
> >>> I disagree. If this code path is never exercised, we should not
> >>> include it. We can revisit this decision when there is a use case
> >>> where the checksumming performance is an actual bottleneck.
> >>>
> >>> .
> >> The mainstream network cards has an option to switch the csum pattern.
> >> Users can determine the one who calculate csum, hardware or software.
> >>
> >>         ethtool -K eth0 rx-checksum off
> >>         ethtool -K eth0 tx-checksum-ip-generic off
> >>
> >> What's more, there's some network features that may cause hardware
> >> checksum not work, like gso ( not so sure). Which means, the software
> >> checksum has its existing meaning.
> >>
> > This does not make any sense to me. Segmentation offload relies on the
> > hardware generating the actual packets, and I don't see how it would
> > be able to do that if it cannot generate the checksum as well.
> I test on my platform of  IP-forward scenery.  The network card has checksum capability.
> The hardware do checksum when gro feature is off. However, checksum is done by
> software when gro is on. In this sceney, do_csum function has 60% percentage of CPU load
> and the performance decreases 20% due to software checksum.
>
> The command I use is
>         ethtool -K eth0 gro off
>

But this is about IP forwarding, right? So GRO is enabled, which means
the packets are combined at the rx side. So does this mean the kernel
always recalculates the checksum in software in this case? Or only for
forwarded packets, where I would expect the outgoing interface to
recalculate the checksum if TX checksum offload is enabled.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
