Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058BFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 01:21:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9219520672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 01:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IOVajOp/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMf4f7Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9219520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EUVHmTQ6HzTJI0YTQOiLzfIeHlMoIrtjFGl6EGRgTKo=; b=IOVajOp/pGlDEb
	mwGoYDnimwmm0vvMxhY10C7TiX8+vNMO5INHnZ0Hwt5m1TAxdsblqGbFwhBByi4PYuXcuvkz5VMIV
	SbKJp2h/3z4IQW5B3kgwFboCvpEX5IRR5p/dZAfrUn8lXXAgjj7bOW33vibpCHZ7m4w4acHL8ZLeY
	5SiX1ZNBLOFXyndEY/TSejFu3RejiKbjSByiSh5pGi54u/UYSeRCULmoImkobJYrQnx7aWSRu8mL6
	V91p4uDkKo7aEh88cycE+FCYVhi2S7CVDRNJ12b+nRyKEGZSQmW8Ba+3l2KB1LFBgsDAdIjpkdiqZ
	3rFEFH1/tqPJkDkNyxxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVnmb-00032r-Vl; Sun, 09 Dec 2018 01:21:21 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVnmX-00032D-Qw
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 01:21:20 +0000
Received: by mail-it1-x143.google.com with SMTP id p197so12805396itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 17:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8fweFfOiWXJZCToiikC0muPi8UU5Iklksx69NPJZapU=;
 b=AMf4f7NrdFeLhT+tRip1khe24tfm6HZxBRDTlDbmOTmI7GN5kkFC/8J8iWfAL9aQla
 72wWO2q5DG3UjYCD8WEqr/TxF63O3iY/pm2vsYqh37AP6PkBlgIYm4nJFaWjb4KDK9vC
 fYYDR9HMW9l7FfefcRXs0Oww5DeI952Rq75otsm7wDrg3SjcUJM6FreVbaH4greQvdm8
 l/ie8GVpHgO/Zh3ppEACEIT9ymXC+vTRI8p3mNoPYW47Wlq/ijfdFCyCCkYhC7Wuvn6z
 qhPS4h2oeG2st2ud3diJc7eRODLwRl/hJIVd5dXPO2j0VBhqq5msOhwXkdxkzoeXcr5l
 yTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8fweFfOiWXJZCToiikC0muPi8UU5Iklksx69NPJZapU=;
 b=ZrxDQvwPuX5LA/I2E90nljcp3KyiGW5X4NeSPZFyKD7onYG+UwIzxZe8R3KBWp1TxR
 oGHk53MVhuOThy471dBFbWxGEmh+jfgDjC0TL/WF82nk1a//Vbys7uqvGS91DAlBjNv+
 QXS61RtI7V4ZIItwEsJxnZ0VmDvYQSOw8cTaHuaG2mJOzK1VGKGdA8FXBX6mbMdJbZA8
 ne2CfT43xqkCMrbQ9huWwIh5zqeib2tFzRSzaWMxqJFdUB+3Gu7LTGgGsFYCfD8J7Esa
 /qvMiXiS3tSw/eXQn1gR8NAJhmFk3mzWyGxlBAeUW0WUpPJmclEM2ff8x3pS+PhurRs7
 SeYQ==
X-Gm-Message-State: AA+aEWYfyPONZOXQwuARRZyVYaG31y0CuoGfENw+5ZmwwvYxCViWj2LF
 TZmFxxkTf1BEZ4dizm83um3wzx81EKZcIeGn7zA=
X-Google-Smtp-Source: AFSGD/XbdSP6LnWsae0wErl3isVJeF5WleaBPT3E326kGGb5vDEMF28ac5F3PaV1tNUGIjDkwd4lDXBYzidRWIlZpEA=
X-Received: by 2002:a02:2303:: with SMTP id u3mr6926281jau.42.1544318466356;
 Sat, 08 Dec 2018 17:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <4f7a4211-47ee-1114-0974-a3b402178106@kapsi.fi>
 <CABb+yY3_uWv1YVxXxjgygPemBZraCTAXNyXT9G4aTMZv1t7d0g@mail.gmail.com>
 <20181208085016.GA20795@kroah.com>
In-Reply-To: <20181208085016.GA20795@kroah.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 8 Dec 2018 19:20:55 -0600
Message-ID: <CABb+yY0QfSGei96RtCc4A2EYhYuKZDc5kM51s4vSureNgs_Xtw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_172117_957968_4B2C2485 
X-CRM114-Status: GOOD (  22.79  )
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
 Mikko Perttunen <cyndis@kapsi.fi>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org,
 jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com,
 Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 8, 2018 at 2:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 08, 2018 at 11:21:41AM +0530, Jassi Brar wrote:
> > On Fri, Dec 7, 2018 at 11:50 AM Mikko Perttunen <cyndis@kapsi.fi> wrote:
> > >
> > > On 07/12/2018 11.26, Jassi Brar wrote:
> > > >> I thought that I could also mitigate 2) by busy looping in the TCU driver,
> > > >> but it turns out that that doesn't work. The reason is that since we are
> > > >> in atomic context with all interrupts disabled, the mailbox won't ever
> > > >> consume any new characters, so the read pointer in the circular buffer
> > > >> won't increment, leaving me with no condition upon which to loop that
> > > >> would work.
> > > >>
> > > > So you want to be able to rely on an emulated console (running on a
> > > > totally different subsystem) to dump development-phase early-boot
> > > > logs? At the cost of legitimizing busy looping in atomic context - one
> > > > random driver messing up the api for ever. Maybe you could have the
> > > > ring buffer in some shmem and only pass the number of valid characters
> > > > in it, to the remote?
> > > >
> > >
> > > I would like to note that this is the one and only console interface
> > > that exists on these systems, for both development phase and production.
> > > Other UARTs are not externally accessible on the systems, or they are
> > > comparatively difficult to access as they aren't intended to be used as
> > > consoles in the system design.
> >
> > > The combination of hardware and firmware
> > > implementing the console is black box from software's point of view
> > > (similarly to any other UART HW). The interface has also been fixed at
> > > an early system design phase, as there are many operating systems
> > > running on these boards, each with their own drivers.
> > >
> > That is the saddest part - someone, who writes test cases for the h/w
> > team and with almost no knowledge of how OSes work, decides how the
> > firmware is going to work and calls it done. Then the Linux is left to
> > deal with the mess as we "can't do anything about it".
>
> That is totally normal, and is how hardware has been almost _always_
> been designed and implemented.  Nothing new here at all, it's just the
> life us kernel developers get used to very quickly as it is our job to
> make that hardware work and appear to userspace as something sane and
> universal.
>
Hardware yes, we can't really change much after the fact.
In this case the issue arises from the firmware - TCU's mailbox
protocol implementation. Which usually is just another image loaded
onto the remote master during cold-boot, and should actually be not
that hard to fix/change. Even if other OSes (really?) have adapted, a
pushback right now will help fix atleast the next version, otherwise
the api designer will never know what s/he is doing wrong.

Anyways, thanks for chiming in. I will pull the patchset.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
