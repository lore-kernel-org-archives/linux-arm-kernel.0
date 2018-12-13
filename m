Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C69C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8E72086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="loU0F8g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8E72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h/Y6bZ8fWWa9jhyrcllllAvSj7RTKRhXkxz6uD4yI8U=; b=loU0F8g3TjPyhl
	oZZ6/17FX+fI0rPa4nge7Hr6pCFtDrtzE2HkrCdJG1AHCdedZq2FpHwqQUbA1AaS5vRLY9UebCuf9
	vaHNpjYgDG2tVVHqpQ51cI62SklFZlApDNbiT2N+xMjPXCaZ7MFKS41yPJ6hS2oImm/2avyaYl8I0
	Ynl6Vdqc3H5YCU9gE9wWdSVU88Qs4i3J+pXitXatNlcewO4NKIuG8rCeBVBavn413tQj7FmK1rI1Q
	ZZiDJ9zyKV2657hX55XBa47vd7y6mFnBP3UouJH1WCEI80gms7zGp169Yyyzimu+DgEd479TnbLnl
	2BG2CNByLA94j1fA4hOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXVTw-0005b1-OJ; Thu, 13 Dec 2018 18:13:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXVTt-0005Yq-4a; Thu, 13 Dec 2018 18:13:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63347A78;
 Thu, 13 Dec 2018 10:12:54 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32EA13F575;
 Thu, 13 Dec 2018 10:12:54 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 16B9A1AE0838; Thu, 13 Dec 2018 18:13:18 +0000 (GMT)
Date: Thu, 13 Dec 2018 18:13:18 +0000
From: Will Deacon <will.deacon@arm.com>
To: Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
Message-ID: <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
References: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_101305_178714_A8A1543B 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: wsd_upstream@mediatek.com, ard.biesheuvel@linaro.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Ard because I'll basically go with his preference on this one]

On Wed, Dec 12, 2018 at 06:56:49PM +0800, Miles Chen wrote:
> When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
> perform linear virtual address to physical address translation.
> Sometimes we're debugging with only few information such as a kernel log
> and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.
> 
> Tested by:
> echo c > /proc/sysrq-trigger
> [   11.996161] SMP: stopping secondary CPUs
> [   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
> [   11.996881] PHYS_OFFSET: 0xffffffeb40000000
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm64/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f4fc1e0544b7..4b0e1231625c 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
>  		pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
>  			 offset, KIMAGE_VADDR);
> +		pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
>  	} else {
>  		pr_emerg("Kernel Offset: disabled\n");
>  	}
> -- 
> 2.18.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
