Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3461C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:52:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59DE20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XhYtHE4m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMnhIfMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59DE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1DspH9fLfP5bxmS9dht8jg0DxfBAVQVr0faqZBZbmNg=; b=XhYtHE4mL7fK/U
	KzNiinqCqwZviwTJ+Ps8V2OCoCVzoK3zSrf0O5h2D3Giq2LVyMHH+W2IT9YYBvd08OyBt5QAqW3LV
	EOBqwtJ+skWWNCvq73tuy09rSRBemOpcSgnMan31W5DnT2/Hd0xxsaBcElDOzClpcGyR7wtOjyozj
	Wxwr8Ya02fyxQPkn+8GDi5bJTBxhDq84j6G/8jNPcdI6gTEqnJB6CAkYJtifqQjVm3jQsO0Z5Fpz4
	H7FpAZeFPBpf19EGiuBTSsFl9LwH0QbZFph6spgHKNpyV6Er2GpHE8kEtVPhuu8LnA12pbf/hF1pl
	3ElOLVA1DqDCfhqpGn/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVVX6-0007kt-Gl; Sat, 08 Dec 2018 05:52:08 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVVX2-0007Zh-Tr
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 05:52:06 +0000
Received: by mail-it1-x141.google.com with SMTP id p197so10447311itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JTEziPfCm1R6QWGgyOx4/3DCBgZUtBv0PGPmK0b33Ac=;
 b=fMnhIfMpNvS42QAiw4WHTxdsGeqr+wzWHTadX6SjaxyK1Y800HC7bDb3Fr/SGcFMOe
 HBokyolqtWajrraMivkDRirS6R79V+iDNJVzmpmfwNCXz95E7VBfjT+Q5CJ9Pmh7yVPC
 N0s09lx5S7yaQX+ukPOv/ZkHNJvbc4sOPCKamJiFPEB9dZOw5X3lZixTCrfHmh/H+AVu
 yaupmo4LWYjK5HDUesDrmkL3GyWGnCrWn7/Qcsd9JxCOw5WoZBjms1HSA21WdDLdPSiS
 nhbHANX+3PBnJE2Gl4cNIns5iusw/O87s+KnewiA2fiTOS678lFmPCJ7o/vAyI22ERQH
 cYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JTEziPfCm1R6QWGgyOx4/3DCBgZUtBv0PGPmK0b33Ac=;
 b=ARufp3/Pt8tMisSSPkGGpw/4sZ14ytCLaI3T4twSEnUdpc/z7hbNJ1ifoo1sZNHn6M
 x+V5LRzJJp107qQH+2JcFX7HApXpMo+KmTbylJiR8U+0yU53taj27O+4NdbT4dZuicUA
 Xw9z1Zm8HT8ZgGr5UKIjF1AnYJwL14girakoVpiikAy9pYvM6fN5FzTVA7WwHXPPGurH
 GjL4WVwqyz/oZfeFjidRlSaZs8T6+5GwjD6Qc0PvLuuvfd8+jPpMJjVSW9qrX6pHQq1v
 VDHuEPksk+UH+oAU36xB2uwevc03HAyDidaVeXggh1jHl5u0VtoJrWj2DjZyQyaPNeCo
 Nnbg==
X-Gm-Message-State: AA+aEWZr28rdayK+AsXdQpI3AW3zJDphAkYwrzqAyMMMsI3FaQP/Hxcq
 InxzsY7EaTFB7QhUGEbH/+dEzmnvWAR+etqY0Lg=
X-Google-Smtp-Source: AFSGD/X437k8KjiAMIJGQJiZph+mQJCH/2NS25RXYMml+/IuCRojwMwmKaM6AyMEt+z0ycoeBW5lWqlA0eOuHysDJAU=
X-Received: by 2002:a24:fd09:: with SMTP id m9mr4546047ith.81.1544248312920;
 Fri, 07 Dec 2018 21:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <4f7a4211-47ee-1114-0974-a3b402178106@kapsi.fi>
In-Reply-To: <4f7a4211-47ee-1114-0974-a3b402178106@kapsi.fi>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 8 Dec 2018 11:21:41 +0530
Message-ID: <CABb+yY3_uWv1YVxXxjgygPemBZraCTAXNyXT9G4aTMZv1t7d0g@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
To: Mikko Perttunen <cyndis@kapsi.fi>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_215205_013196_DAC804C3 
X-CRM114-Status: GOOD (  17.83  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org,
 jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com,
 Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 11:50 AM Mikko Perttunen <cyndis@kapsi.fi> wrote:
>
> On 07/12/2018 11.26, Jassi Brar wrote:
> >> I thought that I could also mitigate 2) by busy looping in the TCU driver,
> >> but it turns out that that doesn't work. The reason is that since we are
> >> in atomic context with all interrupts disabled, the mailbox won't ever
> >> consume any new characters, so the read pointer in the circular buffer
> >> won't increment, leaving me with no condition upon which to loop that
> >> would work.
> >>
> > So you want to be able to rely on an emulated console (running on a
> > totally different subsystem) to dump development-phase early-boot
> > logs? At the cost of legitimizing busy looping in atomic context - one
> > random driver messing up the api for ever. Maybe you could have the
> > ring buffer in some shmem and only pass the number of valid characters
> > in it, to the remote?
> >
>
> I would like to note that this is the one and only console interface
> that exists on these systems, for both development phase and production.
> Other UARTs are not externally accessible on the systems, or they are
> comparatively difficult to access as they aren't intended to be used as
> consoles in the system design.

> The combination of hardware and firmware
> implementing the console is black box from software's point of view
> (similarly to any other UART HW). The interface has also been fixed at
> an early system design phase, as there are many operating systems
> running on these boards, each with their own drivers.
>
That is the saddest part - someone, who writes test cases for the h/w
team and with almost no knowledge of how OSes work, decides how the
firmware is going to work and calls it done. Then the Linux is left to
deal with the mess as we "can't do anything about it".

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
