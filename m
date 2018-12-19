Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE217C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:31:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF412133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHVH6mET";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Yk5jHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF412133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XpkFZrs2wZMHyNqSEv9W+Q/TnnbMdyLKFRAild/yNDM=; b=eHVH6mETMZgKvB
	gUWPWxGQdyq4poHYL8OJgehgLnHqDhy0eCN8ejKNgCJ0F6QB5leq5e/nBX5ecCr+y9p4H4KwQdsy0
	s4jJ4yka7oVZIvQhTGbvh10d6iqzhDmDNbswgYMk+LhiI0XULRPq4gWhMkLvhdKcCsZR1KLArGRNp
	37XAZZHLPByiBboZZUJ/bPjvlx6rjFi6c9+/ClTzb9qZoKkLwr/NX8NBdcQoW4S0GkjUVkRwL0n/d
	+YTvL84LLGyQXnFMHUGq7AD4T1tmXoL4ump6rOlN+mzWZ7v7+FICZt5ZjysRYKbNax1b3P7f1eIli
	ehupNpgpJfBx8v+OVDbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbx3-0003c3-Kx; Wed, 19 Dec 2018 13:31:53 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbx0-0003b4-Pe
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 13:31:52 +0000
Received: by mail-ed1-x541.google.com with SMTP id b3so16986157ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S3GX7SkRDg0kmhYomF/yqDiLWJgcao3tWYo/YzqdOjs=;
 b=K2Yk5jHKIjLrv3TK2/FctPuPLpSoo/i0l024Ih0j4SgCh3air09fYZKRqxza48HqVV
 ZDtBMvUdEj8o8w9CPsl2RegdHQGHPuIYYkdNZIJBoXwvK/UxwJnLimbmNO//naI/9rrj
 ErK7Z6Si8+sMnD/YMyyHuDqJ1qTgtL1x+oW1bP8psc5ro+Sgxn84TarI0dNjg+WaKccQ
 H+1PCjw0wA1KddlumZ1+PaDlbP3z4/eFDSxYXovkdte7lclQn3WsTKaNZfqKAVS95SP1
 e87Hsc8f4N/caucciJVDxfTHu2z+nRUspHAlThDqjtTciL3eUs4wt4nRtXKeCYyYBJiU
 Ig1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S3GX7SkRDg0kmhYomF/yqDiLWJgcao3tWYo/YzqdOjs=;
 b=fPFH+Oo+veueRFNo3u2ua/vX4geEk9NCVMeMor4y5FXdnzbpKBOa3G9afJN4y9EzEd
 YW8YQfs+13czrD9CmbTSwSg63Y7U7bnzuxROLuZzXUY5jpVVguYOFss91n2ZOPVHXzAR
 g+iYN5IZOwbV0iOFNWxzo0R6Wqe7ESvAjEReoEsT3WKoVXmiiBTpqXcdUjP/wFouSnuu
 eGvkGmCvJxlBePIX06KWR9SkqdQa+qMW9IQ7QHejeitc4+TVjhkFZUv8QoMRPeravof2
 wArcgGx9kFhbOhU+E+LiUhgUe1II6woIiwYhu9ev/EmJF7Ztv6Cv+dq0UuuMHbZDMoqG
 M8iA==
X-Gm-Message-State: AA+aEWZE31Jyrd9ZWoaGA++ogfEITpZz3loYMIQIPfrCuu750/t1NftS
 6xUx5FrQDHfWGlX7koSYohULwOJEBhkAtMSFCRw=
X-Google-Smtp-Source: AFSGD/U9LhvI9CHqijITu5KSQlR5MfLR4tQY4oEEiPpEW+0idKmdQ9gy9M5t7Jz1utQku0jLzRjfsgGV3gK18xu+INQ=
X-Received: by 2002:a50:9106:: with SMTP id e6mr19157603eda.148.1545226298578; 
 Wed, 19 Dec 2018 05:31:38 -0800 (PST)
MIME-Version: 1.0
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
 <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
In-Reply-To: <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 19 Dec 2018 15:31:27 +0200
Message-ID: <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_053150_830121_617DA3EB 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: robh@kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 3:17 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
>
> On Wed, 2018-12-19 at 12:42 +0000, Marcel Ziswiler wrote:
> > Hi there
> >
> > I noticed that at least today's and yesterdays -next won't build with
> > the imx_v6_v7_defconfig giving the following error:
> >
> >   LD      arch/arm/boot/compressed/vmlinux
> > arch/arm/boot/compressed/head.o: In function `restart':
> > (.text+0xa8): undefined reference to `__hyp_stub_vectors'
> > (.text+0xac): undefined reference to `__hyp_stub_vectors'
> >
> > Has anybody seen that as well and knows what is going on?
>
> Hmm, works for me.
>
> Using linux-next, master branch. HEAD commit:
>
> commit 02fc169594e96f7c51c4f23114e12b7a18e85a0a (HEAD -> master, tag:
> next-20181219, origin/master, origin/HEAD)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Wed Dec 19 18:42:46 2018 +1100
>
>     Add linux-next specific files for 20181219
>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
>
> Using gcc version 7.3.0 (GCC).


On the other hand I'm getting this warning:

arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
/soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
bus
  also defined at arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
prerequisite 'spi_bus_bridge'


Maybe Rob can jump in?

thanks,
Daniel.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
