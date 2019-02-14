Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5704AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:34:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262752229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6uJuB9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262752229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3vLoJVIkI6lKSR9R8Ojh0ZE/Df9bcIcgk+eUe5S59sw=; b=O6uJuB9CbH5zaF
	t33X7uGjnCqlGmzu8VBIuNsWsb1WEc6CWo0U657EzJ3gY7x/MXaeKMObVmcqvK3pYxxgY9BXvgoO2
	gYZOK/VoCVCKix1quFRQN+5gQxhzdYkMCrNN2VEF+uuNij0le03Iy4sR7wRfe5rBzn2+62MEXb6qy
	BPcPF+LoXvg0H2AUUmSlV4TqlDvgKbKHxLypJpi6v+aJE4Ba2Lf06N66dSr4Warg/fbhrTIciS5FJ
	999yyGMCe6Sf4CvZ8gC0mJHhfd5/piu0X9i3dMd7uOBs54eM8F+pwJ46UtXZEwgNpEMJMpsZ5PkiB
	u4poCgc/2BK/S2beVmXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guBWw-0003Ih-0n; Thu, 14 Feb 2019 07:33:58 +0000
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guBWs-0003Fr-8R; Thu, 14 Feb 2019 07:33:56 +0000
Received: from [192.168.2.10] ([212.251.195.8])
 by smtp-cloud7.xs4all.net with ESMTPA
 id uBWWgIMxHLMwIuBWZgOLfO; Thu, 14 Feb 2019 08:33:45 +0100
Subject: Re: [RESEND PATCH v4,1/3] media: dt-bindings: media: add
 'assigned-clocks' to vcodec examples
To: Yunfei Dong <yunfei.dong@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>
References: <1550111093-7057-1-git-send-email-yunfei.dong@mediatek.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3f77d34a-a2a4-a2c1-a4e6-32669ff69357@xs4all.nl>
Date: Thu, 14 Feb 2019 08:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550111093-7057-1-git-send-email-yunfei.dong@mediatek.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfBugUWMcmJhaAPPMSjla3U+JKeQ1EE/g/hB7syAzumF6XudhzAvX5uiNYtF9J+g5kf29qqmLLPeh6HBnrvaxXZZYmPAAexBFSRhKLEJxv72lpA6dywQg
 3VJYP/HEePYZhzT8yzUXUZZMTW7J5QHI3yIB/1SgA9FEnYxwZ/DeF9lPTlleZluGT0Sdz21Tb87akM55Iorw2qtYOFRCVya185Qvj11ULEQEcQKufGfbgslI
 l9bdwhXDOToFFn1+hGD7TSFnA1L8b7zenmNBr7mFzgyESDiCyiy2OBbUlphxwiuYf5uJyXH5GbQTpqouF5lMjHqtHszrVENh/L/K+XFXqo+i5/zO0MnpVKMC
 NvI9LXjhoT9WCsnzq3USVIxQpn4o5dPfbdL3CltMQAynZSwUWaIcbPp6ZLuhl0X7gfXUOud0s/jNgl0VeBQCaz1PxL651hnPlUkIqtdEMG0uDvn22rZkYxHf
 AW96M5Uxtck2hrm/xgpY4PG4nOgB57mfcjUOVRn8857U7W2U3h3vjZB5L0cMqwLOcPnqc/1TColFrVGZlxVjLdu+W9AlE2XeL3MBIDX9vpruP/hbTskt5kse
 kibisxZYa09XkAXmkZffF4vbTpKOXLpzlZePErCqKheVu8Ap0Lwr/ZVejTx6qaJQfKk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_233354_437859_BE8AFA66 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Qianqian Yan <qianqian.yan@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Yunfei Dong,

Why is this series resent? Patches 1 and 3 have been merged in our
media master tree already.

Regards,

	Hans

On 2/14/19 3:24 AM, Yunfei Dong wrote:
> Fix MTK binding document for MT8173 dtsi changed in order
> to use standard CCF interface.
> MT8173 SoC from Mediatek.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Qianqian Yan <qianqian.yan@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/media/mediatek-vcodec.txt  |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> index 2a615d8..b6b5dde 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> @@ -66,6 +66,15 @@ vcodec_dec: vcodec@16000000 {
>                    "vencpll",
>                    "venc_lt_sel",
>                    "vdec_bus_clk_src";
> +    assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>,
> +                      <&topckgen CLK_TOP_CCI400_SEL>,
> +                      <&topckgen CLK_TOP_VDEC_SEL>,
> +                      <&apmixedsys CLK_APMIXED_VCODECPLL>,
> +                      <&apmixedsys CLK_APMIXED_VENCPLL>;
> +    assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>,
> +                             <&topckgen CLK_TOP_UNIVPLL_D2>,
> +                             <&topckgen CLK_TOP_VCODECPLL>;
> +    assigned-clock-rates = <0>, <0>, <0>, <1482000000>, <800000000>;
>    };
>  
>    vcodec_enc: vcodec@18002000 {
> @@ -105,4 +114,8 @@ vcodec_dec: vcodec@16000000 {
>                    "venc_sel",
>                    "venc_lt_sel_src",
>                    "venc_lt_sel";
> +    assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
> +                      <&topckgen CLK_TOP_VENC_LT_SEL>;
> +    assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
> +                             <&topckgen CLK_TOP_UNIVPLL1_D2>;
>    };
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
