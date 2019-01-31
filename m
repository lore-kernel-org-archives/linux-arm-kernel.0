Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:52:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1E320881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RWsYn8AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1E320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ca3KdX3/7ujsbN9jCwRViVPt8FrjZBiDaSyn2W+ADeA=; b=RWsYn8APYmQo4s
	x70TYwTLd86adeoJVl3/9knfgGZzxjM/fG0Hhpr7g1KbeJ7spychwf4BKSf+6rZXx6lKmQJZbsmZz
	qgWLhYkZfoYGZE8AoqztvhKQHJ5OMX8AErTIXIT3MYC5SjEXlQjs2dTlBcWg2QbkSTMNoTUY+fXsH
	AW/0Lkjky4zfZbfk5puk2ipFpT5tKbHjlrQCV91R41yR6M2LpGKjdnsEZzbM7gzYSpQHOXYfONG8D
	26wBbB6sS1e3jpEZnRhmZOxlFNdGJTDg3y3B/yTWdOGg0d43xDfGbvFM7YDzykgLSYMFOoxOG5D2q
	eA0JUcTuJlMj2Gemtvwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpGVp-0004Zh-G2; Thu, 31 Jan 2019 17:52:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpGVm-0004Z1-4i
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 17:52:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A37AA78;
 Thu, 31 Jan 2019 09:52:23 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E834E3F59C;
 Thu, 31 Jan 2019 09:52:20 -0800 (PST)
Date: Thu, 31 Jan 2019 17:52:17 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v4 06/12] arm64: add sysfs vulnerability show for
 spectre v1
Message-ID: <20190131175217.4ff452d5@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-7-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-7-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_095226_193848_382A9F96 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 25 Jan 2019 12:07:05 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> spectre v1, has been mitigated, and the mitigation is
> always active.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index de09a3537cd4..ef636acf5604 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -730,3 +730,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  	{
>  	}
>  };
> +
> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> +
> +ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
> +		char *buf)

w/s issue. Other than that:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> +{
> +	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
> +}
> +
> +#endif

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
