Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A12C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:43:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E060820844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DEbbr5GO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nWkOO4q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E060820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f4POhxkrNodFXjl7Vg3nMYggf4Aplh76L+4EplSntg4=; b=DEbbr5GODiAUiMBtUYHcsRDPZ
	viVgviL/EEbMJ9Fp+iQvP3RwaIY6DnrtRezyrhiMWsNzb5VebeiuxgioC45dr8c18xvYc8ImMeUr1
	uEJj+Q9I+f2aIQWC3pDcNBCgaX04NYoaMQCpdc0cLjlfhLh5Cc7H4iFpiOD+8pglNh1fnm30Y3ZQC
	mHxK5+l3c9UEKcpgUViB4TlozjW0oNXrXyjW0BlwNX8FW8aBPhWvBpyCknNkpEuxiIy7yMNhu87S1
	sHrNMUKyWCZH7U+8dssyGG6DKCozvbZNX3VAIlUWXfVLoJ4pP5LoDX22xP6hS2fpYSdH4zjPBICe1
	Sn47XRCjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnta-0000tU-5Z; Mon, 04 Feb 2019 23:43:22 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqntX-0000sy-Fr
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:43:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fl/CEWgft1iHybGMEoq4yVj+5dj+wGNYdkifmBg0VPI=; b=nWkOO4q6tOF+PipLhGDydpvDkn
 Y4Y3zzBwna/ii/fO7MlQnkRZN+3NAXadCHxUTtwELVdarvvQpY5ot8Ou0IelWIWrt6RsaDQHxjO/4
 1e3sIMRQb4AhPm7W762HrZH+LKguZYCVCdOnPuQAfh2pxJ2HWFQ7k8/QX3gwFq7x6C5NejjL2Dr87
 GCLinf5oH7O7QVcjJP+yLnUJA9HPrywVC8l9HPmKFPXU+ho7JJeRdxMlSskrZq4vnCL9XieecQAyV
 2xP1Ay4qXZwpVCKbJTxyjc5Ct91mC13iXOjyGbCzN2W8OQZiD+G9vpz3PpLG9Yx0VuMRMuP76HMmA
 Z0iATFiw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:59600 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqnq2-0005p5-8k; Mon, 04 Feb 2019 18:39:42 -0500
Subject: Re: [PATCH 18/35] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-19-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <9fb82a77-9732-b9ec-5394-c6a5148b4f7f@lechnology.com>
Date: Mon, 4 Feb 2019 17:43:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-19-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_154319_605647_D7D85E5A 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The aintc driver has now been cleaned up. Move it to drivers/irqchip
> where it belongs. There's no device-tree support for any dm* board so
> there's no IRQCHIP_OF_DECLARE() - there's only the exported init
> function called from machine code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3d1e60779078..ea0eb82bf1d2 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -129,6 +129,11 @@ config BRCMSTB_L2_IRQ
>   	select GENERIC_IRQ_CHIP
>   	select IRQ_DOMAIN
>   
> +config DAVINCI_AINTC
> +	bool
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN

No help section? :-)

> +
>   config DW_APB_ICTL
>   	bool
>   	select GENERIC_IRQ_CHIP


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
