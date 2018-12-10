Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C10EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:31:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250692084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i9a4EoKQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDaewSKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250692084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7sEgNtU9gFYO3FSHgIKM+63JhnhTAgUlI2dLL8Bibds=; b=i9a4EoKQGVeXYO
	MsPyPcclTbEvofnuWi3TaZfozE1li5MO6evFuyLyhu95FuavZ3syrzVNNHSWp61qmcu+ZlWe1qyJz
	YJrarxvqRDspF+Hst8EVeTOC11ezZ4QcdrGv0tsWL3to6MP+VHgP07S5vavLCrAovLCINszXVEJQb
	Zfj6ixf+pSdPJXPj8clB+A2//R0N2EkjQKR1ClqtIlZAreUrXhRcoeesH1DeqwdaAs23LfxJJ4OUH
	hXyKU9/HrOw1FJWobeRTMOGqYhRUQ0bf4IJpGLjvi6F0AazQ4LnMKbrdkukJJ+z5v9aTuJZnRDOvp
	9Hj3UyCrDYAj5goJ9Low==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSCw-0001Ox-T2; Mon, 10 Dec 2018 20:31:14 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSCu-0001He-8n
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:31:13 +0000
Received: by mail-it1-x143.google.com with SMTP id i145so2594ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DWWG/MaVYejX2z7UMg0zwENDAEhBGmC4n2EmlKH3O+o=;
 b=sDaewSKeeESJ6skifbdFd5PBWEwd5GI4zHvxblf9JmHYhKVHZ346hh2c+eHVc5l1iO
 Y5LpYUJOVjU7lOixoSN23oQa16urIdeJVRRfPlUIvO+lHru6IpyjJEbsQhGlLtn5gZXV
 nRWkQ4YxIs8eXZnjxxUZQq9qUaTAla9WwD/UrsznWMOoR6wob6I/trIJSuHAvWc5mEWM
 M5Waj0DPf0HdBn+Z5psEDct9V8Vo5xYF5hcAq1RtlPq/iJ3Y4hvzqTmjprSOjxW94ime
 Yil8W+nH+P8xXvtk7iOXktYzIhjxzIc72FlEHGbIOzDePPb3inrn/F/7qe+meUeHtsi0
 6B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DWWG/MaVYejX2z7UMg0zwENDAEhBGmC4n2EmlKH3O+o=;
 b=fV8Igm2RrRlsPXMTiXTKguxtnuipehn8JwqAzT4c9vHdnMrO3r34HeYG8bLZ8wvCET
 5zEL9nzUMCiauC4sejr0GAjM+wOmjaW/NEhZn64w7N7rVW7iHD3Nn7fdVnxK8WOhOMfZ
 IguEw4hd/NqxZhfsTBjjH88fELV9wfBHPheGra0T5eLdWJsCeNwcOX1Ms3aSbueC9nS+
 MS3++rw5AubDHoTMVZ0rEWvnlqrjexbWL45J4Y/roOgpwDXR4OsWp3rMY3hEbQh3Wkqx
 9JgTpN/GqY6Bo63kk2TU3ugLaPF0pxfcMReNcvp63NHqoiRjLi718mmnlD7UciqZAFp9
 6xlg==
X-Gm-Message-State: AA+aEWaBoX0mijRF1RIQtg/jfMZGp6uEieOnR5NHcpuaV8DwIOIa7FWB
 UqqUi4YnsSB++RqcIV4RYlEcBABBofQ7nLg1aKU=
X-Google-Smtp-Source: AFSGD/WQaLNrYbI7B/6K1AwSIJNES2fOzLfgDqoVuv8XqEEQrt2RftyefzlJXQUBrYZ1spQf/1CieQ1yAN4l9Cw2wFw=
X-Received: by 2002:a24:fd09:: with SMTP id m9mr12480955ith.81.1544473860382; 
 Mon, 10 Dec 2018 12:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
 <20181207113245.GA30719@ulmo>
 <CABb+yY2jVmzxFR7iqSyMMyE+XZtyHrAPAxM_KMEa7c2zzpSwCA@mail.gmail.com>
 <20181210095229.GA15154@ulmo>
In-Reply-To: <20181210095229.GA15154@ulmo>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 11 Dec 2018 02:00:48 +0530
Message-ID: <CABb+yY2fNYYjh4cY69M5p0Yc-Z-wusDMQhjTgqb1Ag1QEm=T9Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_123112_332025_76F294EE 
X-CRM114-Status: GOOD (  24.89  )
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
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 3:22 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Sat, Dec 08, 2018 at 11:39:05AM +0530, Jassi Brar wrote:
> > On Fri, Dec 7, 2018 at 5:02 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> > >
> > >
> > > Secondly, I don't understand why you think this is an emulated console.
> > >
> > It is emulated/virtual because Linux doesn't put characters on a
> > physical bus. The data is simply handed forward to a remote entity.
>
> Okay, I understand. However, from a kernel point of view there's no
> difference between the TCU and any physical UART. Once the data is
> handed to the TCU TX mailbox, it's out of control of the TCU driver.
> Whether there's a real UART behind that or some remote processor that
> reads the data isn't really relevant.
>
That way there can be no virtual/emulated device ?

> >
> > The 'flush' api is going to have no use other than implement
> > busy-waits. I am afraid people are simply going to take it easy and
> > copy the busy-waits from the test/verification codes.
> > "discouraging" seldom works because the developer comes with the
> > failproof excuse "the h/w doesn't provide any other way". Frankly I
> > would like to push back on such designs.
>
> I certainly approve of that stance.
>
> However, I'd like to reiterate that the TCU design does in fact support
> "another way". If you look at the mailbox driver implementation (in the
> drivers/mailbox/tegra-hsp.c driver), you'll see that it does support an
> interrupt driven mode. After you had reviewed Mikko's earliest proposal
> that was indeed implementing busy looping exclusively we both set out
> to properly implement interrupt support. This took quite a while to do
> because of some gaps in the documentation, but we eventually got it to
> work properly. And then it was discovered that it was all a waste of
> effort because the console driver couldn't make use of it anyway. Well,
> I should say "waste of effort" because I'm still happy that the proper
> implementation exists and we can use it under the right circumstances.
>
> So, at least in this particular case, it is not the hardware or firmware
> design that's flawed or was taking any shortcuts. It's really just the
> particular use-case of the console that doesn't allow us to make use of
> the right implementation, which is why we have to resort to the inferior
> method of busy-looping.
>
I am not complaining about the hardware, but the firmware.
It is essential we dump logs during early boot but the platform(Linux)
doesn't have access to serial port. All the firmware allows is 24bits
per transfer!! We could do better.
A smarter option could have been Linux simply placing characters in
the shmem ring-buffer, while the remote consuming (and then poisoning)
the ring buffer upon 'hint' from Linux.

-Jassi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
