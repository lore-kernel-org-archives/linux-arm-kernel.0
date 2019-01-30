Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7655BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4AB20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tOXJm3uU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhJC3+pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4AB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VwOLNms/gtH8Q1skYS65hEORViVUYrWXP9FCMGcKztk=; b=tOXJm3uUatdQ5A
	w+Kq0wiZpuJrHn+HCCrtRRPwe99jAU/j8V0D5o3pMtc8Fvnmw5c2BRB0DbbX3En5ekKViqfdo61l/
	OngBHuTXWKLQjmErzMHt1JM+Leq2sKp6OaI9jwOoAQmGginh2VuAbZaro1SqSoAYcGQf8jsgPHkA+
	Wy3pEbaqmvUTco+ZnA8T3psLLSUFRCnBHwFz4hVgGZallCBuvXqMaz+BBQgqkE9Bt9JyMoo9AuF6e
	l1+uSL2pMAElv6m9c9ICQLEbtsVS1j9Wke6VmZuq9BTkcPtVvpKH2k9vzrf9ThZT/IG7BeoDPxuBm
	rFfXQix6Ds2PvpoXwHEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gox6T-0002Mb-LA; Wed, 30 Jan 2019 21:09:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gox6Q-0002MG-3J
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:08:59 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D14D2184D;
 Wed, 30 Jan 2019 21:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548882537;
 bh=GJh6n9GmMPfbc0fnlKIm7XjEdr7VIklIawdWGsUcozI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rhJC3+pjbphXiZXO9SmDjiFBnJ1OMV59HKL21WW2hMx5a/owfqh8uJ45QDhKFprge
 TK1O0j7z4x+zb+Jk7T8NCiThpH9JEBXu25VvH4DGUXHlibbC/oJ64iyyWplShDtIBm
 +9m16Elvy2BQUtUtUHL1JE/4V1sRuLUHguapijfQ=
Date: Wed, 30 Jan 2019 13:08:55 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3 2/3] crypto: arm/crct10dif-ce - cleanup and
 optimizations
Message-ID: <20190130210855.GB231835@gmail.com>
References: <20190130031444.28935-1-ebiggers@kernel.org>
 <20190130031444.28935-3-ebiggers@kernel.org>
 <20190130205553.GA231835@gmail.com>
 <CAKv+Gu95XurUKRqV7VR5X1ECfDqDEw78qS_ggn9pcG30S-6zFg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu95XurUKRqV7VR5X1ECfDqDEw78qS_ggn9pcG30S-6zFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_130858_171643_82656D12 
X-CRM114-Status: GOOD (  13.64  )
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
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:00:53PM +0100, Ard Biesheuvel wrote:
> On Wed, 30 Jan 2019 at 21:55, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Jan 29, 2019 at 07:14:43PM -0800, Eric Biggers wrote:
> > > +     .macro          __adrl, out, sym
> > > +     movw            \out, #:lower16:\sym
> > > +     movt            \out, #:upper16:\sym
> > > +     .endm
> >
> > Hi Ard, it seems we need the __LINUX_ARM_ARCH__ < 7 case after all?
> > The kbuild test robot reported a build error, which can be reproduced with:
> >
> > ( cat arch/arm/configs/multi_v7_defconfig;
> >   echo CONFIG_ARCH_MULTI_V6=y;
> >   echo CONFIG_CRC_T10DIF=y;
> >   echo CONFIG_CRYPTO_CRCT10DIF_ARM_CE=y ) > .config
> > make olddefconfig
> > make arch/arm/crypto/crct10dif-ce-core.o
> >
> >
> >   AS      arch/arm/crypto/crct10dif-ce-core.o
> > arch/arm/crypto/crct10dif-ce-core.S: Assembler messages:
> > arch/arm/crypto/crct10dif-ce-core.S:165: Error: .err encountered
> > arch/arm/crypto/crct10dif-ce-core.S:165: Error: selected processor does not support `movw fold_consts_ptr,#:lower16:.Lfold_across_128_bytes_consts' in ARM mode
> > arch/arm/crypto/crct10dif-ce-core.S:165: Error: selected processor does not support `movt fold_consts_ptr,#:upper16:.Lfold_across_128_bytes_consts' in ARM mode
> > arch/arm/crypto/crct10dif-ce-core.S:267: Error: .err encountered
> > arch/arm/crypto/crct10dif-ce-core.S:267: Error: selected processor does not support `movw r3,#:lower16:.Lbyteshift_table+16' in ARM mode
> > arch/arm/crypto/crct10dif-ce-core.S:267: Error: selected processor does not support `movt r3,#:upper16:.Lbyteshift_table+16' in ARM mode
> > arch/arm/crypto/crct10dif-ce-core.S:329: Error: .err encountered
> > arch/arm/crypto/crct10dif-ce-core.S:329: Error: selected processor does not support `movw fold_consts_ptr,#:lower16:.Lfold_across_16_bytes_consts' in ARM mode
> > arch/arm/crypto/crct10dif-ce-core.S:329: Error: selected processor does not support `movt fold_consts_ptr,#:upper16:.Lfold_across_16_bytes_consts' in ARM mode
> > scripts/Makefile.build:367: recipe for target 'arch/arm/crypto/crct10dif-ce-core.o' failed
> > make[1]: *** [arch/arm/crypto/crct10dif-ce-core.o] Error 1
> > Makefile:1709: recipe for target 'arch/arm/crypto/crct10dif-ce-core.o' failed
> > make: *** [arch/arm/crypto/crct10dif-ce-core.o] Error 2
> >
> 
> That does not make sense. That code can only execute on a NEON capable
> CPU, which is guaranteed to support movw/movt as well. So I'd prefer
> solving this by adding '.arch armv7-a' to this .S file.

Yes that works.  I'll send out a new version with that.

- Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
