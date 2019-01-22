Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0568CC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82FC20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J2PbDVvs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjYKKi2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82FC20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7sQfsZmQisFtcUWd4N7tFDFLtNC0IGQdRdFSpfmAbKk=; b=J2PbDVvsKxC+Bb
	XYLtcrPsZlbF8yejRPkY8cBPnr65+GdniZvd+2zTvqf6q9cyYqfxT2fZhgUoFI6ZsBidzVzo8mqQC
	ZBvMxtYDXepjSlxYLo1UhxLOvl0/rDNQAKhN1UZUhQbMGqSr7lboe3W0VOz+XpwsLeL2Edt4B12QD
	FLVnQXWLxCdnAQke8FT4G2oKtRH0OzyDSVsZXL5uCc7LjQM3eM8qqckEhVwCEWLfeYHajbPvCU5gy
	8IjWzs63Q979NvI5F0ppI75Det/i/vfzn6VmvyPoX2S5FfX6XZfNeyRL92wbC5Xyd2fVpw1qk3k5e
	10wgXphUC2xuOXOnhhhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glybh-0002j9-B2; Tue, 22 Jan 2019 16:08:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glybe-0002im-Dx
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 16:08:55 +0000
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 83C2020823
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548173333;
 bh=gpimG8Bf3Y2mg+Ngc1e/ZUqZSM7G9Z4zRiQZwCEADwQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kjYKKi2vigP/HHVSRaJ47C7/0G/2RcTDzhlJnQjZLhNTFlKxZd5KE8RDzzc+PtQIp
 rZulvKDEWpgX56dYeEjMm4uujn5I9KINCupHx53vRjjy4bed1Z3/lfjkJ+hEUXFOOK
 DaIKYlknVat0m6jv6G1mNzg2cC8njiG5Fiqkybro=
Received: by mail-qt1-f174.google.com with SMTP id l12so28111526qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 08:08:53 -0800 (PST)
X-Gm-Message-State: AJcUukfW9YFFVA5rs2DXcBSAbRFUvqRWFR3aSWGJArygFaXnyz8+hI9D
 HhrPQG7jR2j3rBUbn8BmY9NG4AvFqAq9fcjdPw==
X-Google-Smtp-Source: ALg8bN7AN70QWeGZqRaGXYNOSp6YFOZjBzHi8k9yOl7flWjFX9/ChkyHnMH0p0i4kWRGmyvHwes1aSzrQ8u4/3f41C8=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr31987830qts.144.1548173332772; 
 Tue, 22 Jan 2019 08:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
 <20190121112336.23489-7-miquel.raynal@bootlin.com>
 <20190121154451.GA28183@bogus> <87r2d6ko6e.fsf@FE-laptop>
In-Reply-To: <87r2d6ko6e.fsf@FE-laptop>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Jan 2019 10:08:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQ+7VZ--n17aDAFS4v1fMOKKPprs9fVVASy9yt=_mR2w@mail.gmail.com>
Message-ID: <CAL_JsqLQ+7VZ--n17aDAFS4v1fMOKKPprs9fVVASy9yt=_mR2w@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_080854_485305_CBA9FDC1 
X-CRM114-Status: GOOD (  15.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 9:49 AM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hi Rob,
>
>  On lun., janv. 21 2019, Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, 21 Jan 2019 12:23:32 +0100, Miquel Raynal wrote:
> >> Add bindings for Marvell Armada 3700 USB2 UTMI+ PHY.
> >>
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> ---
> >>  .../bindings/phy/phy-mvebu-utmi.txt           | 38 +++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> >>
>
> I found "marvell,usb2-host-miscellaneous" too generic, I would prefer
> that we call it "marvell,armada-3700-usb2-host-miscellaneous" as we do
> for all the other IP.

Ah yes, you are right. Perhaps just '-misc' to shorten it a little bit.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
