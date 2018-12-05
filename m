Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6699C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AA220879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWIkUwqy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km9S9fCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AA220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NPv9DYTep9+WFELKNLaoyZ/voJOT/l/PFWdGr4uG5EQ=; b=EWIkUwqy5wOKWi
	DRCp41JRCbVGgvYa6jn1/tMlB4vtjEb+qP2EByQpTKPOKF3UtefdQ0e/Ex5mJfagvIRm/DINdXyq4
	NvQDRB2CWCogfzEePUmjTbp1J8FPw50xb9tQe8e1H3EXpMOYXaePMcoia5e3he+QLgD3TZAmIwbaS
	X7VXGFY7akLNEj8dhmkdC/41/aElwiPT0R0GwzRzOQWNyU/D/0XDaPJVz+vY392Xp+4GdC5FfcVJi
	IIIzVVHxRlXGZekb+RN46itlk+PK8lFt/06dVnGHk4U1W9uoa440lhexUBa4cEYydewsaimA1t97z
	7tVjT30Lve3RDkZBr1MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfrB-0005az-Ee; Wed, 05 Dec 2018 22:41:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfqz-0005KE-Ji
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:41:20 +0000
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF82A2146D
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544049662;
 bh=QGid9c8fcmYrIrtsqICzM5hBjYULD6bUpSZfRiAxfbw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Km9S9fCI68QsJOnhn+KUzVDICYMEWArrMxjLPw5f/kmjvSrE5/ti6DikCjDlG7kUp
 A9VWjCZpxN2rDePF2yUBlR4pF49mG/5I7ILMO7q/8HnIeWXABzjUFDhQqKQFDFfymh
 mEkW6kQuBWM+c4jw7sRBAgfToqupfQnpAFdWWaPE=
Received: by mail-qt1-f175.google.com with SMTP id e5so24222029qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 14:41:02 -0800 (PST)
X-Gm-Message-State: AA+aEWbMn6dFXS53GOdhtFIaktPeiU+1X5ITKL9Qr5PJRjGl5csmMDcg
 QorwKAxCXFDRcPqwSAThDDzwSVSWxZM/kEi8vg==
X-Google-Smtp-Source: AFSGD/WHSW83dpwigr+NuV+o6CHNMLQLAyGqoHjJfnFqmAlj+oFBfOsqluDu9Oz8k6sLa1sx3CPSydHsOar5BIQYM8E=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr26328965qvl.77.1544049661848; 
 Wed, 05 Dec 2018 14:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-23-Zhiqiang.Hou@nxp.com>
 <20181205223843.GA2125@bogus>
In-Reply-To: <20181205223843.GA2125@bogus>
From: Rob Herring <robh@kernel.org>
Date: Wed, 5 Dec 2018 16:40:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLmV65rt46FiMy1Tvox+5LQa=vkFxQwzQUx1toBq-JzfA@mail.gmail.com>
Message-ID: <CAL_JsqLmV65rt46FiMy1Tvox+5LQa=vkFxQwzQUx1toBq-JzfA@mail.gmail.com>
Subject: Re: [PATCHv2 22/25] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_144114_395547_EFF38C84 
X-CRM114-Status: GOOD (  18.76  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, linux-pci@vger.kernel.org,
 Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 4:38 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 09:27:51AM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> > V2:
> >  - Change to use the layerscape-pci.txt for PCIe Gen4 controller
> >    dt-bindings
>
> Sorry someone suggested this, but it seems there's no point in having
> these in the same file. New IP block, do a new file.
>
> >
> >  .../bindings/pci/layerscape-pci.txt           | 57 +++++++++++++++++++
> >  MAINTAINERS                                   |  8 +++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index 66df1e81e0b8..3ef8836b6e97 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -1,4 +1,6 @@
> > +====================================
> >  Freescale Layerscape PCIe controller
> > +====================================
> >
> >  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> >  and thus inherits all the common properties defined in designware-pcie.txt.
> > @@ -58,3 +60,58 @@ Example:
> >                               <0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> >                               <0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> >       };
> > +
> > +===================================
> > +NXP Layerscape PCIe Gen4 controller
> > +===================================
> > +
> > +This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
> > +the common properties defined in mobiveil-pcie.txt.
> > +
> > +Required properties:
> > +- compatible: should contain the platform identifier such as:
> > +  "fsl,lx2160a-pcie"
> > +- reg: base addresses and lengths of the PCIe controller register blocks.
> > +  "config_axi_slave": PCIe controller registers
> > +  "csr_axi_slave": Bridge config registers
>
> Wouldn't 'config' and 'csr' be sufficient? And these should be listed
> under reg-names.

NM on the names. I see these are inherited.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
