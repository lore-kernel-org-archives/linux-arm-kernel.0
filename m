Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E59C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B217620C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8+Z7lbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B217620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1URySZNnlau6zwW/HaZRgVhEjohWkKhwjToqVpNJ6dg=; b=J8+Z7lbMwgR0zM
	0dV04V+mwprnlW7lo0CMYdjDp02A4T8FN7r/LQnpfFcSmvn601xSD/QmNqRCitU2DBHo/D1jWl9lq
	6Q5KqrwhxWMXDF9AQuA5mbzyCrdHJMUlXag6h2o5X1tjkf/YJQrfNNVYtjPrZH0Rl3tcW+s75NMb/
	Xwq+K4HLWcGpPusRfkHIxbVlWqPdkaZ/kJmCpHW17/Nr/3qwT1h/V/+6E4UPFPN1tWQxs9pYhwuTt
	MUO+xWmZKmv8JsvM4unhd2HDTkzSi1eRAAMxIkGDO8T/p06Dvh8Xy65bYiJdlDgSt3PQ6tC7jDNbR
	5ujDCoe3kpDYZMQhTgYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvl6F-0003MP-OL; Mon, 18 Feb 2019 15:44:55 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvl6A-0003Kg-0M; Mon, 18 Feb 2019 15:44:51 +0000
Received: by mail-ot1-f65.google.com with SMTP id g1so28889881otj.11;
 Mon, 18 Feb 2019 07:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ce+FsWm+x9HHNqzsqHfs3p93v9ypTpSv8t2GcyaBUcc=;
 b=a6d6c6cc1Ek+JD0J9aJBGkxyedE1xyLDDChPVrA/Qpg6FGLEfSXUGeWgoOb7v8fmY5
 eVizRIRwEypLSWHY8fAB/KX6+dyXzQfyXPJOSOSFoQCLnhdnCioMXtLhsd4xsNQLUTWw
 qCv1q2fseaL7nlUbDQsE0YfbFo1Th1mJ4Llykz+X9I3kLqCXAFnMZANjbPbQZkfOTl77
 Vr8VMuV065G3uoN2PmxVHC+mCLgCJjzV6ngIeJ1w1v0zKclBML90k9rBfNiLPcnei1zq
 qYoksh7hDpWRoet7C3ipgkCG6Y+Vf29rUnEjV6ixxzWz4r44nIdMsa+KcIM2O2Vg7lf9
 mnsw==
X-Gm-Message-State: AHQUAuYILN3pwTvLQD8KKe4MsTZX/Fg6/2gxh6D4kuT/JP8ki982H+KO
 /XnQzTKNSV/9lUS8gcjFTA==
X-Google-Smtp-Source: AHgI3IbA23hDY/RUuikmiosxCu8vFGpm3R1B3EOQdo8tRoA1IkwStmu0eNjVD6fm8YhD+yYR4MTFzw==
X-Received: by 2002:a9d:6206:: with SMTP id g6mr14483608otj.338.1550504686822; 
 Mon, 18 Feb 2019 07:44:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y37sm3695809ota.17.2019.02.18.07.44.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 07:44:46 -0800 (PST)
Date: Mon, 18 Feb 2019 09:44:45 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v6 01/22] dt-bindings: mediatek: Add binding for mt8183
 IOMMU and SMI
Message-ID: <20190218154445.GA28558@bogus>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550394300-17420-2-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_074450_049945_6C16233B 
X-CRM114-Status: GOOD (  18.19  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 17 Feb 2019 17:04:39 +0800, Yong Wu wrote:
> This patch adds decriptions for mt8183 IOMMU and SMI.
> 
> mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
> 
> The mt8183 M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                        ----------
>                        |        |
>                    gals0-rx   gals1-rx
>                        |        |
>                        |        |
>                    gals0-tx   gals1-tx
>                        |        |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-----+-----+--------+-----+-----+-------+-------+
>   |     |     |        |     |     |       |       |
>   |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
>   |     |     |        |     |     |       |       |
>   |     |     |        |     |     |       |       |
>   |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
>   |     |     |        |     |     |       |       |
> larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
> disp  vdec   img     cam    venc   img    cam
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Compared with mt8173, we add a GALS(Global Async Local Sync) module
> between SMI-common and M4U, and additional GALS between larb2/3/5/6
> and SMI-common. GALS can help synchronize for the modules in different
> clock frequency, it can be seen as a "asynchronous fifo".
> 
> GALS can only help transfer the command/data while it doesn't have
> the configuring register, thus it has the special "smi" clock and it
> doesn't have the "apb" clock. From the diagram above, we add "gals0"
> and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.
> 
> >From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
> Control Unit) is connected with smi-common directly, we can take them
> as "larb2", "larb3" and "larb7", and their register spaces are
> different with the normal larb.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Rob,
> In this version, I changed the picture in the binding and list the
> detailed SoCs which has "bclk" and "gals". So I don't keep your R-b.
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  30 ++++-
>  .../memory-controllers/mediatek,smi-common.txt     |  12 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   4 +
>  include/dt-bindings/memory/mt8183-larb-port.h      | 130 +++++++++++++++++++++
>  4 files changed, 170 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
