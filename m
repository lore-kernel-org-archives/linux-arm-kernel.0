Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E2AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:48:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B182146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rF4AjJRW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFWSloVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B182146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WOz5eEMuT2Kl27q7r4tECFXotrKnRendEqXKdJz26Nw=; b=rF4AjJRWkfJCIM
	Lf+/YIBKHKKyPNXWGsrypXfcJH0WTXR1fg4FFazFmLDewIoh8/55MDTPTB6fq4PbetdDtnX3ezG1x
	HKwYh52/x5U3EYZ5ERBVZKiOaB6DAMJAr6rTM4rRx4joZ/kGNCSsAoDPtcYKR0GFb9Jud0WpoU1vS
	juWPs3y7EoCVq3FIQK4CMtJIHdeCYRXKrqZlBKOYA73tY4W3hutDgfCOmAC2l9jWaQc6mRzYHL1Vb
	vB8KmQx6iQJIW1odBuMLYlkVZ2sR0thhmg5c1ukSJ9gPZnjcuOIvtLEotsceo2qu2KCbMLhlx+2v4
	R+PPL8atvrIBmx511HzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwBNH-0004hx-Df; Tue, 19 Feb 2019 19:48:15 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwBNE-0004hb-AF
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 19:48:13 +0000
Received: by mail-wr1-x443.google.com with SMTP id f14so23408041wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dl7Pg/vEUTpn3GkKhp+pyC/6uR7V/3Y08Va22umnMaY=;
 b=eFWSloVyuvY7uTVOeNKDCG/u6tcCm/QwnJ7tPMOZQB3AUchwWrAo8twkq0jYfeGGuC
 4jm+cLkUnOVGt7yTmOSDXn4YAriRd4HbGTnqE8ZXGzIlXzZ2sUt049ya7VYtk6T5F6Gt
 mlxLPGCn+wf4F/RHvjxbzmusVkRJITakbffNVtvjOwoA0GMxqhgPy9ErwlhLL/fd0yWW
 YfZ2q7VXtusouAVd1dMV8++9pMg5LEDF1reSV1ZjHlZow4ey+qIu+PW4qC9G96Ajkfvm
 CDZjmX9tM2BDmwWOVSfP0wnZuxrfFtye34Av84gKucHCAc3urx5JdQ3hUCm4zx8XK4Y9
 XFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dl7Pg/vEUTpn3GkKhp+pyC/6uR7V/3Y08Va22umnMaY=;
 b=CWuT9WSgspTK8Bg7U9lwrQi6EJVjYPimpMXsjO/oW8nWBYM7mS7OCcBxjHCOiy+VQl
 aOIA0nvW3o278W8OaXShZGBebQssrD/n2Dw55XyB1fr8go9jCf3SCmpbYCM5W84vmZe5
 XriSnJ6jaydV5sHpdhk9BfFeejBoDfbKxbMFTMVBW14rMmkxRD8zrkubeBydO9t30AmJ
 ANqwCi1tzI0egScJ2vJ40Qo5fCnbUa35VsGu5P9Pi+40gcycpPAgFNyRJa6DngQo+gDG
 5lN166XRL1mEIYylaukAeyHkXfub9v290Zzyk78ww77T0DWvfOVDoaCprW7Q0g3qdEoP
 HUqg==
X-Gm-Message-State: AHQUAuZkQ0BGcQGfE9Rdgs4jvZMGuBHl0Z3RmazXiSnVRmUZOJic83wY
 BWQIfXGcXVLcUoEOJ2dmiBobJMW0+x57I1fa7RE=
X-Google-Smtp-Source: AHgI3IYM9XxpoJwJ9OyNDyl6B9FWSL1gT4BZhoUpTSD/TWZakm6WO9SRRhKnI/1oOqjd+vbG0ZHDrhcfZDfyeJv5EBY=
X-Received: by 2002:adf:e548:: with SMTP id z8mr22686673wrm.52.1550605689886; 
 Tue, 19 Feb 2019 11:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
 <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
 <CAHQ1cqENSb0ORrcN0Qh93DGx1C7AVxSqAKhcfJH2qZ8+WuVH+g@mail.gmail.com>
 <20190219122210.GA17142@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190219122210.GA17142@e107981-ln.cambridge.arm.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 19 Feb 2019 11:47:58 -0800
Message-ID: <CAHQ1cqE-9fTiOaJNGye3yEx6oF+Gox6-FCPZRO=iZmfDcBFiOQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_114812_352865_A4242887 
X-CRM114-Status: GOOD (  10.29  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 4:22 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Feb 14, 2019 at 04:59:04PM -0800, Andrey Smirnov wrote:
>
> [...]
>
> > Lorenzo, can you apply the dwc specific patches that are already
> > reviewed by Gustavo Pimentel from this series, to keep things moving
> > while we are waiting on Lucas? I can also spin them out into a
> > separate series if that's perferable.
>
> Hi Andrey,
>
> do you have time to respin the series with *only* dwc patches ACK'ed
> by Gustavo ? Or it is not doable owing to patches interdependency ?
>

Sorry for the delay, it's doable and I'll send out a separate series shortly.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
