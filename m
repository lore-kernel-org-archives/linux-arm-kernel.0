Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:11:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE141218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3VahhpI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJBUb327"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE141218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SQckec1+Ujep4W1x6Q/rPWMFLuTcAs76SwyHvCxpOzs=; b=C3VahhpIxwQsO9
	SoPeW2nO7l5A7hIGsBg4doh5PxiD8/CKjKruQSfAAaiS3j2LLGbw5Nb4i7WrirwnUY9Mm2g3eBROI
	rDa4/j2E+kvM6rZwrJ2bA0iR2iYZDpk58iuM6kLe5T9InpnEp7B8fP+gtUnaWgZn0rPORAJCAcijr
	JNXlyZUd1Nsof25FDLK8Q9yFDZZJ+BniWYxfliMCZhtzOvnsHbxWcK33el4cj21Km0v7EjR6Tw2VG
	RvK2y9KCsK9sjq5fwOqvG0ONCaJ8vu7tp7S9g3Vt/hs5iQrdIGkhUSnq2wu10J3DYzWAeWbMSbI9A
	cKlL/FunuDbKwIzN4nMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMdw-0003Nl-Vs; Tue, 18 Dec 2018 21:11:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMdu-0003MK-5x
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:11:07 +0000
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1A7F218AE
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 21:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545167455;
 bh=4TSoy7am50zcJFdCj0qlkmFgh7ve6nj0hZ7RxM5K9Po=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IJBUb327rfAXUE1s+r/hAEIDd0rS0Z5jodnjPsyMu1eVoUNReMdMsntsciGu5MBVm
 6sP95GSgyvAslUH5JBJOpIejDZ0NZjD/6JcqsBpmWJanoryEpBwjdZpvliqtTHMMSu
 3/Hb6tfjHnIRkRsFfTrsMMSEP4rUGZLLZptABCLE=
Received: by mail-qk1-f172.google.com with SMTP id q8so8196129qke.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 13:10:55 -0800 (PST)
X-Gm-Message-State: AA+aEWZUvLOnqkOTwoDw58fMt+kr56rpYNeRXwk/VpNIfrLXoNQN5/27
 f7/KQeE1UyCtGh0TkUOEDNsZKza83z3KLELRGg==
X-Google-Smtp-Source: AFSGD/XDMMsXDqTSKfsppkIWD2amigNADiMJP2tAz6O2uo7RqRXdFgiaPggf87D75bHQhJxasdYd+0hDUMxCGYVSHXU=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr18087864qkg.147.1545167454899; 
 Tue, 18 Dec 2018 13:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
 <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Dec 2018 15:10:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
Message-ID: <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To: Leonard Crestez <leonard.crestez@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_131106_244018_44F9DE8A 
X-CRM114-Status: GOOD (  16.18  )
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

You already have an id for the controllers: the address. Use that if
you don't want to put the register offsets in DT.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
