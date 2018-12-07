Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A70C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:46:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F4A20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WEeg8jiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F4A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lpu6nZ94VGcWmcR/8jy4W6pD806WEVBi+yejD3dP5Q4=; b=WEeg8jiQYoyEzV
	E7DqTrpBjU8a6Wbe7tJ3XDTbIGPNJ9qVrBK8QjKcywDPyRMWVHjAJPlQ7qtYVZctVKpd+BX5v3+Ci
	Zb4/1VQWKmOnnqCTha84nvnqnME6ICYfjNFFvmJhYiEpoZARUVzrhgpzcaAMzR736vfAySLQG7yYW
	7wGQhkZ+xd/8WZEU3D7lRZ2AB6A8t4tB8MkMNAeEwbczcZqzw9COvoVhDG2UxmqVS7e9AKlb+GpRj
	hOytp+1r5WHv9sucruH1/o40AybwLIDm3kxPqKu3P8mbY5+Nfop2ovDnzK7G1FzW+yEyzh7hipFU2
	PpRx9zJasErNqS6b8LhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVApl-0006Ds-54; Fri, 07 Dec 2018 07:46:01 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVApi-0006D1-5Q
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 07:45:59 +0000
Received: by mail-ed1-f68.google.com with SMTP id f23so2940669edb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 23:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T8xvOWkToXJw2n9tRNGsgGrpj0F2EZBHsviBiImVuNg=;
 b=fyBy+U3VbpxnLK1528RZdnioS37GHrwIvQ/F0zbCgTIcNNbELia7stfU7kVpBqS9X1
 eMwjVZxiBc35SMrR4QF7Gg+AdRxT1tCLAZyz6glnAUOpgeHrh3tB1woJTS19cwMt+dO7
 Qi07PKI41BnUc/5ra4dQVtDJmj6coqEfKp6T84reZ1VIh8LA+chbdfDqpPgN2RnhacF7
 k9Pb/TiLrUBHRfT0T2nkay5b7sSU3BHSA6PKXpJvahiDGV+pD/tWklmnmuDOXsg6YNYK
 F++zmdJVEKXG7pKPpzPWt+ncbfEQYIhsDwS5M/8NHvAs4KK2cnCivcXkDaBoO2U92NXW
 I3Cg==
X-Gm-Message-State: AA+aEWYPpvdsg3Cd0yxP2MPCMokBriiYxl9dBLSZMonCACItMhKo1yS+
 BnQP298U121DsV8uyQAwXcSJHdO5Pqk=
X-Google-Smtp-Source: AFSGD/XCq4TDbkAtuCImVVk5+mY0EnUoQlUydxopXRHV90vJ5PuYWqwCMqbdsBVqhUejyP6AtsSbNA==
X-Received: by 2002:a50:ee1a:: with SMTP id g26mr1272717eds.266.1544168745894; 
 Thu, 06 Dec 2018 23:45:45 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id g20sm735709edr.47.2018.12.06.23.45.45
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 23:45:45 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id m22so3509533wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 23:45:45 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr1298240wmc.116.1544168744826; 
 Thu, 06 Dec 2018 23:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20181120175211.3913-1-oskari@lemmela.net>
 <CAGb2v65Bwve25jwdGHHK9j03RxQ3tKwme51762DjyQK2femG6g@mail.gmail.com>
 <20181205180042.fr5npvtwuvt2c6q3@earth.universe> <20181207072803.GG26661@dell>
In-Reply-To: <20181207072803.GG26661@dell>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 7 Dec 2018 15:45:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RMirgaRLD3Ctbxyx410FN5ushicDaRbJTO9sqc+38GA@mail.gmail.com>
Message-ID: <CAGb2v65RMirgaRLD3Ctbxyx410FN5ushicDaRbJTO9sqc+38GA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] AXP8x3 AC and battery power supply support
To: Lee Jones <lee.jones@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_234558_205489_02864952 
X-CRM114-Status: GOOD (  23.73  )
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
 Quentin Schulz <quentin.schulz@bootlin.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, sebastian.reichel@collabora.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 oskari@lemmela.net, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 3:28 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 05 Dec 2018, Sebastian Reichel wrote:
>
> > Hi,
> >
> > On Fri, Nov 30, 2018 at 04:31:28PM +0800, Chen-Yu Tsai wrote:
> > > On Wed, Nov 21, 2018 at 1:52 AM Oskari Lemmela <oskari@lemmela.net> wrote:
> > > >
> > > > AXP813 AC power supply support with input current and
> > > > voltage limiting support.
> > > >
> > > > AXP803 AC and battery power supply support.
> > > >
> > > > Changes in v6:
> > > > * Collected tags
> > > > * Rebase to master
> > > > * Dropped AXP803 compatible patches
> > > >
> > > > Changes in v5:
> > > > * Return correct input current limit for values 0x6 and 0x7
> > > > * Add specific compatibles for AXP803
> > > > * Change commit messages
> > > > * Add Vasily Khoruzhick Pinebook DTS patch
> > > >
> > > > Changes in v4:
> > > > * Change order of axp20x-gpio in axp20x.c
> > > > * Fix indentation and spaces to tabs in axp20x.c
> > > >
> > > > Changes in v3:
> > > > * Reorder ac_power_supply DT node
> > > > * Rename axp20x_ac_power_set_property function
> > > > * Split mfd commit
> > > >
> > > > Changes in v2:
> > > > * Reuse axp813 compatibles for axp803
> > > > * Refactor axp20x_ac_power.c
> > > >
> > > >
> > > > Oskari Lemmela (7):
> > > >   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> > > >   ARM: dts: axp81x: add AC power supply subnode
> > > >   arm64: dts: allwinner: axp803: add AC and battery power supplies
> > > >   arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
> > > >   power: supply: add AC power supply driver for AXP813
> > > >   mfd: axp20x: Add AC power supply cell for AXP813
> > > >   mfd: axp20x: Add supported cells for AXP803
> > > >
> > > > Vasily Khoruzhick (1):
> > > >   arm64: dts: allwinner: a64: pinebook: enable power supplies
> > >
> > > Since this series has been fully reviewed, and the devices it
> > > adds/enables aren't critical, i.e. won't cause the system to fail
> > > if the drivers are missing, I've merged the dts patches for 4.21.
> > >
> > > Hopefully Sebastian and Lee will get around to merging the driver
> > > patches.
> >
> > I queued the power-supply driver changes and prepared a signed
> > immutable tag for Lee:
> >
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> >
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> >
> > are available in the Git repository at:
> >
> >   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/psy-mfd-axp813-immutable-for-v4.21-signed
> >
> > for you to fetch changes up to 7693b5643fd2d682de90733b67fc8032b9646911:
> >
> >   power: supply: add AC power supply driver for AXP813 (2018-12-05 18:49:32 +0100)
> >
> > ----------------------------------------------------------------
> > Immutable branch between mfd and power-supply for driver
> > changes related to axp813.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >
> > ----------------------------------------------------------------
> > Oskari Lemmela (2):
> >       dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
> >       power: supply: add AC power supply driver for AXP813
> >
> >  .../bindings/power/supply/axp20x_ac_power.txt      |  3 +
> >  drivers/power/supply/axp20x_ac_power.c             | 94 ++++++++++++++++++++++
> >  include/linux/mfd/axp20x.h                         |  1 +
> >  3 files changed, 98 insertions(+)
>
> What patches are left now?  Just 7 and 8?

That's right. If you could merge them, that'd be great.
Thanks Lee.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
