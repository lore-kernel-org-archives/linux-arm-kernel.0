Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24214C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:57:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94FC2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPRWi0N0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94FC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QrAQQRBzlOOSzVRtHNioEMOTgOQ25j0u+UTUinEDmW8=; b=jPRWi0N0BPGmXV
	/xi87RrM5h7CxeI1duCbvHzhnRBh+EaGHHk96YSMrTcSRfBxLEMkMbpn4cwokdzfOEmZ6P/zRrniH
	hZ6k7bpU9tmXKHDtcPHLMpBecGlDHc7my50WmeUuBpXy1SwoNm+sZbtAgZE2OROIIzajrQ1QOzCsw
	sF2C/QR4IF+K36IhWz+daLCYcvstuOfofRQl51kMXEZ2hxc0Y0imgfPFkce1KF7+JOumj3tE+C553
	ByBdlkCL3NNsQQgoTr1nAD5HThv6qLbuPOVcAxNI4NQwIIf8eMXhBXPq21on8AnTreBeGa6ZqSfTr
	ethNCh9fkv09sG8Y/Sxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqwN-00016u-OJ; Tue, 22 Jan 2019 07:57:47 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqwK-00015c-5a; Tue, 22 Jan 2019 07:57:45 +0000
Received: from [192.168.178.52] ([109.104.35.154]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ma1sQ-1ggKbe0zdE-00W0BB; Tue, 22 Jan 2019 08:57:30 +0100
Subject: Re: [PATCH 0/6] ARM: dts: bcm283x: Several DTS improvements
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <30ff2336-3839-e005-d298-d0df5f09411b@i2se.com>
Date: Tue, 22 Jan 2019 08:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-Provags-ID: V03:K1:n6eJLNvJwTnHz6ajmPWRcb56TDbVMpCWvrtIYkQ8+xDMMD8/wHw
 XWMWCl2XXYjg7m6jO1/FIfjVOGm7LqcrGNdwTSZThIkegIDfR7WX+5zBJd6Vh8k90AePBXz
 BlvgXfn+7wKPyiBr3Ro2LURikGOBg70JqfzR7H/Xos6W/2x8FZNlYlLByL0NujRc47+tKA7
 wiFyVOB4vsrXriwKRnJqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50VkTsQRGPQ=:5tbEczzntuSPskdJ/USjC3
 egdcN3qDVLP71NzRJsDumzgEEd+yu1sUZ3qvq49FfWiGjR6B9HkmjXue40MDhZg6O+uOTjMES
 xyxFkgiFkJ+CotIe2Kb1IiR8nRYLIRCNWflw+08UznPZlRvrD66jLukPnFsQjoQECb1554337
 8UzMFILRlSVmj83C3hFQso7C1oFvFU97gUiH7XZWB6hEHAm3Ui1mi+TtNeibkV2yOVTYoHWPK
 2/gNciD2W3YzqjmbFPJ/x+xVi0nkGuyCF6HyxBH7xjBxjHx5z4B7VVxPCyFYf+8CT7upCiurX
 YuqrK860ov0DSRBFihPKVLYizMV16UyQ5EtJ9reRHCls2KR8xQs7bqPy/Ksi8G+UfJfLIbgwR
 zEokbsMHIg99pGfcEONC71qQ4EyKey/14oDqR2MqPVuSoDVLmJBOaOxVj6FelbUIlM7g1AsPe
 6fGga2n5gnnNno7ZNj2gmCylpRQ7DbxyzfBFMKNgQQAdoZCosRel0ukGunJA7OcWFK/Ze85/b
 BjSxAWoMYT9+0XSRgFPR0MW9uSixFFZ3q6E5mCPLf0fx8qRnXXtXIoPoArPicvM1dxBa8vxc2
 mYrytRc0zFbXtfkzkLcn+uBcI4q/T8kuz2cJTkLdR1oO38jECdgCBxjdQnBYYeTeraL6WXmlU
 LRVf045G+WajcLkEKwBxMuH0QmX83CaFhogGJ3Z4COapdN70i35HP+Ct0Nr+2S9N4gWK03qjm
 FG7JAEquNrQ5nz9FUA6E1NISgCXd5vNTccrdT0EWnjCi8dsYZP2PiQs478Q=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_235744_512877_B6AC8815 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: Gottfried Haider <gottfried.haider@gmail.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 Peter Robinson <pbrobinson@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 12.01.19 um 13:43 schrieb Stefan Wahren:
> This series consists of fixes for DTC warnings and improvements of
> the GPIO labels. So this is nothing critical, but helpful
> in case CONFIG_GPIO_SYSFS is disabled.
>
> Stefan Wahren (6):
>   ARM: dts: bcm283x: Fix DTC warning for memory node
>   ARM: dts: bcm2835-rpi: Drop unnecessary #address-cells/#size-cells
>   ARM: dts: bcm2835: Fix labels for GPIO 0,1
>   ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI hotplug
>   ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for STATUS_LED
>   ARM: dts: bcm283x: Add missing GPIO line names
>
Applied to bcm2835-dt-next

Thanks for test and review


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
