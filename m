Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8942EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4034E218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nvPUWkAT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5JDhTdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4034E218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BjOEzNJXfB+4Sy5c8HU89k+QODjqihy+8/wguatHLSM=; b=nvPUWkATn9m9Ya
	FRANXaAVEDCTv0Kv2PcfLOTtHuw/tGdPo2tGH6l1l3W1AMZlCAmiz8639k/gHAnBhHWPOu1OmGI2+
	7aGai6QQbWwM4/HE0tgmUIUELUy5dbFxSB7GTqlEJC9xqejzAyHDq1qoT7sEu91ZIvmktevqZA8vX
	tjQSyicnQyR8vnyZZiguvSnWqLTGG3ztZ8oOfLdSO15tMzuV3whBu+cB3CrD0p1QK7zp54C7qIedm
	ow3iRaP4jYIyWDa1N32v1MjFvkgCqMqoY1Yak7ubH3Un6gLKkpQILu1Pd/Fkjgk34E0xfesMT0udD
	nfd7pPwYFnjVEhegHyKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowts-0006td-Ty; Wed, 30 Jan 2019 20:56:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowtp-0006tJ-MB
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 20:55:59 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68DB22184D;
 Wed, 30 Jan 2019 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548881756;
 bh=jMmbRqJlDUQ3q6EoRsqs7LQtkHDtGl0xwnkBERVr0m0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c5JDhTdFMu0jhMRAlCC2G/4g35deNG/AL5Ninp40jwOzwBCj1JbE8VyOrk+Cp4RcM
 KZdx2bo21CLS4gETJBBdM589i4xLdo2nhpS96nISK9fmtEU9FJhSl3DTYWqtWrYMp1
 wRS1TzF357FwskO7WQno5BcoStQK4yraQWVc6nzA=
Date: Wed, 30 Jan 2019 12:55:55 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 2/3] crypto: arm/crct10dif-ce - cleanup and
 optimizations
Message-ID: <20190130205553.GA231835@gmail.com>
References: <20190130031444.28935-1-ebiggers@kernel.org>
 <20190130031444.28935-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130031444.28935-3-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_125557_789118_8CAFFC13 
X-CRM114-Status: UNSURE (   8.40  )
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
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 07:14:43PM -0800, Eric Biggers wrote:
> +	.macro		__adrl, out, sym
> +	movw		\out, #:lower16:\sym
> +	movt		\out, #:upper16:\sym
> +	.endm

Hi Ard, it seems we need the __LINUX_ARM_ARCH__ < 7 case after all?
The kbuild test robot reported a build error, which can be reproduced with:

( cat arch/arm/configs/multi_v7_defconfig;
  echo CONFIG_ARCH_MULTI_V6=y;
  echo CONFIG_CRC_T10DIF=y;
  echo CONFIG_CRYPTO_CRCT10DIF_ARM_CE=y ) > .config
make olddefconfig
make arch/arm/crypto/crct10dif-ce-core.o


  AS      arch/arm/crypto/crct10dif-ce-core.o
arch/arm/crypto/crct10dif-ce-core.S: Assembler messages:
arch/arm/crypto/crct10dif-ce-core.S:165: Error: .err encountered
arch/arm/crypto/crct10dif-ce-core.S:165: Error: selected processor does not support `movw fold_consts_ptr,#:lower16:.Lfold_across_128_bytes_consts' in ARM mode
arch/arm/crypto/crct10dif-ce-core.S:165: Error: selected processor does not support `movt fold_consts_ptr,#:upper16:.Lfold_across_128_bytes_consts' in ARM mode
arch/arm/crypto/crct10dif-ce-core.S:267: Error: .err encountered
arch/arm/crypto/crct10dif-ce-core.S:267: Error: selected processor does not support `movw r3,#:lower16:.Lbyteshift_table+16' in ARM mode
arch/arm/crypto/crct10dif-ce-core.S:267: Error: selected processor does not support `movt r3,#:upper16:.Lbyteshift_table+16' in ARM mode
arch/arm/crypto/crct10dif-ce-core.S:329: Error: .err encountered
arch/arm/crypto/crct10dif-ce-core.S:329: Error: selected processor does not support `movw fold_consts_ptr,#:lower16:.Lfold_across_16_bytes_consts' in ARM mode
arch/arm/crypto/crct10dif-ce-core.S:329: Error: selected processor does not support `movt fold_consts_ptr,#:upper16:.Lfold_across_16_bytes_consts' in ARM mode
scripts/Makefile.build:367: recipe for target 'arch/arm/crypto/crct10dif-ce-core.o' failed
make[1]: *** [arch/arm/crypto/crct10dif-ce-core.o] Error 1
Makefile:1709: recipe for target 'arch/arm/crypto/crct10dif-ce-core.o' failed
make: *** [arch/arm/crypto/crct10dif-ce-core.o] Error 2

- Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
