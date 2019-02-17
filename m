Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99070C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:01:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3D72195D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YSV17YD9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="R1GGl6x3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3D72195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=usnqHkdfGouyvWTFzezvaCUbQ9dCtiAf7PyYe3oIGEM=; b=YSV17YD9O5XHcvrozXTbf71ur
	0RLGzOmEYgaGB54PfJ3X6ynKt2D1UiMCLDNOuOToH3SPgYy5cfSqelCkD7cIs7JwBi56sefO3t2gH
	JtzoF8hzp8g5GSyQ/VPEO9gbaS7jLbnIBekso8+zPwWE//1elbXbmMqIFr/+sdEXArd3KZccy0ffP
	YqenudPw7wwfTf1YhL7S0Zfjb6CvPb5J1optV11vgEWGmMllHVRIz0Z8pe5U+fejCq+22NndInOCj
	CfeJLrrXVL6ngI40Zt/LTJD5RJnc7pwHh5qnb1x4DQE/UoSngEEyJOnW42OzGitdaQTQ9MWPAlwjK
	899b32DBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvJG4-0004KE-Af; Sun, 17 Feb 2019 10:01:12 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvJG1-0004Jv-TE
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 10:01:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ee2s5d7l6e2sMjJzKOgeJLb3Jl5nBh4pZLvnPxu9/bE=; b=R1GGl6x3KwpB/Pkcrw8udGrYYH
 9lMF2pEXn6Nxn9xut3pT4sPzs0FqUr7lsm+mOqmei2odFybpQ3BN94I+asA4gWpyS+F9wc0ipznYN
 KA9fHKLnWELOwdz8ATq1K7jGAAGI6FIX3W1DmKPsawyz4nOODVZXlKWH+yZ+6pvXmSDOhZEd90SG0
 UsGzUlHH+QEiBf/M/ZMNk4m1jZi6J1P8kMJrQMnxM7A8vh41L8JrzwEUfS7F4VJ+VddKz2VRX8Ksx
 yFIvPiOH9qubwgIHA6t1CkwEcB+16rePoz0+GS9OiOaXeJsV+d8GmJpcYlUer3z8bDMXIb2kzCdV2
 oufcOOrA==;
Received: from [185.122.190.68] (port=28456 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gvJFq-0000vN-52; Sun, 17 Feb 2019 05:00:58 -0500
Subject: Re: [PATCH v4 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-34-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <681a7831-8c20-d634-a1cb-04064e3077b8@lechnology.com>
Date: Sun, 17 Feb 2019 11:01:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-34-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190217_020110_025950_773C010C 
X-CRM114-Status: GOOD (  13.09  )
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

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()

s/Raplace/Replace/

> and writel_relaxed() respectively. It's safe to do as there's no
> endianness conversion being done in the code.

Should this be combined with patch 14/37?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/cp_intc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 1bf11fa8be76..f88b7f0978aa 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
>   
>   static inline unsigned int davinci_cp_intc_read(unsigned int offset)
>   {
> -	return __raw_readl(davinci_cp_intc_base + offset);
> +	return readl_relaxed(davinci_cp_intc_base + offset);
>   }
>   
>   static inline void davinci_cp_intc_write(unsigned long value,
>   					 unsigned int offset)
>   {
> -	__raw_writel(value, davinci_cp_intc_base + offset);
> +	writel_relaxed(value, davinci_cp_intc_base + offset);
>   }
>   
>   static void davinci_cp_intc_ack_irq(struct irq_data *d)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
