Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51413C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:49:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B772086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BerHytyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B772086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wgDwGQQWZTFOqHuQQmpCgdBMt6Ft/Zt6AGkvoOBrNiM=; b=BerHytyXn+aND9
	KK8Wcx4ZSjYsWC4XcGzDlO4uETrA5twunEczbsazARUgI2urL40nq4HLGMWmgME0RoP+6qP1hr6VN
	nhMbZcyqkOIXazUCW1VY7A2uyUJr2Zg5Cx3o0wJXbmX8czyXpI9SwegFLReQphUuynzwIEg7hDpYw
	n+QrSisUpdgKpOmcS/cqaeS+Ljlu8TF0BVoWzrfVQ0dFm0y4dVqnw5JfL9Wms/yKCpp1Gx0S5wtl0
	7JZj3XnqoLihL/TN05oB6t0MOfDJm1xK1+wcrPNPLgL55XEtkNeNLbmM4Duil/2w1znHrX7KI6yfh
	4NggG4qe6ZigX4lxWIDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouvP-0005pO-Ks; Wed, 30 Jan 2019 18:49:27 +0000
Received: from mail-ot1-f44.google.com ([209.85.210.44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouvM-0005oz-Eg
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:49:25 +0000
Received: by mail-ot1-f44.google.com with SMTP id s13so545492otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tYYlhSahpUNu07gio0txRqogQXhjXBtvhFKl/XrSWBY=;
 b=QqgiGTBx2SznXilFA94vdMiSTBUynLS1Imz5x9daG/Yj2Rtkw6umbmyk3bl/SD2/Jf
 1ZhvmrkOfCWhUg9BvgF+3wt9ynF92tf1bcgJZqRn0ZuYbnuNM7Mt9pTz1UirHPpMeu75
 FAlBQqzSC20xcnXkRcREar5jvfv3joD1g4/3elRFaH7xttn4BkGYi6Q23nGSmZnS8Abs
 n73a3C5Lv0Fz/jt77g6dc+/duIfz/mQMTSPR4oJQRSN75SqxsnfxTcp4RNnyV4Ho6urz
 Pg0ftf6wSs0ubalrWD8/FhQeuTcClt0KTxQ6BfNRsD+Wlb0+EHf14oGoMvhKxI24YeV+
 QbDw==
X-Gm-Message-State: AJcUukcJfk5fKqIIuCDOdeGWgf8UivQyL4icyk0lZZgq4k/7btv7USae
 J+z7cKl7jHtFyANoR5/q1A==
X-Google-Smtp-Source: ALg8bN54bW836SloDXShRDMPNqN03yId2mioatzz5oGhCooWcTX9jq6BWbBL79OHo+A7V8eZwjdtWw==
X-Received: by 2002:a9d:177:: with SMTP id 110mr23986512otu.26.1548874163431; 
 Wed, 30 Jan 2019 10:49:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t2sm795044otl.4.2019.01.30.10.49.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 10:49:22 -0800 (PST)
Date: Wed, 30 Jan 2019 12:49:22 -0600
From: Rob Herring <robh@kernel.org>
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCHv3 22/27] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4  controller
Message-ID: <20190130184922.GA13423@bogus>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-23-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129080926.36773-23-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_104924_488963_A0F71498 
X-CRM114-Status: GOOD (  11.20  )
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
 "Z.q. Hou" <zhiqiang.hou@nxp.com>,
 "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
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

On Tue, 29 Jan 2019 08:10:49 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe Gen4 controller DT bindings of NXP Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - Change back to use an new doc for Layerscape PCIe Gen4 DT bindings.
>  - Switch the order of "csr_axi_slave" and "config_axi_slave".
> 
>  .../bindings/pci/layerscape-pci-gen4.txt      | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci-gen4.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
