Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0AEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:00:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B039121919
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PblRL/o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B039121919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z/1tEvZd2w2pXMsC5sx+7Jfv+ZDgJctExXmQ7U6u6eo=; b=PblRL/o8nodMtd
	QCbJUcokrOTEBAtxdRQbmiHITC/uNp8bJbmxc+Leu4TpKCfLVgP6JDFwKBeCIu1lppqa/MBwWW2Zd
	lVv6w2pd6fKhuqhtiNRybpCkONy8HBVsc7G5slVbORVvtj+WW36javq101n3QWzP7FNkZyDLJBbX5
	ddYFa5qbpKpZ5KyHd9RwiDDJ5ghbFELV0Hu4oJV//Yu9MMFfcfVqZcfH6KVmh8OMQRP8NmZ4dkHf/
	ct3RUuaxHHJUTfIyEDRsIWve6bOQWDUB1O/osROPfj+CE6/XARR0K0PY3yUzdDM8kyE/0Q/3WzLfM
	VJSSHKGGd4zCnAyUo8Ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsV3D-0000s4-2t; Sat, 09 Feb 2019 16:00:19 +0000
Received: from hillosipuli.retiisi.org.uk ([2001:1bc8:1a6:d3d5::81:2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsV2n-0007uN-Sk; Sat, 09 Feb 2019 15:59:58 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 9BD08634C7D;
 Sat,  9 Feb 2019 17:59:35 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1gsV2V-0000wx-Dm; Sat, 09 Feb 2019 17:59:35 +0200
Date: Sat, 9 Feb 2019 17:59:35 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Frederic Chen <frederic.chen@mediatek.com>
Subject: Re: [RFC PATCH V0 3/7] [media] dt-bindings: mt8183: Added DIP-SMEM
 dt-bindings
Message-ID: <20190209155935.afrrtf3twjmj23sm@valkosipuli.retiisi.org.uk>
References: <1549020091-42064-1-git-send-email-frederic.chen@mediatek.com>
 <1549020091-42064-4-git-send-email-frederic.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549020091-42064-4-git-send-email-frederic.chen@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_075954_609196_755D5511 
X-CRM114-Status: GOOD (  18.28  )
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
Cc: Sean.Cheng@mediatek.com, laurent.pinchart+renesas@ideasonboard.com,
 Rynn.Wu@mediatek.com, christie.yu@mediatek.com, srv_heupstream@mediatek.com,
 holmes.chiou@mediatek.com, Jerry-ch.Chen@mediatek.com, tfiga@chromium.org,
 jungo.lin@mediatek.com, sj.huang@mediatek.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 hans.verkuil@cisco.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Frederic,

Thanks for the patchset.

Could you also cc the devicetree list, please?

On Fri, Feb 01, 2019 at 07:21:27PM +0800, Frederic Chen wrote:
> This patch adds the DT binding documentation for the shared memory
> between DIP (Digital Image Processing) unit of the camera ISP system
> and the co-processor in Mediatek SoCs.
> 
> Signed-off-by: Frederic Chen <frederic.chen@mediatek.com>
> ---
>  .../bindings/media/mediatek,dip_smem.txt           | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt b/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
> new file mode 100644
> index 0000000..5533721
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek,dip_smem.txt
> @@ -0,0 +1,29 @@
> +Mediatek ISP Shared Memory Device
> +
> +Mediatek ISP Shared Memory Device is used to manage shared memory
> +among CPU, ISP IPs and coprocessor. It is associated with a reserved
> +memory region (Please see Documentation\devicetree\bindings\
> +reserved-memory\mediatek,reserve-memory-isp_smem.txt) and

s/\\/\//g;

> +and provide the context to allocate memory with dma addresses.
> +
> +Required properties:
> +- compatible: Should be "mediatek,isp_smem"

s/Should/Shall/

> +
> +- iommus: should point to the respective IOMMU block with master port

s/should/shall/

> +  as argument. Please set the ports which may be accessed
> +  through the common path. You can see
> +  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +  for the detail.
> +
> +- mediatek,larb: must contain the local arbiters in the current Socs.

Perhaps "SoCs"?

> +  Please set the larb of camsys for Pass 1 and imgsys for DIP, or both
> +  if you are using all the camera function. You can see
> +  Documentation/devicetree/bindings/memory-controllers/
> +  mediatek,smi-larb.txt for the detail.
> +
> +Example:
> +	isp_smem: isp_smem {
> +		compatible = "mediatek,isp_smem";
> +		mediatek,larb = <&larb5>;
> +		iommus = <&iommu M4U_PORT_CAM_IMGI>;
> +	};

-- 
Kind regards,

Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
