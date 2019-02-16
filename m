Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA8AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:53:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA507222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DFFkXHqq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsL51TJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA507222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jOQQlSVhA1RmZpDhKEcWarvfPWrMP0IHvs8Wxbn1Q+o=; b=DFFkXHqqO4cZoD
	yXcbMXw/aBXaD7FPHKo+iw2oYfzMwXVpwkRrgBRcYRWKNIxT5HsZqxDnu5UTe/u5Bg4u/UcXdfK8f
	XfdCAdpnVAq9Xm+gGrXVPOGRIa+IeAfKkd+SGD0O/wsKPB40r9V87TjEPlbTsp66mN/0q7NzDBhxK
	6KhJoNEZpHctG9lYLyJAjue1ZCV6c6DFtTLaeN59mhuFdsQo4zPCCa+ijEb0+WJLqY0/7vQG2de84
	7WOY+4zRFLk5NueHToQEhkF7R0a9MKvbLBofy7TZYimSMjxKbo/NF+lTs7SJNbo6Me2KhwmFaPs2n
	t1SvZA6rKVbHKIUJtu0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guweh-0000k5-4Y; Sat, 16 Feb 2019 09:53:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guwed-0000jg-Au
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 09:53:05 +0000
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68A99222E0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550310782;
 bh=j2a8KespGTwvO+Rs0azlboLr55i+jm7tQzrYbDD5J38=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fsL51TJyanaomSf5FD3+juSdc++gg5G66lCDJubLy2YlkA/+tYamkzfKtSw2fR3Uv
 pfvjhbtGqtUmczs960M5TIzrgmCGJtjQYwbVtFvGGiKTQgHztsc23asDwodeIJ8dw3
 tX1zwQ2vuogSzyMA2LT1IGIEL4H+eUFti56J7UUA=
Received: by mail-lf1-f44.google.com with SMTP id e27so8965887lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 01:53:02 -0800 (PST)
X-Gm-Message-State: AHQUAuZgjhY6+OmyriDbonhVV527sOSTNHdjVjtgCeRU9RFd5qVaCdE2
 QfKAxwq4abeYeXbgpJVv9xFedgjxuMFQmJ4jz8E=
X-Google-Smtp-Source: AHgI3IaedFfdZLjqiHV/fchiWjipROr7s1n+k4NovfdkqgSb395sSBnbQZPC+v98uk8HXS/tvEk1c5XYB4JplhN4nBo=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr7872896lfh.74.1550310780566; 
 Sat, 16 Feb 2019 01:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20190215185058.GB12909@gmail.com>
In-Reply-To: <20190215185058.GB12909@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sat, 16 Feb 2019 10:52:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfU5JVU1Z9hBf-9cfDvaq3825su12jYv=Qf3K4nCQox=w@mail.gmail.com>
Message-ID: <CAJKOXPfU5JVU1Z9hBf-9cfDvaq3825su12jYv=Qf3K4nCQox=w@mail.gmail.com>
Subject: Re: [Bug] s5p-sss crypto driver doesn't set next AES-CBC IV
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_015303_396283_D79F12A0 
X-CRM114-Status: GOOD (  19.45  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Vladimir Zapolskiy <vz@mleia.com>, linux-crypto@vger.kernel.org,
 Kamil Konieczny <k.konieczny@partner.samsung.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 19:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hello,
>
> The AES-CBC implementation in the s5p-sss crypto driver is failing the improved
> crypto self-tests I currently have out for review.  The improved tests check
> that all CBC implementations update the IV buffer to be the last ciphertext
> block.  This has always been required so that requests can be chained, but
> unfortunately it wasn't tested for by the self-tests until now.
>
> See the boot logs for Exynos platforms from the KernelCI job here:
> https://kernelci.org/boot/all/job/ardb/branch/for-kernelci/kernel/v5.0-rc1-149-g64c945c018af/
>
> alg: skcipher: cbc-aes-s5p encryption test failed (wrong output IV) on test vector 0, cfg=\"in-place\"
> 00000000: 3d af ba 42 9d 9e b4 30 b4 22 da 80 2c 9f ac 41
>
> You can reproduce by pulling from
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
> branch "iv-out-testing", unsetting CONFIG_CRYPTO_MANAGER_DISABLE_TESTS,
> setting CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, rebooting and checking dmesg.
>
> (CRYPTO_MANAGER_EXTRA_TESTS is probably unneeded for this, but you might as well
> use it.  Also you can optionally revert the last patch, which makes crypto
> self-test failures cause a kernel panic for testing purposes.  It's possible
> that ctr-aes-s5p is failing too but it was just never gotten to...)
>
> The patch series is also available on the linux-crypto mailing list:
> https://patchwork.kernel.org/cover/10811951/
>
> Note that I don't have this hardware myself, so if it turns out that no one is
> interested in fixing this anytime soon I'll instead have to propose disabling
> these algorithm(s) until they can be fixed.

Thanks for the report. I'll take a look. I have the HW so I think I
will be able to reproduce it easily.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
