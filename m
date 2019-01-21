Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CF5C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3442084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sxGGmf3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3442084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IHOdz7lfoppZRKYy5YvtKgBCl1CF14FjPz62t1QJbsU=; b=sxGGmf3lnSbtR5
	WuJVjhpYlE1XOHogvq3YpEnUs/UlKvRC0MsOT2LmZq2Qg6s3Gi1agAls/kSfvMYarTakBrHMdVxq0
	Xy3/BMZoPnOKBzj0Uk0Eum1BHyPy6Od/OhEYPuET0YYu0T7wOpYQL7K6S3BLAOio0lrg0d8TkU32O
	vFS7q55PJlb8ZX9dVQz4riG9G02rWorB1wt2ozrf/hSz9nzZQJhpMR0g2ox9nebR6tAwFSJcEd0MH
	biaoOJDQtDoV+P/Zn9n80H1r+amhxjolm6RK1++TmcQescAk1YoYU4YVMtKKFpdqzicezjowwDGXP
	Qv1Nxlt9hrSPIH5W3BiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWLa-0003Uk-SH; Mon, 21 Jan 2019 09:58:26 +0000
Received: from mail-ed1-f65.google.com ([209.85.208.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWLN-0003CU-Lt
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:58:24 +0000
Received: by mail-ed1-f65.google.com with SMTP id x30so16106594edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 01:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2FK5jNlsShQJzHoLLKIat5FmMB5NfMzifMxo7fd5+GI=;
 b=ZiC2rm3QKTtlEyld5tet1JPR5FtlRVF6f/KH6pykuIAmCq+PJHKKKM/OEPYje5vYbc
 w/m0019cHFHzHVcjWMHITmO3dwOqgynKk4d5aihz/zToKvsVVUZNNthGUiJvw740thiB
 x/NG8ZAXlcXNePzlH4oQw+W65o1VHhuTV5ecq61x95qhBe5F+EqzSrUu1q/Jyd1CKwTx
 ENZVtbfzzLR+XUG/CFajlYrD/LfYOUh5tpj5L93fDlFGRUvi5yoREIwYVi/5ogy2ndSi
 ZpnzjkmPPWzBix/IbGiITcUlUh7H6mcRvC3duWP6+om0WWZn+E22I4cj+5VjHbH1Ajlu
 vXXA==
X-Gm-Message-State: AJcUukcu1x5wFuriUJVbyi85eGSjOFUqI5vpXnxkNqjNHyOsEuFShPmj
 /RQmrjXBu8OinDeyz3hK+gSUDcinbno=
X-Google-Smtp-Source: ALg8bN6kpiow5FiuXWtCin9YHgnJLUSb+0jqOg1S+52zYxuR1JqEyA3dDvvdKH8HAXzRnfqZhaoVBA==
X-Received: by 2002:a50:b1af:: with SMTP id m44mr25916600edd.47.1548064690971; 
 Mon, 21 Jan 2019 01:58:10 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com.
 [209.85.221.53])
 by smtp.gmail.com with ESMTPSA id n16-v6sm4764440eja.6.2019.01.21.01.58.09
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 01:58:10 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id r10so22482071wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 01:58:09 -0800 (PST)
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr28037486wru.177.1548064689599; 
 Mon, 21 Jan 2019 01:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
 <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
 <20190121095014.b6iq5dubfi7x2pi4@flea>
In-Reply-To: <20190121095014.b6iq5dubfi7x2pi4@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 21 Jan 2019 17:57:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
Message-ID: <CAGb2v66d0wM8Yt2uS4MMhU6PP02h8CKwKjinasO6jtZ4ue1CAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_015814_337486_948E0C1F 
X-CRM114-Status: GOOD (  25.21  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 5:50 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> I'm a bit late to the party, sorry for that.
>
> On Sat, Jan 12, 2019 at 09:56:11AM +0800, Chen-Yu Tsai wrote:
> > On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> > >
> > > A64 IR is compatible with A13, so add A64 compatible with A13 as a
> > > fallback.
> >
> > We ask people to add the SoC-specific compatible as a contigency,
> > in case things turn out to be not so "compatible".
> >
> > To be consistent with all the other SoCs and other peripherals,
> > unless you already spotted a "compatible" difference in the
> > hardware, i.e. the hardware isn't completely the same, this
> > patch isn't needed. On the other hand, if you did, please mention
> > the differences in the commit log.
>
> Even if we don't spot things, since we have the stable DT now, if we
> ever had that compatible in the DT from day 1, it's much easier to
> deal with.
>
> I'd really like to have that pattern for all the IPs even if we didn't
> spot any issue, since we can't really say that the datasheet are
> complete, and one can always make a mistake and overlook something.
>
> I'm fine with this version, and can apply it as is if we all agree.

I'm OK with having the fallback compatible. I'm just pointing out
that there are and will be a whole bunch of them, and we don't need
to document all of them unless we are actually doing something to
support them.

On the other hand, the compatible string situation for IR needs a
bit of cleaning up at the moment. Right now we have sun4i-a10 and
sun5i-a13. As Jernej pointed out, the A13's register definition is
different from A64 (or any other SoCs later than sun6i). So we need
someone with an A10s/A13 device that has IR to test it and see if
the driver or the manual is wrong, and we'd likely add a compatible
for the A20.

Also, the earlier SoCs (A10/sun5i/A20) have IR TX capability. This
was lost in A31, and also all of sun8i / sun50i. So we're going to
need to add an A31 compatible that all later platforms would need
to switch to.


Regards
ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
