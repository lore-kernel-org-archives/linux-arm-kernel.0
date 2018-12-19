Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0FC21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VSbA6Iyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0FC21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVoBUP1l4z5PRRvUyItx3rr9dd/FMnw3j+LyqZVGX3I=; b=VSbA6IydSkxEC4
	U/0+AQR+/pAW9Id/7XvsFoVeYvWp6+BioXhLJR7IEvqg1sVbmZ+kd9uM9bad1XVeNlkEPnunnfmCq
	D9Yl6KJDGkeKqvnsNYSpMJSj2AHwb2So6Egzgfco9zQVehKvO+602T4aVALyo7sDK9R3HkYoie7IO
	qFn4ETp3o+qRXUbHXxltJs56thnGFkDY0cHzjEdVNY/zcQ6AxD9FetOn2cEPEXQO57QiyPQ/Nu+fc
	jExCx2KbtD95KI16+hLQh8qrI9O+nH8r2akfKkIriBVu772HAiB9LZBwUXCRuWqX6UN+dfBzuUvYd
	OiCl68jbvie2PQk/aVgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZXs-0004Vt-8J; Wed, 19 Dec 2018 10:57:44 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZXo-0004UQ-UN; Wed, 19 Dec 2018 10:57:42 +0000
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 19 Dec
 2018 18:57:48 +0800
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring
 <robh@kernel.org>
References: <1545120286-129258-1-git-send-email-hanjie.lin@amlogic.com>
 <1545120286-129258-2-git-send-email-hanjie.lin@amlogic.com>
 <CAFBinCD1x7jcJJx78yNx87MOmKQ2HuSBeRpDRQE0hyNCwm1JAg@mail.gmail.com>
From: Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <e3cce5d7-354c-4042-bf76-c22f3893d72c@amlogic.com>
Date: Wed, 19 Dec 2018 18:57:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAFBinCD1x7jcJJx78yNx87MOmKQ2HuSBeRpDRQE0hyNCwm1JAg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_025740_973342_1AB434BF 
X-CRM114-Status: GOOD (  16.01  )
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
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, linux-pci@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Yue Wang <yue.wang@amlogic.com>, Carlo Caione <carlo@caione.org>,
 Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 linux-amlogic@lists.infradead.org,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Liang Yang <liang.yang@amlogic.com>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018/12/19 7:14, Martin Blumenstingl wrote:
> Hi Rob, Hi Hanjie,
> 
> (sorry for being late with my question)
> 
> On Tue, Dec 18, 2018 at 9:05 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
> [...]
>> +- reg-names: Must be
>> +       - "elbi"        External local bus interface registers
>> +       - "cfg"         Meson specific registers
>> +       - "phy"         Meson PCIE PHY registers
> I have learned that there are two PHY register designs:
> - AXG only has a PCIe PHY
> - G12A has a PHY which supports PCIe and USB 3.0. The PCIe part of
> this PHY design is compatible with AXG, but this design also supports
> a USB 3.0 port (it's an exclusive choice: either PCIe *or* USB 3.0)
> 
> The PCIe controller itself is identical on both, AXG and G12A.
> This patch adds support for the AXG PCIe controller and PHY within one
> device-tree node.
> 
> For G12A I propose to add a separate "phys" property with a phandle to
> the "combo" PCIe and USB3.0 PHY - this can be part of a separate patch
> though.
> I would like to know whether it's OK that for AXG the PCIe PHY is
> described in the same device-tree node as the PCIe controller (in
> other words: we're not using a "phys" property here)?
> 
> 
> Kind Regards
> Martin
> 
> .
> 

hi matrin,

We do had a dedicated PHY driver for a time at the begining
of this patch series, but we decided to remove it and integrate
into the controller driver after series reviews and disscussions,
and the main reason is it's too overkill to have a dedicated 
PHY driver which only do the RESET job.

Of course we can consider the dedicated PHY driver for G12A upstream
in future.

thanks
hanjie


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
