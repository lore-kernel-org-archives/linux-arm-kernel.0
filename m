Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56FDC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A406621B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQG/TK/Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SuJwfuys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A406621B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHgHZnKZ/AHnxxfGkPWlCanI2HkX0f7KtLdw48dRnOo=; b=MQG/TK/ZNintlz
	0FUBDaCjjZwwKx9Ghhtfy/xZBQPzPibHgZWk1oy8t3Dryfrf8sJHkkTJ1huGK7onvXPr+YqkSa7HY
	pth2eluKAacJKNcTTRENWu19V6p6UASycu4/S4/E7jQb22uqBym5fLVm0b2AscYsY7JOyspeTRDR9
	H3GUpESPibw40N/vfPzgFbDFYKKVj5e5H2NHhwn+dFY1TPb011GZzXs4YfZtlaVEGxto111/7NUVw
	cmkQ8GoCA6BVGRQDDytX0XBaOk4oiIk/myOMpYQneuhPc3rJrJry0PZIKkIwtrzwUsh7rs6MchLNw
	ggFoGMXJpBHLsdJq4r6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtkoe-0002ln-4K; Wed, 13 Feb 2019 03:02:28 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtkoZ-0002kz-Uu
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 03:02:25 +0000
Received: by mail-ot1-x344.google.com with SMTP id i5so1511278oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 19:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PMU1/TQWCnMHC5lCOveXcIzdUREG8BzeB87IXaJ0KOE=;
 b=SuJwfuysL5A18uM8XkhFSpoUC6sFu7YwyqKGwB8V6xhIckAUCFxXlYmZHliwI/1+M9
 kpR3EVmH2YQgoTaz3syhgYb7fOG5EU7KP+77YblsaXfDgo/zpuLfFGr+Em4olflplBCB
 drpoRRwFZAd45owdGvzyz/GORgOmZK5KEQMPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PMU1/TQWCnMHC5lCOveXcIzdUREG8BzeB87IXaJ0KOE=;
 b=GQsfGT5PvtePLqX9gKsWK1mnk6qQ9ItK18lOkgBmvT9L042a/Q8zG+QfH+4n2TO5jC
 SlD+AKJGEmImvlY9l9YqarP6P57gaaojdsMnt+WVEa8325tXb2v0L2EV6FMTxWXL6Rpq
 UnbkM0NgIigqJi+07sweU2XDLdlKn+XwsNzcb4kYa4Qs81Znz9aocLoYft6WUHsAWOPt
 G4zdfGKBWz47LRo7kmjLDWu9mNyibXGjs2o0+SkVKyncK1Dju7EwfIgFvlaWKNVDUBUX
 3uE3TrJ3GoUcF5jn0zrj8TBbL2ZgUqP7xhHeVe5NTeHR+osoLuvY+R79FDSw8b0mZKky
 DPAg==
X-Gm-Message-State: AHQUAuY5Ccj96eD1+LtvyQCbEjNy3pbKnhqawv9KcYLFBa76NDB/8hcC
 oNwoe6PN2K8G8hE0tWkldp3NCVSvxCY=
X-Google-Smtp-Source: AHgI3IaTnpQbJxrSI7OkBxjuD2Uz31GRbOU4+ZYFKvYtDHDKtg7rcOehqUFVEN98Sg4z+blV+A7DHg==
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr555986oti.333.1550026942218;
 Tue, 12 Feb 2019 19:02:22 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com.
 [209.85.210.54])
 by smtp.gmail.com with ESMTPSA id v20sm6016479otk.77.2019.02.12.19.02.20
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 19:02:20 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id i20so1606561otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 19:02:20 -0800 (PST)
X-Received: by 2002:a9d:7e8b:: with SMTP id m11mr7286136otp.80.1550026939459; 
 Tue, 12 Feb 2019 19:02:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
 <4a1346315224850faf31345b577ce3a29c069f3a.camel@collabora.com>
