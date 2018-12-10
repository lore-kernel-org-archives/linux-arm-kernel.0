Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D693C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:39:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62712081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tevhe2pr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="T+wh7I9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62712081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XLzEqMKp5KtYegOb5NHrscKkVC1yAeY2Jr7vV8TFlwk=; b=tevhe2printadf
	mc8rUiQKZUXCuPwckX71VWGLPnsOvZtb/E07yjEj3zoJaUu5CGqkMkoX+Lj/uKbRErRGd/H4LoeYP
	SgIEEBL9geiVIdyd0/ejY+9j9scbqSDkkE3+L0WCkumQEC1uGYQ7frmxzTRl67V/7v6k/+1xTsVJ2
	WRAR1xCICHC6JWOl/yjL7p08BvViukrBrNxRqCUwQv44pFegbHC16zcK0xLe04ztFM9XQGaQuf2pC
	FJpIh4HjA+TWXR702NYhIuNMnPLoDWo2bZYSq+MRam5QJwx5m3lZCjda6ESrImAF/AMiBvas4CK3A
	Abtf0DiDVu7+TS/Ls6Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWDLT-0002Kk-Tl; Mon, 10 Dec 2018 04:39:03 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWDLP-0002JN-LZ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 04:39:01 +0000
Received: by mail-wm1-x344.google.com with SMTP id r11-v6so9436656wmb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 20:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QQeTPStWdQffsRdjgIQ5kUxjgC0AbP5Kz14R+R3dPic=;
 b=T+wh7I9DNmSNRX3WgITI5B09E9p3OBneiKE7VgJYm9K98VAJD4R2VdKNzmtADj6ZDs
 8HjKPnJrpNJdS5JiaFKUiyybIQIwAwlDremNtS1zD2aU+MrTr93PFCRJsI9RaRqnYUmr
 qIW4XGzqLYH4dQme2iG9ZbpPbYi41KVsdIfWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QQeTPStWdQffsRdjgIQ5kUxjgC0AbP5Kz14R+R3dPic=;
 b=JoMxmkFeMaMmfuMgnEq3Cf/DFnxYXMAcR+1p6GuE1FtN4+CY1ynPgey0gi+mev5pFY
 imXtu1+5If4zUoSbo4WUJ2zwVRVmMkakl0QHh2D5zD99ndICPrud0UKr60pmz/PDjAdS
 s40VZ//qugL9/9SwQrPPOVp66nJ/EUxKtgO1d008Zx0ylx8BOuOxFnlxUjRvC/Uy455g
 cFCbOau7qlrn5Wwcy6FxdJNhhDNR7mInJmoB7aQ/O/oadaBf1SxqAEim4ABGtIsJ5qT6
 yeeFOyyPNqqt1kbEyCaFZhWm6X7GNeYfOnxAvvdctgauae5rKXmIGWwhFSVH2CGSTuWY
 yxtg==
X-Gm-Message-State: AA+aEWahEeAeiE2muGZ0BH8dU6JdGt2l/39jySP31noudcFhDL8ooufP
 yVoJsBbEkO8iJ24fk7lYrYtg2yXAGi6jU9Gi8WaGcA==
X-Google-Smtp-Source: AFSGD/WSKQNt6trakD0WZgJFVEZ/HFHbKPf61xg/m2kFM3J3PNhSIJHQGgCKPvIfpbKWxkb5tQP1z95XAd9yAvK9YE4=
X-Received: by 2002:a1c:a84f:: with SMTP id r76mr9216138wme.16.1544416727742; 
 Sun, 09 Dec 2018 20:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181203115850.GB8040@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181203115850.GB8040@e107981-ln.cambridge.arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Mon, 10 Dec 2018 07:16:17 -0300
