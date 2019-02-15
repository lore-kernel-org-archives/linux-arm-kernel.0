Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C09FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:59:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38796206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CtRg1Jbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38796206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VzGlRx3eWQJLyr3g9mQI5reO0KcmRC3LLQAeTvQclw=; b=CtRg1JbgHGoDT0
	VWMh8VMJmWyqiB16rwcybD29fFaYYIhi4M8kpynDCz1LW31VPW/2AOnb/6182miPvxPOIsXZFCCOW
	UnSK1vkQ9XvjusxChdQMuvgexkFfUkXQdpW3xXR63uuk1S+4/lX8zKL9tX0sMNsi/hcNiJAyWOOMM
	IokeJUO6MGCNWx/YP5K/a019+Z/ZGQ42U0x8jaFdQswTLlUJ6dZd4TBZTebIO2T2KO8VIQNozPoAP
	z6fQ4tvr08PPO1IsDDheoRfC+8mB9LnBp5XnhIHs/38EsCElBO0UFLeIdmtYb/e1M3x+WUQb+vfBU
	7maAnGB5WFKCDOiP/pPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guexU-0002T8-VZ; Fri, 15 Feb 2019 14:59:20 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guexR-0002ST-Bj; Fri, 15 Feb 2019 14:59:18 +0000
Received: by mail-qt1-f194.google.com with SMTP id b8so11100605qtr.9;
 Fri, 15 Feb 2019 06:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vB5Hxnougqsf7aojhxU3N93bTIMAReQ4+DjbflBf9Og=;
 b=AhG1M/VlVuJ0SLeJVBddevf3DMFIcu9njOTt8p0IfyocHzVHCfUSdDHaeAfajHDr+k
 akqfLc7SsVMz0LzKBOThVA3iajO2YQyMJs99LAnXb8pT4EnmSlWd1CKVi6uwntyOH7mO
 nysra/myTGcSggt+Ftr3amlUAPjp2cw75wEzLoCDXCsfHC7q8eeI7Os3DWaMmxwVUGh8
 V1tovdhYwctPd/EgY0oBCUYLCqhVQy3KmR0TpNczZTgeG2iqnUqDU7wsb/wAHwcQskOP
 UqAGcWCrrvbjNZz4S6LNrovKE81gsbjHFKjDVvvIOBzTWo4clpfa5YrNDROTV19Gm+h9
 KElw==
X-Gm-Message-State: AHQUAuajAamrQvqmS7v5yNbFGmBEo0RJND19q9nSmPkAcFnoG6eG5SOR
 FFmmy4ciT4o80KjtylgcjEsJO+BWwym8gCW+QdQ=
X-Google-Smtp-Source: AHgI3IaLM9JcA/i4tLJkAxw98Qvo5lwG3CJIpl1xHNaXdEU6/JOq7z0cwWk2dpnoSdcZvxhRysEPIKig0h4IkcwbfTU=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr7635045qvn.115.1550242755017; 
 Fri, 15 Feb 2019 06:59:15 -0800 (PST)
MIME-Version: 1.0
References: <d55e396b-0cbc-62a2-7bfd-c988cda086ff@gmail.com>
In-Reply-To: <d55e396b-0cbc-62a2-7bfd-c988cda086ff@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:58:58 +0100
Message-ID: <CAK8P3a0wfWzZ0GTgMDAEPFNM_g5tLMVW=6ZdR+cK1L2cxc=YhA@mail.gmail.com>
Subject: Re: [GIT PULL] Mediatek DT 64 bit updates for v5.1
To: Matthias Brugger <matthias.bgg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_065917_431050_8F6B13A2 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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
Cc: Matthias Brugger <mbrugger@suse.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Erin Lo <erin.lo@mediatek.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, YT Shen <yt.shen@mediatek.com>,
 arm-soc <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 honghui.zhang@mediatek.com, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 9:00 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:

> ----------------------------------------------------------------
> mt2712:
> Add device nodes for usb3, iommu, smi, i2c, spi, pwm,
> mmc, NAND flash and PCIe
>
> mt6797:
> add pinctrl node
> enable uart pins on x20 board
> enable uart pins on EVB
>
> mt7622:
> Add all CPUs to the cooling maps
>
> mt7623a:
> Remove unused binding description
>
> mt7629:
> Add binding description for the SoC and the BananaPi
> based on this chip
>
> mt8173:
> Add all CPUs to the cooling maps
>
> mt8183:
> Add binding description for the SoC

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
