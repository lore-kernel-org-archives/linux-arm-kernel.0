Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD943C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:25:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949662084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TCz1Qf5f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="skfCbgIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949662084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9AO0veSLrUk1z8Htm1pQhoHtRr/Motjy+KP88jqZbk4=; b=TCz1Qf5fgNN43V
	LZoIRqnsfk9XfoWn/6U383hu+mThH53UPkpjFx2aMtjwntk6vZY8BNHRrGw2eTM4K3L9WdJkdQIUp
	RKKIEAFCYOWlsGJpvg0cDFnYAhmn8gdUWb2rjExlzgRuDwD1qOqCloS/S4h9u33eiiRhEdcLyKjXR
	Ys8trPC29HAOQnEqwASSS3jhYyYIiwR+V22m+JBrIvEWAx39VAzUX2qRMx2risixRcjnF5AIRj8Sg
	zFTwJD/vEXec0OWoNhiwTHv9MUh8jyit6UrVhtHIgL7lToOzv1ZtecNPirdbsfSIuP//VDFJIxsp2
	q7ZI3eHtq6GZ37n1YJkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl5bs-0001Vw-LD; Sun, 20 Jan 2019 05:25:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl5bp-0001VW-KQ
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 05:25:26 +0000
Received: from localhost (unknown [122.178.235.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8520D2084A;
 Sun, 20 Jan 2019 05:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547961924;
 bh=pabSUG63ohgS21Gmv1r7dU4ecWj7cf9ArJLNmt5ZM4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=skfCbgIvjkTHQYwljoIVlJlH1cmzn+xP6ISaUSo1VkJbYsXEIkxv7Vtek1xDY1ax3
 eAc9a5FoqL/9G+2MhHJHNn1vYW/WHHQoCWU9sL+6LvH3+aLn683C5xJE3fX3SjV3f6
 TbaZh6r7pAkYFCCTDoM/llaN+hFqBV7Vs8SGH4Nc=
Date: Sun, 20 Jan 2019 10:53:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] dmaengine: xilinx_dma: remove set but not used
 variable 'tail_segment'
Message-ID: <20190120052350.GM4635@vkoul-mobl>
References: <1547035837-87800-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547035837-87800-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_212525_692685_299EF4A9 
X-CRM114-Status: UNSURE (   7.61  )
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
Cc: Andrea Merello <andrea.merello@gmail.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
 kernel-janitors@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 09-01-19, 12:10, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/dma/xilinx/xilinx_dma.c: In function 'xilinx_vdma_start_transfer':
> drivers/dma/xilinx/xilinx_dma.c:1104:33: warning:
>  variable 'tail_segment' set but not used [-Wunused-but-set-variable]
> 
> It not used since commit b8349172b400 ("dmaengine: xilinx_dma: Drop SG support
> for VDMA IP")

Applied, thanks

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
