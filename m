Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:55:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDDE20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dFr4Rf+p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4Bmxi9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDDE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mi7QHAX8i0pEO9htTkHTr1c8VoAnT5bNwrU9fCbVheE=; b=dFr4Rf+phbXRoF
	W5LtdGBo6rmktlQ9tRWzG27W/2w9A465UYlMvDqiNY+MWa8Y0WPh90ojAkmtjdJnlVRAO2mxngW8p
	u3Ckrk3JlhOsRssoVveg30WK19YM9e1h3e0rwd/tGzlR/SHQTh1xPUXiDOFrcBiM/8ePkse6lkqS4
	XEYIlrZ02pQJJcFt93KdbOTh+pRi+bFWeS8Li0TO6S4Dc50FsXAmzF1RHhBqVi2U2GDqBll9S/gRb
	WoXM7FE8ACGHcSJFATWkv7ZqPaEFarQNyHPjAMq9tqDP8sc/DE5Yhd4u+xqkiGApeiQrSbulreZmg
	JiK9+TdCyllnJEmbDr4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gngDj-0002MY-23; Sun, 27 Jan 2019 08:55:15 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gngDe-0001uL-Bc
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 08:55:12 +0000
Received: by mail-io1-xd2c.google.com with SMTP id k7so11034154iob.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DdMckKEcWICyP6+dmYxRWpMFp9C9/P0ba38gUhiNXhU=;
 b=j4Bmxi9uLxmCIli5O0OOmHvmGf3hqwcnaI+kc1v+eVLUEXjOKr/mu5DoCVhS5HY6UH
 h0FiZUXm0Ki0cPR/+M3dXVEXSA9ac6qfSmfpR375Pv1X7AlwiXcxVJCozXhSKer7Q8SH
 rWdafWUXfzyEZbMwiz+HfygT9ZjwiQML72AyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DdMckKEcWICyP6+dmYxRWpMFp9C9/P0ba38gUhiNXhU=;
 b=foS+cRYfC4h7CCgyuGFAQp+zRDNm0gRNHqidKlyZRAjL7Kw5estaqqWrW7/vYBOVWg
 vF+o/W6fy/AWAqtA8+SIC+uON8Xh+oUEo+81YbVDhaTFPGrO6uWUD34Hzawf2ZUSKEJG
 xnzVisEXrDI9UTrvoBK2uNHSb3lm6MdZZdC2Hhl+0xaRu3/s5BmRR/jMt70pOfeWXFjB
 +YdNoDzp6FXKI3qunPO+glmc0oNp/a7iO+DC/86e/1YY+oV0y6TW7yIg4AKv93pb5CId
 GokkMkFv3aCJiDw67ic6rRMZkvSgfvFLANCa44es7MJCzx8REIxzuTwPG8rpRpJtTLoO
 cmGQ==
X-Gm-Message-State: AHQUAuaOhNJOP1BEFg4SB+vZOnM9pNDisbifWps2N7+WSsMkY0ySfK8m
 1M+sgnfPMuJKrQR+ApdmCmgfvJlgwi+jQm64EZnqrw==
X-Google-Smtp-Source: ALg8bN4kxXlUhNNkKDKt/5NXGmkTCrvnZn0Vdfyt1NCEroJXhSgBiFvyFFc4nkvAHM6QuOv8B7yJAQtVRC55dOZ+Qf0=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr10317879ion.173.1548579306987; 
 Sun, 27 Jan 2019 00:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20190126210530.GB709@sol.localdomain>
In-Reply-To: <20190126210530.GB709@sol.localdomain>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 27 Jan 2019 09:54:54 +0100
Message-ID: <CAKv+Gu-RKu9jt+2FnV2529zqyLGR8RSu8r4B8eOs-7Om-pL0aQ@mail.gmail.com>
Subject: Re: [Bug] Rockchip crypto driver sometimes produces wrong ciphertext
To: Eric Biggers <ebiggers@kernel.org>, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_005510_395732_B9D5A735 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: linux-rockchip@lists.infradead.org, Zain Wang <wzz@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

(add LAKML and arm-soc maintainers)

On Sat, 26 Jan 2019 at 22:05, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hello,
>
> I don't know whether anyone is actually maintaining the Rockchip crypto driver
> in drivers/crypto/rockchip/, but it's failing the improved crypto tests
> that I currently have out for review: https://patchwork.kernel.org/cover/10778089/
>
> See the boot logs for RK3288 from the KernelCI job here:
>
> https://storage.kernelci.org/ardb/for-kernelci/v5.0-rc1-86-geaffe22db9d1/arm/multi_v7_defconfig/lab-collabora/boot-rk3288-rock2-square.txt
> https://storage.kernelci.org/ardb/for-kernelci/v5.0-rc1-86-geaffe22db9d1/arm/multi_v7_defconfig/lab-collabora/boot-rk3288-veyron-jaq.txt
>
> alg: skcipher: ecb-aes-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: use_digest src_divs=[15.64%@+3258, 84.36%@+4059] dst_divs=[69.11%@+1796, 8.49%@+4027, 6.34%@+1, 16.6%@+4058] iv_offset=21\"
> alg: skcipher: cbc-aes-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_digest src_divs=[100.0%@alignmask+3993] dst_divs=[65.31%@alignmask+1435, 34.69%@+14]\"
> alg: skcipher: ecb-des-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_final src_divs=[<flush> 66.52%@+11, 33.48%@+1519] dst_divs=[58.82%@+1, 19.43%@+4082, 21.75%@+8]\"
> alg: skcipher: cbc-des-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_finup src_divs=[100.0%@+3980] dst_divs=[60.4%@+3763, 23.9%@+4011, 16.87%@+4046]\"
> alg: skcipher: ecb-des3-ede-rk encryption test failed (wrong result) on test vector 0, cfg=\"random: may_sleep use_digest src_divs=[100.0%@+4] dst_divs=[47.25%@+19, 14.83%@+22, 37.92%@+31]\"
> alg: skcipher: cbc-des3-ede-rk encryption test failed (wrong result) on test vector 0, cfg=\"two even aligned splits\"
>
> In other words: the ecb-aes-rk, cbc-aes-rk, ecb-des-rk, cbc-des-rk,
> ecb-des3-ede-rk, and cbc-des3-ede-rk algorithms are failing because they produce
> the wrong ciphertext on some scatterlist layouts.
>
> You can reproduce by pulling from
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
> branch "testmgr-improvements", unsetting CONFIG_CRYPTO_MANAGER_DISABLE_TESTS,
> setting CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, rebooting and checking dmesg.
>
> Note that I don't have this hardware myself, so if it turns out that no one is
> interested in fixing this anytime soon I'll instead have to propose disabling
> these algorithms until they can be fixed.
>
> Thanks,
>
> - Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
