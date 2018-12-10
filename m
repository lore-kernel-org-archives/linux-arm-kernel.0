Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:24:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531FC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0TAzxOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531FC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RVpiet75A37pCXaxMDYhnazXksuuivnx7KOSeoNMv/I=; b=M0TAzxOBWz+Oqo
	U26i9GsyJIrXSX5AYruMX3cKxpuCyZX1vJpW55SH47+wqavO0lZWGpMAJY0ayN4n+A1KSw5G/ENcO
	3w20aT02OjXFVllwdTkxqBK46yJM0IolrrNuY7o0cnSllMN3YbsKdEAJYB6yQkEl6kiu0Xbwamhxq
	FTreH2dTPSaFeDMV81oZjBTQccGPSNfoRAfYG9B7TaaCULQra/yTGwd28LKK0dP7UgRClcvMrXZFZ
	h1EAbc1oBp7moL02EcGVOdT+kWGyr0HeC+drjqokXoEtCzcZMAkF0NHnITyc6GTtXaLtfMO84DXHP
	nLzgRyvVvGlEB+LW3A6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJfj-0000zl-5t; Mon, 10 Dec 2018 11:24:23 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJfM-0000TG-6b
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:24:03 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 14000431055;
 Mon, 10 Dec 2018 11:23:47 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: defconfig: Switch LPC18xx to use PL11x DRM driver
To: Linus Walleij <linus.walleij@linaro.org>
References: <20181210101620.418-1-linus.walleij@linaro.org>
 <20181210101620.418-2-linus.walleij@linaro.org>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <3c2118a6-b729-b809-654b-717048f56cc9@mleia.com>
Date: Mon, 10 Dec 2018 13:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181210101620.418-2-linus.walleij@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181210_112347_112290_0B28589A 
X-CRM114-Status: GOOD (  10.50  )
/bin/ln: failed to access
 'reaver_cache/texts/20181210_112347_112290_0B28589A': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_112347_112290_0B28589A 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

On 12/10/2018 12:16 PM, Linus Walleij wrote:
> None of the LPC18xx device trees contains any display settings,
> it just defines a device tree node for the CLCD (PL11x) set
> as "disabled" and no panels are attached on any device tree.
> 
> This I conclude that the hardware is dormant on existing
> systems, so we can without any problems switch the defconfig
> over from the old ARMCLCD frame buffer driver to the new
> PL11x DRM driver.
> 

Correct.

FWIW I've tested DRM PL111 driver on my board, if you are interested
the pending DT patch is https://patchwork.kernel.org/patch/10636591/

Thank you for the changes, I'll review and collect them for v4.22.

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
