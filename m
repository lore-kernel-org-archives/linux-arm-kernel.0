Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E1C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C3920811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHRHZwi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C3920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=b7crS55GJMvXe2qJhDOHF+R8RaaTxDIfkbeQYdvQgp8=; b=eHRHZwi58FxP9+
	JpELeKb8HEMuNTNE5ceCW5AQqvQm/6Ja/gNevcYmYJomJzNldafPkG/2q/ZHyJ5MyPs2Ij2kGCaAO
	nyVy1hUSLUrtG0mNhjxaBEFg8+Iwzg1fB6v6xehOQ6xcVjZnBf4M2VL5GnYl3kGSlLnTWf7nZN9Dl
	VmIR6A+mWJpHmbWp7TY76t4ghkrRk8RpkLEuHz3Fu76s9M+yYbwO1spP+gGG7QoVUOntNUpx4Lcol
	UPTKsmnSGT/+gV5ZOXnn7VhaSeZFMuPWCv/Des1Lp1jsftKUuYd4U5lJuBtlON6gBLe7yf0CxMWUd
	LO7BMItT1ezrVKy6BHxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOHV-0003Ta-2I; Thu, 13 Dec 2018 10:31:49 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOHQ-0003SR-JZ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:31:46 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1gXOH4-0003Nd-W3; Thu, 13 Dec 2018 18:31:23 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1gXOH0-0007Qg-Jk; Thu, 13 Dec 2018 18:31:18 +0800
Date: Thu, 13 Dec 2018 18:31:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/4] crypto: ARM64 NEON optimized XChaCha and
 NHPoly1305 (for Adiantum)
Message-ID: <20181213103118.qkrsjvsjtcq5pzrr@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204035252.14853-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_023144_886197_326376E2 
X-CRM114-Status: GOOD (  15.97  )
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
Cc: Jason@zx2c4.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 paulcrowley@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Eric Biggers <ebiggers@kernel.org> wrote:
> Hello,
> 
> This series optimizes the Adiantum encryption mode for ARM64 by adding
> an ARM64 NEON accelerated implementation of NHPoly1305, specifically the
> NH part; and by modifying the existing ARM64 NEON implementation of
> ChaCha20 to support XChaCha20 and XChaCha12.
> 
> This greatly improves Adiantum performance on ARM64.  For example,
> encrypting 4096-byte messages (single-threaded) on a Raspberry Pi 3
> Model B v1.2, which has a Cortex-A53 processor:
> 
>                           Before            After
>                           ---------         ---------
> adiantum(xchacha12,aes)    44.1 MB/s         82.7 MB/s
> adiantum(xchacha20,aes)    35.5 MB/s         65.7 MB/s
> 
> Decryption is almost exactly the same speed as encryption.
> 
> The biggest benefit comes from accelerating XChaCha.  Accelerating NH
> gives a somewhat smaller, but still significant benefit.
> 
> Performance on 512-byte inputs is also improved, though that is much
> slower in the first place.  When Adiantium is used with dm-crypt (or
> cryptsetup), we recommend using a 4096-byte sector size.
> 
> For comparison, on the same hardware AES-256-XTS encryption is only
> 24.5 MB/s and decryption 21.6 MB/s, both using the NEON-bitsliced
> implementation ("xts-aes-neonbs").  That is the fastest AES-256-XTS
> implementation on this processor, since it doesn't have the ARMv8
> Cryptography Extensions.  This is despite Adiantum also being a super-
> pseudorandom permutation (SPRP) over the entire sector, unlike XTS.
> 
> Note that XChaCha20 and XChaCha12 can be used for other purposes too.
> 
> Changed since v1:
>  - Create full stack frame in hchacha_block_neon() and
>    chacha_block_xor_neon().
>  - Use x30 instead of lr.
>  - Fix whitespace in nh-neon-core.S.
> 
> Eric Biggers (4):
>  crypto: arm64/nhpoly1305 - add NEON-accelerated NHPoly1305
>  crypto: arm64/chacha20 - add XChaCha20 support
>  crypto: arm64/chacha20 - refactor to allow varying number of rounds
>  crypto: arm64/chacha - add XChaCha12 support
> 
> arch/arm64/crypto/Kconfig                     |   7 +-
> arch/arm64/crypto/Makefile                    |   7 +-
> ...hacha20-neon-core.S => chacha-neon-core.S} |  92 +++++---
> arch/arm64/crypto/chacha-neon-glue.c          | 207 ++++++++++++++++++
> arch/arm64/crypto/chacha20-neon-glue.c        | 133 -----------
> arch/arm64/crypto/nh-neon-core.S              | 103 +++++++++
> arch/arm64/crypto/nhpoly1305-neon-glue.c      |  77 +++++++
> 7 files changed, 461 insertions(+), 165 deletions(-)
> rename arch/arm64/crypto/{chacha20-neon-core.S => chacha-neon-core.S} (90%)
> create mode 100644 arch/arm64/crypto/chacha-neon-glue.c
> delete mode 100644 arch/arm64/crypto/chacha20-neon-glue.c
> create mode 100644 arch/arm64/crypto/nh-neon-core.S
> create mode 100644 arch/arm64/crypto/nhpoly1305-neon-glue.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
