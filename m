Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F916C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:04:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47582145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+vhaG0O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="a0lt9vja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47582145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ssc3nxV0tGJE3ID4pOZ0RecXY3HQ5/virPcS55aAw98=; b=K+vhaG0OsgNHj3
	sxQfVWbt8vfbd4Bc1/DfDhUbBrx7sbzMVDebZ6OyxFKlkTkXIGujL1tKWmXpIgq7FGHYfdGC3ved2
	cpkjGXVev8V0pvkIup5SMiiiaoDVQO8Fit0B6ryo8RLQX8EP2SRRVzTT8XDZlkP6qPK6FHBMfADU5
	2gxEvLIb2uAuxK3uCUxD4pfS3SDGHFbhGemHnAWojwGT+joJbELxdQdsUnevRUM/ZRhhxQDss1dwU
	KeE/a9P99nAc9HZz0VVnT1So4xi2joQHzGt5Hi4cRlNsVmWem55/EvH8MWv8KlwVSv3pmhheYduS5
	gi/yWmVEjl6k4xAT3vaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqtqN-0006ki-8A; Tue, 05 Feb 2019 06:04:27 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqtqJ-0006kH-Ua
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 06:04:25 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so2274596wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E8Nz/JOD+e1xoqAI4YK+0goMEU7txF8Kn0+PiGymNa8=;
 b=a0lt9vjaYGvo5ZjCMKI4qBCmuxJB3MEqbdXjeKZbh+T2f2nZ72O8/RHqWxV7l6HJYZ
 UCE2tm6/FROvTqIC+Nj4Xtk13boNIRpa4eHoE2/95EH9a+MyYFmfR2YIAwrsfxbWN3ol
 k0v2t9jjDyZw3M4IrxpaQEeGGibrzRh/SKAfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E8Nz/JOD+e1xoqAI4YK+0goMEU7txF8Kn0+PiGymNa8=;
 b=eekK55mKRUIffcalYqwEAa5CbWRgFJUINtoeC+ezld2XQIpmrrOvj8vPoueGySgq+/
 PfAxILVzjyUptaAFkvY0UTqwTdI05FIKk9smNvEBrd87XbkEcW9bXBhibNMqE+3nBXSe
 ldgKPaemrQpyfHmKHUAB8qso+dPKauIAEoDjnnOCyQA4Y6sEH/ixP3MQOa68uSdYVn8U
 zst/CgWpsktXAIsR1PkGF0jvYQGChvMjLA0sZeX943KdmuF9TGb38yI8Jhg4JAw4s5bB
 VpEks+WLIPZ5Pmu3hFzfVjP1pvfoRHj/mKIZw+3xADMvh4/2yeMPWs55vY0596eAxAga
 sd6Q==
X-Gm-Message-State: AHQUAuZorP1yQkVuhF1qLxKGnToaAeEjmdLaMx70D8rMpsKLwHtCbWrJ
 9rkgg6roxCLhBSyb36w62zj8bmXZeeMs3tJrbeC2BA==
X-Google-Smtp-Source: AHgI3IZABnEpCunPrjrSCncSfkYCrTT1Vrxws6KuAXMByp9HYmZCCEG2EFEppAWPTIq00CvmKwpJrXSlEI29F2o99Mw=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr2123021wrr.105.1549346662212; 
 Mon, 04 Feb 2019 22:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-6-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 5 Feb 2019 11:36:56 +0530
Message-ID: <CAFZiPx1eiMYgpaT4q219hcfOGqBB1XkZvX5xjAM5mApiMSVMxw@mail.gmail.com>
Subject: Re: [PATCHv3 05/27] PCI: mobiveil: correct PCI base address in MEM/IO
 outbound windows
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_220423_986015_BF057392 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> It should get PCI base address from the DT node property 'ranges'
> to setup MEM/IO outbound windows instead of always zero.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
> IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a0dd337c6214..8ff873023b5f 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -630,8 +630,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>
>                 /* configure outbound translation window */
>                 program_ob_windows(pcie, pcie->ob_wins_configured,
> -                                  win->res->start, 0, type,
> -                                  resource_size(win->res));
> +                                  win->res->start,
> +                                  win->res->start - win->offset,
> +                                  type, resource_size(win->res));
>         }
>
>         /* setup MSI hardware registers */
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
