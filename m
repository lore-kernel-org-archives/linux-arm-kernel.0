Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A10BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF9420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VVJ85RDY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKoi93q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF9420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OBnanbYAOFKtObCKZ+XBFS91RzCKQ/GAxpts6QFFU0Q=; b=VVJ85RDY6UaXNb
	9JVJ92nOIkUyCOD2AfMot8QJ3ByJVDhmUmhiZaWSGUfmqXEUdOsw6uNsO6RW4rv4v3umsce+TFcLw
	pXaVOHimTuR9OQ5VRC07qQqywy6jLRm6rno8RFnnjiZtGbdhk56X7qt4nj6Gr10jQJktJVrOGtF8O
	2ylw13FLZKEi47VngojysuiR8IJQVQEGeIIoqn3S9ZEcEwylAZzVqtgwTEtG/PXNfecy8+LGc1p71
	oQdidOHJFWTdz0OPvB2ZlC8N3rwjKzr7ew/L5oIv1A0Kpq7pA2v8F1t2LsNy/SzXNdXUis3+VYmJJ
	gUZGIPW3zWnHjCy5Dyug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzt5-0004Jf-D2; Thu, 20 Dec 2018 15:05:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzt3-0004IP-9N
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:05:22 +0000
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE08C218AE
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545318311;
 bh=pU1qiUpdARY0RhrguUJV+QXDWs9jVr6LBPKymW/y3LY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BKoi93q0Ey+xkCzuqqOQTHp+4u/DfalRPbHW2Qz9e849jTnhxKau5RC161IZ+DP88
 OwmgI5xxXVKG+JHalCnryZ+OBJKvudzsAjz4bBe5Hu9Bqx2lSnGAKCudk22sZyld0z
 fTfLjh+MAWHqFUgAbjZ48wyxMbcb0EnLSg46B9Iw=
Received: by mail-qt1-f182.google.com with SMTP id l12so2098050qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:05:10 -0800 (PST)
X-Gm-Message-State: AA+aEWa621ieXab6wgHFSsZFZvPln3N8dcNRBS9QZ7qTOmenV07aSJsj
 ad+uaCMb3b+MxUNdv7O/wJgP88N+srlOBvmkdA==
X-Google-Smtp-Source: AFSGD/UnuIu7E3MzUS/BouOvxJ8zdia4VxZRbCWxRFN6Pdr0hyHOUB1E4X4aLpHc9e8tsdnhFPql4uFymmKZAHFEpn0=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr26473216qvi.90.1545318310028; 
 Thu, 20 Dec 2018 07:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 20 Dec 2018 09:04:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcMb+RG8CJxzCRx0D8TdfZBFOtcx768ejHeNHtSSp5Wg@mail.gmail.com>
Message-ID: <CAL_JsqLcMb+RG8CJxzCRx0D8TdfZBFOtcx768ejHeNHtSSp5Wg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To: Leonard Crestez <leonard.crestez@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_070521_356705_7A111133 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 12:09 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On 12/18/2018 5:15 PM, Rob Herring wrote:
> > On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> >> Add code needed to support i.MX8MQ variant.
> >>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>
> >> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >>
> >> +Additional required properties for imx8mq-pcie:
> >> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> >> +
> >
> > Remove this.
> >
> > If GPR register offset is what you need, then put that into DT.
> > Typically, we'd have a property with iomuxc phandle and offset.
>
> This series initially added explicit offsets but I suggested a single
> "controller-id" because:
>   * There are multiple bit and byte offsets
>   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
>
> Hiding this behind a compatible string and single "controller-id" seem
> preferable to elaborating register maps in dt bindings. It also makes
> upgrades simpler: if features are added which use other bits there is no
> need to describe them in DT and deal with compatibility headaches.

You don't have to describe all bit and byte offsets. Once you know 1,
you can derive all the others. In fact, it doesn't have to be a
register field at all, just provide whatever identifier you need:

<$syscon 0>

and

<&syscon 1>

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
