Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B702C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:31:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A603217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkJlcuN3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aQzXHUuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A603217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jw+e3Zgl7fozFaWiHnfXJd6GurpTj9LpAy2TiZ396Cw=; b=HkJlcuN3lLc6D8
	Kb0snY0oEGWYe0ujvmP0IdQMFSvhIJ6XbkQa3/sWXsMQmq5jVX5bO78N3Ek6HkUaTtcetN1pQR0pZ
	gXOLQ1BP648zU+Kr1hvNpZuXXdw/W0/kc6TR53+x05JN8LqfJAApyH8vNsqmb94fcQ/xG6DUdMtbD
	JEn9KEreF3Bcm+TToV0I8RWz4Bgg3nX/ypVSPzeR166xZR8TC2sl44NDJGJ8yEEyrMeFpnsnfQDVH
	IwidpmZUygvFhBINdaKzuvXbaGipURtcGybgx6UAimdYI1GXZh6X4uQnNp0Ws43LAHGI/8vzNz1aQ
	jF79K56nKLSpdb8vBQ7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcHc-0003G8-LZ; Thu, 24 Jan 2019 10:30:52 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcHZ-0002yF-LS
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 10:30:51 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4993b20000>; Thu, 24 Jan 2019 02:30:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 02:30:45 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 02:30:45 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 10:30:43 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To: Joseph Lo <josephl@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
Date: Thu, 24 Jan 2019 10:30:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107032810.13522-2-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548325810; bh=/25apzAx882srsw4xtzso4rn1Re9J1H/IKll3eUzAJs=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=aQzXHUuJk525Ljz6LiSsdOI+GY4BE4EkzFs/9vsWtBnfsj+dZNIUW8StJmBp6xn8k
 94gaCI76/ffeY9p+0Pw0Xr6aIcYxk+TYis2kirOnziHrRdpS90mhD3dGUhDgtOKg9v
 17NRReEmxSbaGx+Nwg2xsXPAxosJLzKzqxT8aCvYSGCxDAZ17mb4lwB9lEi6cADPb8
 I1G2cG6m1GWww0fUUfJjX9nGBgh3pROsgxfx2xFBe3bwHVrhD0MyKZBS7hWS08jo0z
 3v8KgNCfY5Fxui93NHe6yVLnOV96lijg9SSHmFT7+u9faFdc2fFSHPieeAGkMZ0i8H
 L55oNUApmKOPA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_023049_721002_297E8FBF 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 07/01/2019 03:28, Joseph Lo wrote:
> The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
> or watchdog interrupts.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  .../bindings/timer/nvidia,tegra210-timer.txt  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> new file mode 100644
> index 000000000000..ba511220a669
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> @@ -0,0 +1,25 @@
> +NVIDIA Tegra210 timer
> +
> +The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> +timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> +from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> +(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
> +or watchdog interrupts.
> +
> +Required properties:
> +- compatible : "nvidia,tegra210-timer".
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : A list of 4 interrupts; one per each of TMR10 through TMR13.

Why do we only add the interrupts for TMR10 - TMR13? What about the others?

Cheers
Jon

-- 
nvpublic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