In-Reply-To: <4a1346315224850faf31345b577ce3a29c069f3a.camel@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Feb 2019 12:02:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DE+T6KJ0TXcQUxLSnog5enQf5G0SVM+5t6f60VjcovFw@mail.gmail.com>
Message-ID: <CAAFQd5DE+T6KJ0TXcQUxLSnog5enQf5G0SVM+5t6f60VjcovFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] media: cedrus: Add H264 decoding support
To: Ezequiel Garcia <ezequiel@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_190224_023194_9EF44D7E 
X-CRM114-Status: GOOD (  29.71  )
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
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Maxime Ripard <maxime.ripard@bootlin.com>, jenskuske@gmail.com,
 linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 6:22 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hey Tomasz,
>
> On Tue, 2019-02-12 at 21:50 +0900, Tomasz Figa wrote:
> > Hi Maxime,
> >
> > On Mon, Feb 11, 2019 at 11:39 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > > Hi,
> > >
> > > Here is a new version of the H264 decoding support in the cedrus
> > > driver.
> >
> > Thanks for working on this. Please see my comments below.
> >
> > > As you might already know, the cedrus driver relies on the Request
> > > API, and is a reverse engineered driver for the video decoding engine
> > > found on the Allwinner SoCs.
> > >
> > > This work has been possible thanks to the work done by the people
> > > behind libvdpau-sunxi found here:
> > > https://github.com/linux-sunxi/libvdpau-sunxi/
> > >
> > > I've tested the various ABI using this gdb script:
> > > http://code.bulix.org/jl4se4-505620?raw
> > >
> > > And this test script:
> > > http://code.bulix.org/8zle4s-505623?raw
> > >
> > > The application compiled is quite trivial:
> > > http://code.bulix.org/e34zp8-505624?raw
> > >
> > > The output is:
> > > arm:    builds/arm-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > x86:    builds/x86-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > x64:    builds/x64-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > > arm64:  builds/arm64-test-v4l2-h264-structures
> > >         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> > >
> > > Let me know if there's any flaw using that test setup, or if you have
> > > any comments on the patches.
> > >
> > > Maxime
> > >
> > > Changes from v2:
> > >   - Simplified _cedrus_write_ref_list as suggested by Jernej
> > >   - Set whether the frame is used as reference using nal_ref_idc
> > >   - Respect chroma_format_idc
> > >   - Fixes for the scaling list and prediction tables
> > >   - Wrote the documentation for the flags
> > >   - Added a bunch of defines to the driver bit fields
> > >   - Reworded the controls and data format descriptions as suggested
> > >     by Hans
> > >   - Reworked the controls' structure field size to avoid padding
> > >   - Removed the long term reference flag
> >
> > This and...
> >
>
> Maxime has dropped this because of Ayaka's mail about long term references
> not making much sense in stateless decoders.

I haven't seen any argument confirming that thesis, though. I should
have kicked in earlier, sorry.

>
> I noticed that RK3399 TRM has a field to specify long term refs and
> so was wondering about this item as well.
>
> > >   - Reintroduced the neighbor info buffer
> > >   - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
> > >     one in the DPB
> >
> > these are used in our Rockchip VDEC driver.
> >
> > Could you elaborate on the reasons why they got removed?
> >
>
> If I understood correctly, there are two reference picture lists.
> P-frames will populate ref_pic_list0 and B-frames will populate both.
>
> According to this, v4l2_ctrl_h264_slice_param.ref_pic_list0 and .ref_pic_list1
> should be enough and ref_pic_list_p0/b0/b1 are not needed.
>
> What do you think?

The lists in v4l2_ctrl_h264_slice_param are expected to be past the
per-slice modification stage (which is quite complicated and better
done in userspace), while the ones in v4l2_ctrl_h264_decode_param just
in the original order. Rockchip VPU expects them in the original order
and does the modification in the hardware.

Best regards,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
