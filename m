Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:50:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DF120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4rb5cxs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0AQvGl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DF120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s/RK2+zdmLeXn5RW1UsPfnIzhf1jrBRu1BCo56h+0Z0=; b=J4rb5cxsnjeEb+
	z63sOx72cn/GVaQd5tZlqXodXuTB2YtfYclp7732B5r4bweGxsqORul6qEECikOTkLHBdk6R7Jouq
	YMtO7II0aM9dIraFHxl54lCOCwHI81NtS4vHnBmDUF6kmPWEITDBzFWaiRCNQ9sXGpBDHLWEeu0yF
	NQDfBD800NDGX8Gs6jJYLskug95ITaQ3AkXcHK5dEOZwFoLgQngybl9K7T9VX9jea/jU0gRjexiPg
	mfM5RGL2jxWK83ulVqubmqiPCgvmdReklRbu52i7krXFd3NPu/AMiYPQdI49eLfYSKwgeNXLUlhvH
	2ls2akyvzAkvm67fc3vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfcyl-0001ao-PF; Sat, 05 Jan 2019 03:50:31 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfcyi-0001aL-Iy
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 03:50:30 +0000
Received: by mail-pl1-x644.google.com with SMTP id u6so18252649plm.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O269jUdPN+3EG0hedM++PAwMUq4QPvNGB1txVuUOML0=;
 b=I0AQvGl7agIDtsP9PvGslDQ7ikjbg79L53k9pFTEKzqAwDMg3ZvyO3ww4Oz2gHCaDn
 IsXVh0VOvvhF7mH2ZNurUgB+2Spo0tG1x/vR9xMwK2JXYhzeMieD3IaASBCR4b+Y9Z6p
 tBNCehr5ny++zDCpbVy6Lc/71ybQe09kEWmh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O269jUdPN+3EG0hedM++PAwMUq4QPvNGB1txVuUOML0=;
 b=pisZ27PRz/Lu0vlvuj1PoJK0P3i8TzN01sZ8nkAkhMZxDvgqfhxLjJwaDeer9Jy30q
 wiY8rHmrIdR+DwPsjuH3Lfgc9/ddJbS/FQ3BXSf2v9NPNWk6hrJC0opsiQiHgpmbWapc
 Tsie1ZkUupcKLgcEr6k9iI7ekRSQHV5WDpMcU8ln+Pa+I9yehuOMAfwaGyLDR0fHEV+L
 kRiZcfpMCsKu4Qnh7Q14XCJj9U0Qn6RtpVoeuIiQ7SVZYN3/4NTVHW3MSMTewgwyMXdH
 qvlTIVc3ItpxmEm4fC+7C4jT6KDVdxkMvBPjabyM9KjmGNqCSHpYUlK59BfRyOQpobCb
 Lb2w==
X-Gm-Message-State: AJcUukfhBbgu8y95s3hv9e4gUZyYAcndYpxH4aqLhO+CfYSDVgOF72zi
 +N2pK9V7CyIZmo+idnOT5eBT
X-Google-Smtp-Source: ALg8bN5Om/M38HtocYXgZC34BOZ25spUwLcbzKqXGdiTAQGYKZLzTjcuOO54/lv/42H4PQ07ctEHAQ==
X-Received: by 2002:a17:902:7614:: with SMTP id
 k20mr53960506pll.285.1546660227443; 
 Fri, 04 Jan 2019 19:50:27 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id r12sm75124955pgv.83.2019.01.04.19.50.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 19:50:26 -0800 (PST)
Date: Sat, 5 Jan 2019 09:20:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 7/8 v2] arm64: dts: hi3660: Add hisi asp dma device
Message-ID: <20190105035018.GE2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-8-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546635388-13795-8-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_195028_630435_5377F4EB 
X-CRM114-Status: GOOD (  15.29  )
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
 Youlin Wang <wwx575822@notesmail.huawei.com>, Ryan Grachek <ryan@edited.us>,
 Zhuangluan Su <suzhuangluan@hisilicon.com>,
 Tanglei Han <hantanglei@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 12:56:27PM -0800, John Stultz wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> Add asp-dma device to hi3660 dts
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> v2: Removed undocumented bindings
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index aaa2b04..df4e96d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -569,6 +569,16 @@
>  			dma-type = "hi3660_dma";
>  		};
>  
> +		asp_dmac: dma-controller@e804b000 {
> +			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +			reg = <0x0 0xe804b000 0x0 0x1000>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +			dma-requests = <32>;
> +			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "asp_dma_irq";
> +		};
> +
>  		rtc0: rtc@fff04000 {
>  			compatible = "arm,pl031", "arm,primecell";
>  			reg = <0x0 0Xfff04000 0x0 0x1000>;
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
