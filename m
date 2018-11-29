Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C63C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D08020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JkE0Xti9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5durNoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D08020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dqE/TMBJZ+F6r2OJO2qPkNGqa9jYpXmKN49ZDDAOBg4=; b=JkE0Xti91h86Kw
	i0itCorHesTqfo037Rq3xCGWBtkpUCrXbOnihahRp+//3DGGxlBHmzjxM7M3eZJMmF3fUNI1drKZr
	q6mljiOCC6GQ2oou9bYed6OdhBhE+K4gVKC+b79INd+la1xr5R6qvvrJlpg2gfPfEpq6gFsKZn/PV
	FOtLh3/jhGNdtLthD8wAzy9BR5VE1jL7r/aSrcz5M1R7yI6f8s6kQmly9EYqsuXDBygvREuUYCxew
	AopnJBqj4MrMa2qqGCaDHbNohdAci2yO4yw2v2yHdlNyMfgDg5bAqYj4ttKIJCwaATIh4KqM3P74t
	rCEAyESnzPdxqrDpwCdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSU0e-00076s-GB; Thu, 29 Nov 2018 21:38:08 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSU0b-00076A-Re
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 21:38:07 +0000
Received: by mail-ot1-x32d.google.com with SMTP id 81so3246735otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IWOKWqTQ2s6dN/u5BES6Rh3MXirNRE299T42BWDpsYU=;
 b=j5durNoMdz9lR5obWfQgdE2KtD19adtJZDonf4phqLoYTnOR0yl1M9QsDuuy416dr8
 TLNQr4Gs6hGDVDZ2zw0Aa3uwPV1Z0/GpXjtQqiZvVyqL1xdoWpuqM6nC92ZDyUHrq0L2
 zISXg+jYk/K2H8vadh+9ugaS0ISDDXFHUn6XI5LutPAm3PglWwQmo4hTPiX6XghIBy1Q
 SnqGvJhNn9NS2pRL0Sk+M+uesJ1hb+Kt07OJI11/rbjI9dkMeu3NAHfnVrgny20dghwR
 VMYIqbh8huKFdzibrWUFcrKp0o52dMBZAEpnDO7fbzayrLnnO8WGcD+BNvwyCsxFUgBH
 Gi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IWOKWqTQ2s6dN/u5BES6Rh3MXirNRE299T42BWDpsYU=;
 b=P1ZapZjb13+lmiGitfk+0Iy/3YschbV79gEi4lx1TB3oSrDXa8ZRpPUn95+hr9R8Yt
 k/QpkjzOcw8IjDuRP7Ul/wQPZEkPQGhlXEBjIeU+Fr9FYrSAWPG8qKfg4rumlb6TeFEM
 aF5xsq3McCkjljbkeuLsZ7vjvbWIeQfRqZqUNH7t4IwJNyFtO0l/Hu9OFOKyz7zIGVkQ
 PzeY82aqci/ccNo9A+PE8jJHuSaU/gML1+EGzUlON6/Jpx8h2ZxSA8YOSoRSjDm6zWmk
 qt/VLt6a+KzryYyKzJpxSDa95w7Lq6z++2RDsLT77BT1f8YlwLpjl1Xdgxh5birPZ+pN
 uFmw==
X-Gm-Message-State: AA+aEWZNhQZHikL5o5tRapEwhPFVxRnuS5c36IkuAd0hTrj9f0tvLgsR
 qoozO2yzg87taZLKkQMsXyPhtQ72fAtn13mWDuw=
X-Google-Smtp-Source: AFSGD/XHnmofRLo2UKVs7IgmchCUZJrYgnKgt0uVNcYji7wgZpuHtwXBE/j0dO7gMkvtqSw2u+7uD0/wGcyQ7lJFEgQ=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr1924609otl.196.1543527473315; 
 Thu, 29 Nov 2018 13:37:53 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
 <20180912023902.GA28239@dragon>
 <CAOMZO5AgrUEqTUwXEm4vkkaDKZs2Yzi7gVYR4MXAN1KsqTz7OA@mail.gmail.com>
 <CAL_JsqJvwyY4GzNei-n945KywgoWgmNVCO8LfEF7XjZZAfQzSw@mail.gmail.com>
In-Reply-To: <CAL_JsqJvwyY4GzNei-n945KywgoWgmNVCO8LfEF7XjZZAfQzSw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Nov 2018 19:37:46 -0200
Message-ID: <CAOMZO5Bz16tcdavT0DCk6mfuBWx=mFA8RB0GmkqQwPCfr4bQTQ@mail.gmail.com>
Subject: Re: i.MX DT memory nodes
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_133805_895766_D62842F3 
X-CRM114-Status: UNSURE (   6.73  )
X-CRM114-Notice: Please train this message.
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Thu, Nov 29, 2018 at 6:10 PM Rob Herring <robh@kernel.org> wrote:

> Still going to do this?

Almost done. Only imx6q and imx6dl are missing, which I plan to address soon.

The patches are in Shawn's tree and you were on Cc when I submitted them :-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
