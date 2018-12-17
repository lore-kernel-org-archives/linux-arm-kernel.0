Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF126C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EAB206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+e5NZ/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EAB206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VBU9eLrU6ChElWT+pjOQ9Ya9vIDkZMyHdO2xnTYmOQs=; b=h+e5NZ/26pCiEU
	dqt6kRbiGuSco7oHD0ke/OYkso/ZVvux/HHHKrH//kPhkIHOinJERsxTgZJ1hBOUmVYgze/H9YoqU
	4g5yhj23icRoAjuSYp9puznP+ZrhYgvHtsRIPzXGUwR2mY9xwk/0j7Hzr1etsnp2kfBBfXJcmD+Lj
	/Q8XCLPHFVoTuUD/kxVJq1a2BPQiAW/a9tvEAaUBw/39cSPsFriWcmNDywq749hPmEMKS1IlTX0i9
	axS3MmqRzHN+Rkk0e5ELfaJMP/tPYtr/BghgQokv9WLErYJo66ikBkpIl7YKw8qrIHBSOTgk6akif
	KhjZgtqPPh4SP/YV6ApA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYq6K-0006nN-E8; Mon, 17 Dec 2018 10:26:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYq6G-0006le-Ma
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 10:26:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 035A7A78;
 Mon, 17 Dec 2018 02:25:55 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55E233F6A8;
 Mon, 17 Dec 2018 02:25:52 -0800 (PST)
Date: Mon, 17 Dec 2018 10:26:36 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 0/3] PCIE support for i.MX8MQ
Message-ID: <20181217102636.GA13465@red-moon>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206121550.GA2725@e107981-ln.cambridge.arm.com>
 <20181214203828.GD20725@google.com>
 <CAHQ1cqG3s4J42V3oUPOGssUPw6dypZqYrtpkRphHPdiYFs9j1g@mail.gmail.com>
 <1545041578.5874.3.camel@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545041578.5874.3.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_022612_748153_D9F6B173 
X-CRM114-Status: GOOD (  24.93  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, helgaas@kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 11:12:58AM +0100, Lucas Stach wrote:
> Am Freitag, den 14.12.2018, 21:25 -0800 schrieb Andrey Smirnov:
> > > On Fri, Dec 14, 2018 at 12:38 PM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
> > > =

> > > [+cc Trent]
> > > =

> > > On Thu, Dec 06, 2018 at 12:15:50PM +0000, Lorenzo Pieralisi wrote:
> > > > On Wed, Dec 05, 2018 at 11:35:42PM -0800, Andrey Smirnov wrote:
> > > > > Everyone:
> > > > > =

> > > > > This series contains changes I made in order to enable support of=
 PCIE
> > > > > IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).
> > > > > =

> > > > > NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-k=
config].
> > > > > =

> > > > > Changes since [v1]:
> > > > > =

> > > > > =A0- Driver changed to use single "fsl,controller-id" property to
> > > > > =A0=A0=A0distinguish between two intances of PCIE IP block
> > > > > =

> > > > > =A0- All code pertaining to L1SS was dropped to simplify the patch
> > > > > =

> > > > > =A0- Documented additions to DT bindings
> > > > > =

> > > > > Feedback is welcome!
> > > > > =

> > > > > Thanks,
> > > > > Andrey Smirnov
> > > > =

> > > > Andrey,
> > > > =

> > > > I have applied the patches, ...
> > > =

> > > When I merged your pci/dwc branch, I noticed what looks like a merge
> > > conflict between these commits:
> > > =

> > > =A0 d123765b58ee ("PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host o=
n IMX7")
> > > =A0 1a059d994189 ("PCI: imx: Add support for i.MX8MQ")
> > > =

> > > d123765b58ee added SOC_IMX7D:
> > > =

> > > =A0 -=A0=A0=A0=A0=A0=A0=A0depends on SOC_IMX6Q || (ARM && COMPILE_TES=
T)
> > > =A0 +=A0=A0=A0=A0=A0=A0=A0depends on SOC_IMX6Q || SOC_IMX7D || (ARM &=
& COMPILE_TEST)
> > > =

> > > and 1a059d994189 added SOC_IMX8MQ but dropped SOC_IMX7D again, which =
looks
> > > like a mistake:
> > > =

> > > =A0 -=A0=A0=A0=A0=A0=A0=A0depends on SOC_IMX6Q || SOC_IMX7D || (ARM &=
& COMPILE_TEST)
> > > =A0 +=A0=A0=A0=A0=A0=A0=A0depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM =
&& COMPILE_TEST)
> > > =

> > > So my "next" branch[1] (current head 7053eeb009e0) is:
> > > =

> > > =A0 config PCI_IMX6
> > > =A0=A0=A0=A0=A0=A0=A0=A0bool "Freescale i.MX6/7 PCIe controller"
> > > =A0=A0=A0=A0=A0=A0=A0=A0depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM &&=
 COMPILE_TEST)
> > > =A0=A0=A0=A0=A0=A0=A0=A0depends on PCI_MSI_IRQ_DOMAIN
> > > =A0=A0=A0=A0=A0=A0=A0=A0select PCIE_DW_HOST
> > > =

> > > which I think is wrong.
> > =

> > Yeah, this is definitely wrong, should be SOC_IMX8MQ || SOC_IMX6Q ||
> > SOC_IMX7D || (ARM && COMPILE_TEST)
> =

> arm-soc would like to see the SOC_IMX8MQ option removed, so let's try
> to not add any more things that depend on this. Please use (ARM64 &&
> MACH_MXC) or something to that tune instead.

Patch series dropped from the PCI queue, waiting for the discussion
and related follow-up patches to settle.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
