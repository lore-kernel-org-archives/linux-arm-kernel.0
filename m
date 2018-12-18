Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:22:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A65217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fm9Zl2Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A65217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yWs1J3drjjqzyiXGN3gTVVFOzvY83yk+SnjcDMssCsk=; b=Fm9Zl2RelxhkOR
	CnQ7o1fZV2JQvdF6eE3itmH7zpprxwyWIipTfKkLR9dod/jXTaJo1P/F64jJ5XAGQPmmGHxD0sh5A
	8RTDNOEeAR/CNj2X7TYLt5fRcX/SPupm3Sbv4xwlMWJWtGXqwb6pM8WC/NbNdEEitBZnWKJMlBTas
	+zeYrllLbPcROIT9tbbGrkwhDBEPsJCofG4b96rQ8VNVjdZWFbVFLVRKcW8RTLKYwVHb8lTf12j7Z
	fw+GXL3d1abzpsHJM50XRzSr5koIx8/0R+Lqlbv8dSvPdrsCb4QUcaHc5YUpysRPpdRUaKo0VtykH
	J6MNtp3O637yzOCP4mxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZJ4T-00035Q-4w; Tue, 18 Dec 2018 17:22:17 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZJ4Q-00034H-8b
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 17:22:15 +0000
Received: by mail-ot1-f68.google.com with SMTP id n8so16388202otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 09:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DMHyOOWj4pu3P3Aw+qJ/8FlU5UsydyVqWJ0oW3b++jM=;
 b=t0G/y/2oKtwpG2frh51J7g8YMWfCtXIzIIng+jnAa1Qh8SAlp4C0DRIC7LLvxnJgo4
 z90S3/DBpdXlUfl4B9TtJP4ze/IksOx17ySAbfCj5EhxdQTOVq7dG2KattnFPExKHVzw
 hjGV1PPt+ELOcn+amPvxz9jblY7Pg82u9ZspfcKNhFCH5zn072hY+nQ0A7HzuoY+f7hK
 SkfL/uBifSvdHH89dplf7q9ixBVA7frxbqqOob3xgCKlR+wGTyVS5BRWb+/FDIr5rNnw
 I3B2UGRF0zZE3uISPLidEeQWckS3zdewgKpqsH9ncwUSUjeNGbKxM/tYWMJ34PCIEzEO
 yZMQ==
X-Gm-Message-State: AA+aEWb0AbmLPQ8XhT+g/tgzHuVBgvLi2jwxSI62vqCh8woKHA5oTI0E
 3FOyOzYDAkt98HFo9r4wQA==
X-Google-Smtp-Source: AFSGD/XvE5akPsPl+hv69YhYfhlyWa9itOiLfWisJ+0+3xPRIWfC2bVVuuYmCjsJGkS9MhWU4BC8Fw==
X-Received: by 2002:a9d:4a87:: with SMTP id i7mr13221148otf.178.1545153723057; 
 Tue, 18 Dec 2018 09:22:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m2sm9516179otp.34.2018.12.18.09.22.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 09:22:02 -0800 (PST)
Date: Tue, 18 Dec 2018 11:22:01 -0600
From: Rob Herring <robh@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
Message-ID: <20181218172201.GA16590@bogus>
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
 <20181214221640.25354-2-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214221640.25354-2-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_092214_307383_3D4930E0 
X-CRM114-Status: GOOD (  16.60  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, vireshk@kernel.org,
 freedreno@lists.freedesktop.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 03:16:39PM -0700, Jordan Crouse wrote:
> Add documentation for the interconnect and interconnect-names bindings
> for the GPU node as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 8d9415180c22..19b5ae459fdb 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -19,6 +19,9 @@ Required properties:
>    * "mem_iface"
>  - iommus: optional phandle to an adreno iommu instance
>  - operating-points-v2: optional phandle to the OPP operating points
> +- interconnect: optional phandle to a interconnect provider.  See
> +  ../interconnect/interconnect.txt for details.
> +- interconnect-names: Name string for the interconnects.
>  - qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
>    control the power for the GPU
>  
> @@ -68,6 +71,9 @@ Example a6xx (with GMU):
>  
>  		operating-points-v2 = <&gpu_opp_table>;
>  
> +		interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
> +		interconnect-names = "gfx-mem";

There's not really any point to having *-names when there is only 1 
value.

> +
>  		qcom,gmu = <&gmu>;
>  	};
>  };
> -- 
> 2.18.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
