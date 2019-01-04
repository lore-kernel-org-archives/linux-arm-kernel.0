Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B13C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:17:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FC2217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kfyG2Oe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FC2217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GP4a1FFFzWPI0HTNGILKyGzsINa9AhHOmUbeIswBfng=; b=kfyG2Oe5iryCig
	NjOf4x9FP7nPuKvHSXy0fg4IhRwA1YdsN2U2+378VauyyzkCSlX0HFggGAfx+aZkZsfZJsCbuqwuP
	xesSgjnroRPnbX6F1cSDZ2/s9904kelumod6BYC5gd9i7B9LMMXJf4cDorLi+ylFHGds/af62z2XP
	5XdIk+QM0NusaFuGUWetFxg6BLXjEaluRQYCgVlNQv6/hsLJS7cRqLzgyyHrdKS8gJRDYE4Z+wmjm
	JnfEIful+HGSVQujMH+ONLn7vL8pPNLe65zDTZvfMchM133bwRt6O7AumLdt75D/VCY8+HoFU6cld
	0LLUZWB3Fn+TICNFJq1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLbf-00029p-Jf; Fri, 04 Jan 2019 09:17:31 +0000
Received: from mail-vs1-f65.google.com ([209.85.217.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLbc-00029G-DJ
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 09:17:29 +0000
Received: by mail-vs1-f65.google.com with SMTP id h78so22301425vsi.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 01:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnaQvff+1MMNvxAriP2cdEUPk+alErVVISPfkgY60B8=;
 b=TRZTyFyuqwm8ekYSA4+1CMWXMCYJyIOM/XAzBj/EBQkRaO0kIi3BrSdJD80Khisr4b
 KZBjm2rZr+a/PUShYlnDD+2/u92ScKHPX/uMceRjIzIAwYE5g1VsLFQLKBMsaIdcXsH1
 8qSR4OD0RHHYGa1pBeJ5gyWKUhqT/iPXTn13WpnJQhRCjEuSGpm4tYlIigkVFFkrJeg0
 8PbCE1nPORakdl2d6TTz86LRsKcP57j7QZ7Nc4wY/B+yFnEcB74JeDzcJSPxmMxcJEYV
 8M+1Fg6yZzTkJK2p7VDOGzyQX+ijoM0btlFTurlJUtPE3TKvJ4h2hmpBT4NyRrK2P2dc
 ggRg==
X-Gm-Message-State: AA+aEWbd/gPk074lf2CfWsVR38Tnn9+FezpwtbdO33jqy5XhMeEORXWk
 /0lhBalTmN9dqQAlWphWWfaOJMwvL6oadNMK+IjsH87VMck=
X-Google-Smtp-Source: AFSGD/Un1yptL8aHgggs9K9IytFP1DH93NL2tkwBRhX+1rqy/WAy08s9BZthWFCXiiYC0YbGYN4LdXXb0ywqO0pf93g=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr21139120vsm.152.1546593446696; 
 Fri, 04 Jan 2019 01:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20190102095154.25839-1-horms+renesas@verge.net.au>
 <CAMuHMdU=aR8mSwd876LV=DG_vh6Bx45zxRTfMXuX3BQpy0M=ow@mail.gmail.com>
 <20190104085720.36ccxhtcbyyzgfrk@verge.net.au>
 <CAMuHMdWf=_-WZT9XUqPCZocNs1As3RJnXMYRYc05Y4td6SciFg@mail.gmail.com>
 <20190104091216.dgbnkxuuamgicysg@verge.net.au>
In-Reply-To: <20190104091216.dgbnkxuuamgicysg@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Jan 2019 10:17:15 +0100
Message-ID: <CAMuHMdWhCf-DSvVw7Z-uNpCJZ_kdGzf297OSFLZzc5TZvTNS3A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver
To: Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_011728_461025_6D9ECCF9 
X-CRM114-Status: GOOD (  21.58  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Simon,

On Fri, Jan 4, 2019 at 10:12 AM Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jan 04, 2019 at 10:01:13AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Jan 4, 2019 at 9:57 AM Simon Horman <horms@verge.net.au> wrote:
> > > On Wed, Jan 02, 2019 at 11:45:37AM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Jan 2, 2019 at 10:53 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> > > > > Enable the R-Car thermal driver as a built-in.
> > > > >
> > > > > This driver is used in conjunction with the R-Car V3M (r8a77970),
> > > > > E3 (r8a77990) and D3 (r8a77995) SoCs.
> > > >
> > > > > [v2] Enable as a built-in rather than a module as this seems
> > > > >      safer from the point of view of protecting equipment from
> > > > >      overheating.
> > > >
> > > > Shouldn't the above paragraph be moved below the ---?
> > >
> > > I have recently come to believe that its a matter of taste. And I think in
> > > this case it captures important information that is worthy of inclusion in
> > > the changelog.
> >
> > The rationale behind doing it this way could still be appended to the
> > first line of the body of the patch decription.
>
> Sorry, I'm having a little trouble parsing that. Do you mean that it could
> be appended to the body of the changelog at apply-time?

I mean the rationale could have been part of the patch description, i.e.
above the ---, e.g.:

    Subject: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver

    Enable the R-Car thermal driver as a built-in.
    Built-in seems safer than modular from the point of view of protecting
    equipment from overheating.

    This driver is used in conjunction with the R-Car V3M (r8a77970),
    E3 (r8a77990) and D3 (r8a77995) SoCs.

    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
    ---
    v2:
      - Switch from built-in to modular.

     arch/arm64/configs/defconfig | 1 +
     1 file changed, 1 insertion(+)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
