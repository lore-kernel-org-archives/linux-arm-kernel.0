Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFAAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:22:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D648D20673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rjzpf5Zu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV/i8vmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D648D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FINy8icV24MABX1/l0Z9dI0hvzo+klk94CEKzv89SPA=; b=rjzpf5ZuORzIVo
	DV5mtiecJqDknsj9ylPbCn9tMcqzaG9JLR9hoa9dgA7/Zs5gkOe6axoJ2dyRlOZKmLIDSZTvlA4Q4
	BvDXTGhEOlxh0t/bc6Iva3HOE78kmwico5C1qDCNonZ43eQUjv6Jcx+nSphbP79+/cD/gitgjG8WC
	q9aFYhKLewuFSUjFzo9z3sO4VUVRgpmaD7TVXLHsXmT0UPr5ijs5tXFc9QS0IIZiXz/3SKidxLfxr
	Y6xx4c1iLrD8Oz+eluxDM2pcdvtNuFslmjUugxrJL87p3FFYvNMK66TegoylA+JIkzOzDJnT49kbZ
	UQpJiSX3sX51WubBM/iQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUh7-0005wz-HT; Thu, 29 Nov 2018 22:22:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUh4-0005wW-A2
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 22:21:59 +0000
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 534D421473
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543530107;
 bh=8y7xsXDRbAUFd6NgSLBcR+ONsTsIVDjiJ2Ju6YIcJeU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TV/i8vmTJQRHE6NmFtxshppSXODOzpB5NgKvfzYK/7o+IYnIWBDEFavD54FCNNwN3
 UOyMV22ufcf9K+WdAOMT1trIEs9vO/nXZX3zmzLmRiUTTigoijS9qQCx928Gewd+nu
 AsU5J5Q80Ygtt1LduxTvw8NMG3aOqYkw/jlOBUjk=
Received: by mail-qk1-f170.google.com with SMTP id 189so2064743qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 14:21:47 -0800 (PST)
X-Gm-Message-State: AA+aEWbGgoIGDEBvoh/N6nnK13v27AOGWWe7IiFHDAre7fdWJ5Z+1V43
 MLqoySkSjQuaLJqMLnNYS2mj9hX+C2zTQhPKFA==
X-Google-Smtp-Source: AFSGD/UHLCkulV8hbsIO9zDeS9if8g+AB5u2RfBXGroIyzOFo8B2ZyilybLGzsRaM51WfpM+rAF49P7PS7TT+LciPYA=
X-Received: by 2002:a37:5686:: with SMTP id k128mr2921411qkb.29.1543530106563; 
 Thu, 29 Nov 2018 14:21:46 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqKtwt39k95d32ni=mKrZ=UVmTBH_onxC3ncjWs9eLbdJw@mail.gmail.com>
 <20180912023902.GA28239@dragon>
 <CAOMZO5AgrUEqTUwXEm4vkkaDKZs2Yzi7gVYR4MXAN1KsqTz7OA@mail.gmail.com>
 <CAL_JsqJvwyY4GzNei-n945KywgoWgmNVCO8LfEF7XjZZAfQzSw@mail.gmail.com>
 <CAOMZO5Bz16tcdavT0DCk6mfuBWx=mFA8RB0GmkqQwPCfr4bQTQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Bz16tcdavT0DCk6mfuBWx=mFA8RB0GmkqQwPCfr4bQTQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Nov 2018 16:21:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJTgxq5PoMAFjH2C+JyXVF7EkunqQYq8-T=4rOJqU9tug@mail.gmail.com>
Message-ID: <CAL_JsqJTgxq5PoMAFjH2C+JyXVF7EkunqQYq8-T=4rOJqU9tug@mail.gmail.com>
Subject: Re: i.MX DT memory nodes
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_142158_371419_01AFA297 
X-CRM114-Status: GOOD (  10.65  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 3:37 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Nov 29, 2018 at 6:10 PM Rob Herring <robh@kernel.org> wrote:
>
> > Still going to do this?
>
> Almost done. Only imx6q and imx6dl are missing, which I plan to address soon.
>
> The patches are in Shawn's tree and you were on Cc when I submitted them :-)

Ah, okay. I didn't look that closely.

Thanks for doing that,
Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
