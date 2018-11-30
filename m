Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B7320834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q+joaZvh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErcPs9BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B7320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x3JCj6PsetBbx8uzzYrV/zm5kCuzpbQFyBrQrCTES+s=; b=q+joaZvhvZN+xu
	5Rz+ekhC3d9LTMoP526iRgf4pE7T36VuBoYY8HIMXc2jP4vt5j8WzF6k+DNo3o3n6wr8NhomCStOd
	byT83incWI3VDwoM9999WBcgN2x9feG7rsxS5RcTnrtqhkreHVwzHUh2eFlrUBsKpIMhE3BZKXRjv
	lyOWi/7ifUM6EKpNx5BAV0h9mh4p3BfjgviLCjTZ4bPVqnUpSHvsdz+oVBtWa53aVw/iNfnp5WYzg
	KSN0diFD+QapCGcAvwGKmvBvRlsDhiiZMjutj5gdUAYjMPCGoLYYoxafjhzxEzRAobGeBHtq1DsvK
	GX147HYFKB/0aqBlltLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkDp-0005LI-K9; Fri, 30 Nov 2018 14:56:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkDm-0005Kx-H8
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:56:47 +0000
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02FFB2145D
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543589796;
 bh=d93szx02wQk7+qsDNit3iiV7n7dfr2G/yuKxIa0/uNA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ErcPs9BY5iT0CLnu2eJ4KwUiwX/4B2CvuV+/zsEt54f+HihP83oOZpGci3f8FvuBm
 OPciGbxgASD3inbiylevTRwlDa/ATOKUCynAF2YkyQEdZCwx6n39GYF6nJXnEdKDoE
 6CHsV9AmMj8Exl5YgFOjUO7cHe/BJI/NacaCjaNE=
Received: by mail-qk1-f169.google.com with SMTP id a132so3313921qkg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 06:56:35 -0800 (PST)
X-Gm-Message-State: AA+aEWbR1+hLQo7bpMeSOjw3aZ4Xd/1iH9n9LkFYwpp5CMj5MVTfeLd8
 en72eC4uB/mRXKm6r8ugD4szomXVNMwIhOqzoQ==
X-Google-Smtp-Source: AFSGD/VBT6Dy+G5bXLuXCfMvWZj/zvIxIavkUOiAUVNRWTWlfR8rEL5ALpQc0Sh2wgr7hnbJQbwC2vKMphEtf9G/Vxk=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr5621793qkg.147.1543589795239; 
 Fri, 30 Nov 2018 06:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20181105194040.25406-1-daniel@zonque.org>
 <87in14lkzp.fsf@belgarion.home> <87pnv3ihqn.fsf@belgarion.home>
In-Reply-To: <87pnv3ihqn.fsf@belgarion.home>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 30 Nov 2018 08:56:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKYWV4C=M7P4+1dUz497=JN4dMRnwO1zocgLhG090WCNQ@mail.gmail.com>
Message-ID: <CAL_JsqKYWV4C=M7P4+1dUz497=JN4dMRnwO1zocgLhG090WCNQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: pxa3xx: Add Raumfeld DTS files
To: Robert Jarzmik <robert.jarzmik@free.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_065646_587757_A8C4CCE9 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 17, 2018 at 2:14 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>
> > Daniel Mack <daniel@zonque.org> writes:
> >
> >> This patch adds a set of DTS files that support all PXA3xx based Raumfeld
> >> audio hardware devices.
> >>
> >> Common nodes are factored out into 'common' and 'tuneable-clock' include
> >> files to keep the top-level DTS files smaller.
> >>
> >> Signed-off-by: Daniel Mack <daniel@zonque.org>
> > Hi Daniel,
> >
> > I will need someone from the devicetree to ack this one, Rob or anybody
> > maintaining the devicetree.
>
> Rob, Mark, would you be so kind as to have a look at this patch, I have no
> concerns taking it into the pxa/dt tree, but I'd rather be safe with someone
> from the devicetree maintainers reviewing it first.

I happened to see this, but generally I don't have the bandwidth to
review all the dts files. The subsystem maintainers have to do this.
For starters, just make sure new dts files aren't adding new warnings
when built with W=1 or W=12. This will be easier if the base SoC dtsi
files build cleanly.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
