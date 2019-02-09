Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDFDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:20:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA29220855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hf61KEmH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ANiDUlW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YfzkXkbYl4ax/E9vGptkc3iS8D/XrB3RKKlBq1dKaNk=; b=Hf61KEmHPGFFLU
	13rO5ac58EHJwaIxj+f2f823qh3SFX75lFgAxkCi7BlhFMsXu03dfjOQI0v20XGmmt4am5zKn7mcC
	OBhvEM5tPWyq039XDgW3VYocSHwEGgw03fpAaaTV6jKVcvpLN+QkJZ1YD2W3SHAzm+ou0cO59O5+V
	yiAoY0g4IakZe7znrEUXfxnBIkRFQXleu1Xclfnv/AjqywUkOjOb7DVKFDNJ+bM4AfH7GKMcyaROE
	Z8m382U6YID17b4W8AY54mZ+EU1josdxyRtUpCGj9hWK5mxPStFphhypK1WftkIfqRiwCbahBBekB
	2MuTi7yTUu7awFMR+1tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsXF9-00073i-V5; Sat, 09 Feb 2019 18:20:47 +0000
Received: from perceval.ideasonboard.com ([213.167.242.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsXF6-00072v-PN; Sat, 09 Feb 2019 18:20:46 +0000
Received: from pendragon.ideasonboard.com (85-76-143-97-nat.elisa-mobile.fi
 [85.76.143.97])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F0D52E2;
 Sat,  9 Feb 2019 19:20:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1549736443;
 bh=fB5PYIrIDjVSImRKcoB9DsvNiOCKyRJu5HSSqcAvC7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ANiDUlW7J8jD++Uw4IrhM54ol3lm91ecLi58Jh1RIOKboI9Vdhr0SiFMI3Hk/cTIG
 n8qvgB9zQIhtn5f9rqBQiGSmy8+3EYTTyV26bG/yhTdwKkBV3YaCUxrhmL6ITZOaJ6
 BN4zVlilg4CcyWyDBCD0q0UXoTTNwk+norg9zABc=
Date: Sat, 9 Feb 2019 20:20:34 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC PATCH V0 3/7] [media] dt-bindings: mt8183: Added DIP-SMEM
 dt-bindings
Message-ID: <20190209182034.GC4505@pendragon.ideasonboard.com>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
 <1549020091-42064-4-git-send-email-frederic.chen@mediatek.com>
 <20190209155935.afrrtf3twjmj23sm@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190209155935.afrrtf3twjmj23sm@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_102045_124699_DA7A9C47 
X-CRM114-Status: GOOD (  20.82  )
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

Hello Frederic,

On Sat, Feb 09, 2019 at 05:59:35PM +0200, Sakari Ailus wrote:
> Hi Frederic,
> 
> Thanks for the patchset.
> 
> Could you also cc the devicetree list, please?
> 
> On Fri, Feb 01, 2019 at 07:21:27PM +0800, Frederic Chen wrote:
> > This patch adds the DT binding documentation for the shared memory
> > between DIP (Digital Image Processing) unit of the camera ISP system
> > and the co-processor in Mediatek SoCs.
> > 
> > Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
> > ---
> >  .../bindings/media/mediatek,dip_smem.txt           | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt b/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
> > new file mode 100644
> > index 0000000..5533721
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
> > @@ -0,0 +1,29 @@
> > +Mediatek ISP Shared Memory Device
> > +
> > +Mediatek ISP Shared Memory Device is used to manage shared memory
> > +among CPU, ISP IPs and coprocessor. It is associated with a reserved
> > +memory region (Please see Documentation\devicetree\bindings\
> > +reserved-memory\mediatek,reserve-memory-isp_smem.txt) and
> 
> s/\\/\//g;
> 
> > +and provide the context to allocate memory with dma addresses.

Does this represent a real device (as in IP core) in the SoC ? There
seems to be no driver associated with the compatible string defined
herein in this patch series, what is this node used for ?

> > +Required properties:
> > +- compatible: Should be "mediatek,isp_smem"
> 
> s/Should/Shall/
> 
> > +
> > +- iommus: should point to the respective IOMMU block with master port
> 
> s/should/shall/
> 
> > +  as argument. Please set the ports which may be accessed
> > +  through the common path. You can see
> > +  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > +  for the detail.
> > +
> > +- mediatek,larb: must contain the local arbiters in the current Socs.
> 
> Perhaps "SoCs"?
> 
> > +  Please set the larb of camsys for Pass 1 and imgsys for DIP, or both
> > +  if you are using all the camera function. You can see
> > +  Documentation/devicetree/bindings/memory-controllers/
> > +  mediatek,smi-larb.txt for the detail.
> > +
> > +Example:
> > +	isp_smem: isp_smem {
> > +		compatible = "mediatek,isp_smem";
> > +		mediatek,larb = <&larb5>;
> > +		iommus = <&iommu M4U_PORT_CAM_IMGI>;
> > +	};

-- 
Regards,

Laurent Pinchart

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