Message-ID: <CAFZiPx1cXVWi0vLA4ZtOTeObXg8RtvFX+m31NM2Ezqzq7ymPaA@mail.gmail.com>
Subject: Re: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe
 support for NXP LX SoCs
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_203859_757837_39D0BF7A 
X-CRM114-Status: GOOD (  19.96  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, xiaowei.bao@nxp.com,
 linux-pci@vger.kernel.org, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 linux-kernel@vger.kernel.org, Leo Li <leoyang.li@nxp.com>,
 "M.h. Lian" <minghuan.lian@nxp.com>, robh+dt@kernel.org,
 Mingkai Hu <mingkai.hu@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Lorenzo,
You are right, I reviewed few DT files, will need some time to review
this train.
I will start doing it in a while.

Thanks for pitching in.

Thanks.

On Mon, Dec 3, 2018 at 8:58 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Nov 06, 2018 at 01:19:03PM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > This patch set is aim to refactor the Mobiveil driver and add
> > PCIe support for NXP LX series SoCs.
> >
> > Hou Zhiqiang (23):
> >   PCI: mobiveil: uniform the register accessors
> >   PCI: mobiveil: format the code without function change
> >   PCI: mobiveil: correct the returned error number
> >   PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
> >   PCI: mobiveil: correct PCI base address in MEM/IO outbound windows
> >   PCI: mobiveil: replace the resource list iteration function
> >   PCI: mobiveil: use WIN_NUM_0 explicitly for CFG outbound window
> >   PCI: mobiveil: use the 1st inbound window for MEM inbound transactions
> >   PCI: mobiveil: correct the inbound/outbound window setup routine
> >   PCI: mobiveil: fix the INTx process error
> >   PCI: mobiveil: only fixup the Class Code field
> >   PCI: mobiveil: move out the link up waiting from mobiveil_host_init
> >   PCI: mobiveil: move irq chained handler setup out of DT parse
> >   PCI: mobiveil: initialize Primary/Secondary/Subordinate bus number
> >   dt-bindings: pci: mobiveil: change gpio_slave and apb_csr to optional
> >   PCI: mobiveil: refactor the Mobiveil driver
> >   PCI: mobiveil: continue to initialize the host upon no PCIe link
> >   PCI: mobiveil: disabled IB and OB windows set by bootloader
> >   PCI: mobiveil: add Byte and Half-Word width register accessors
> >   PCI: mobiveil: change prototype of function mobiveil_host_init
> >   dt-bindings: pci: Add NXP LX SoCs PCIe controller
> >   PCI: mobiveil: add PCIe RC driver for NXP LX series SoCs
> >   arm64: dts: freescale: lx2160a: add pcie DT nodes
> >
> >  .../devicetree/bindings/pci/lx-pci.txt        |  52 ++
> >  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
> >  MAINTAINERS                                   |  10 +-
> >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 157 ++++
> >  drivers/pci/controller/Kconfig                |  11 +-
> >  drivers/pci/controller/Makefile               |   2 +-
> >  drivers/pci/controller/mobiveil/Kconfig       |  34 +
> >  drivers/pci/controller/mobiveil/Makefile      |   5 +
> >  drivers/pci/controller/mobiveil/pci-lx.c      | 222 +++++
> >  .../controller/mobiveil/pcie-mobiveil-host.c  | 622 +++++++++++++
> >  .../controller/mobiveil/pcie-mobiveil-plat.c  |  54 ++
> >  .../pci/controller/mobiveil/pcie-mobiveil.c   | 245 +++++
> >  .../pci/controller/mobiveil/pcie-mobiveil.h   | 221 +++++
> >  drivers/pci/controller/pcie-mobiveil.c        | 861 ------------------
> >  14 files changed, 1625 insertions(+), 873 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
> >  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
> >  create mode 100644 drivers/pci/controller/mobiveil/Makefile
> >  create mode 100644 drivers/pci/controller/mobiveil/pci-lx.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
> >  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
> >  delete mode 100644 drivers/pci/controller/pcie-mobiveil.c
>
> Subrahmanya,
>
> for the records, this is the driver *you* are maintaining, aren't you ?
>
> We ask developers to be added to the MAINTAINERS list in order to hold
> them accountable, merging a driver upstream means that you need to
> actively maintain it, which in turn means reviewing series affecting
> its code, like this one.
>
> I will have a look too but it is your responsibility to review these
> patches and ACK them accordingly.
>
> So I strongly suggest you start doing it please.
>
> Thanks,
> Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
