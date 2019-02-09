Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603462084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QaOuiSWG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nBD183x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603462084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VZie3t4fwZwS501H5udhGAGSdZWxDIET34TcRCp83F0=; b=QaOuiSWGdeCUlE
	mvgu4Yxsir5G40vdh8/0wwZf/sWQYjVwgs3XlrxxzLR4BegfzXz9/jEYU8++cGh4q49Zo5+F/YR+B
	RbmjLHudiLy/M3CmRBBz1+IldIZoICP6gIEd0dpHf529X7WWX9x4VDVCOHbCoYb/miUsn5kTpkr4J
	lLj/H3bFeqqOHUIChklSqmvmpxbzLwX/saVhvJFqzAPyq0ZiaIlAH9aMdIKhknZ8eFyJcjAl8X++X
	JGnTIR3GJWrjFmdfpAYyPmEkiN88NgRPbfb6l/bB/NUqEp9i3xpZ73SFvzFcTMNwjtRUbC7p1yKjp
	pbCssK6rL6/ia8DWR5Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsXBv-0005Nr-AB; Sat, 09 Feb 2019 18:17:27 +0000
Received: from perceval.ideasonboard.com ([213.167.242.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsXBr-0005Mh-GP; Sat, 09 Feb 2019 18:17:25 +0000
Received: from pendragon.ideasonboard.com (85-76-143-97-nat.elisa-mobile.fi
 [85.76.143.97])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1A932E2;
 Sat,  9 Feb 2019 19:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1549736230;
 bh=t0GNSj2MkvQASbyGDRPGjxV1mW30FaJBbB9de/RdDjI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nBD183x5muW9TFd3D1A39fuZOygaD7IpVt4UdTyGzrXARx643CfWM0fw8nfTsn1I4
 gtY6fc8oPxJSXYhMbReIT9j59NyRBjcAM6DBeLwlC+qcuUIIdf7CfTXMYpaOc9oi9f
 Fs38M5ej4XXvZAtgRsZqPXPB3sFGiYyoEJYHzECg=
Date: Sat, 9 Feb 2019 20:17:05 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH V0 1/7] [media] dt-bindings: mt8183: Add binding for
 DIP shared memory
Message-ID: <20190209181705.GB4505@pendragon.ideasonboard.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
 <1549020091-42064-2-git-send-email-frederic.chen@mediatek.com>
 <20190209155907.rbgwbdablndcesid@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190209155907.rbgwbdablndcesid@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_101723_848833_EDD26E3D 
X-CRM114-Status: GOOD (  19.86  )
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
Cc: Sean.Cheng@mediatek.com, Frederic Chen <frederic.chen@mediatek.com>,
 Rynn.Wu@mediatek.com, christie.yu@mediatek.com, srv_heupstream@mediatek.com,
 holmes.chiou@mediatek.com, Jerry-ch.Chen@mediatek.com, tfiga@chromium.org,
 jungo.lin@mediatek.com, sj.huang@mediatek.com,
 laurent.pinchart+renesas@ideasonboard.com, hans.verkuil@cisco.com,
 matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 09, 2019 at 05:59:07PM +0200, Sakari Ailus wrote:
> Hi Frederic,
> 
> Could you cc the devicetree list, please?
> 
> On Fri, Feb 01, 2019 at 07:21:25PM +0800, Frederic Chen wrote:
> > This patch adds the binding for describing the shared memory
> > used to exchange configuration and tuning data between the
> > co-processor and Digital Image Processing (DIP) unit of the
> > camera ISP system on Mediatek SoCs.
> > 
> > Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
> > ---
> >  .../mediatek,reserve-memory-dip_smem.txt           | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt
> > new file mode 100644
> > index 0000000..0ded478
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reserved-memory/mediatek,reserve-memory-dip_smem.txt
> > @@ -0,0 +1,45 @@
> > +Mediatek DIP Shared Memory binding
> > +
> > +This binding describes the shared memory, which serves the purpose of
> > +describing the shared memory region used to exchange data between Digital
> > +Image Processing (DIP) and co-processor in Mediatek SoCs.
> > +
> > +The co-processor doesn't have the iommu so we need to use the physical
> > +address to access the shared buffer in the firmware.
> > +
> > +The Digital Image Processing (DIP) can access memory through mt8183 IOMMU so
> > +it can use dma address to access the memory region.
> > +(See iommu/mediatek,iommu.txt for the detailed description of Mediatek IOMMU)
> 
> What kind of purpose is the memory used for? Buffers containing video data,
> or something else? Could the buffer objects be mapped on the devices
> based on the need instead?

And could CMA be used when physically contiguous memory is needed ?

> > +
> > +
> > +Required properties:
> > +
> > +- compatible: must be "mediatek,reserve-memory-dip_smem"
> > +
> > +- reg: required for static allocation (see reserved-memory.txt for
> > +  the detailed usage)
> > +
> > +- alloc-range: required for dynamic allocation. The range must
> > +  between 0x00000400 and 0x100000000 due to the co-processer's
> > +  addressing limitation
> > +
> > +- size: required for dynamic allocation. The unit is bytes.
> > +  If you want to enable the full feature of Digital Processing Unit,
> > +  you need 20 MB at least.
> > +
> > +
> > +Example:
> > +
> > +The following example shows the DIP shared memory setup for MT8183.
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +		reserve-memory-isp_smem {
> > +			compatible = "mediatek,reserve-memory-dip_smem";
> > +			size = <0 0x1400000>;
> > +			alignment = <0 0x1000>;
> > +			alloc-ranges = <0 0x40000000 0 0x50000000>;
> > +		};
> > +	};

-- 
Regards,

Laurent Pinchart

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
