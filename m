Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBAEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:51:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A7C222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TySqGsxG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnk10aIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A7C222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0mYhW4/tFKqxyrXfZHLkUiEbaGKsrAXQpDbAF8aFsL8=; b=TySqGsxGU7AOGj
	t72FCtOixo6HMDq/+cpxQo6LTQ5bDKnAdKgqOV+d//5xrn76yaPnmcDSbO4dAinh0wZ2e5SsvLiK8
	RX8pSsX5TMkbTiNZAvhjEe8jQQFXCv6FO3PEEvpm5qq1X4erSPFXBmW8AG6nYaAQPlksVbNdzlDle
	PbeWwefYI7nmBn2v8drD7Rieh3QhLlgkDABiwnYGvR0/wDChQAzeU7HjRinnkHu/B5S+mwm/nt4b9
	FljwvEU6nFNnl3F+84QWaRoneAWDO226cGrpcq3tI82/eyf9kv1C84QaJJAFsfqo5oJ/EJkdtpfBz
	yBso63eYGUf2qQCwhrUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiZl-0006n5-JB; Fri, 15 Feb 2019 18:51:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiZi-0006mf-Oi
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:51:04 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7173D21929;
 Fri, 15 Feb 2019 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550256661;
 bh=+YxRzfzrCQoMevPQS4cQv+rsVsfhKacc9NzC6i1mdXE=;
 h=Date:From:To:Cc:Subject:From;
 b=cnk10aIs6JDXgWgqUg4fnO6xhdpXL8cNG6E5CFDgCrHA5SVog+gU9KvZqfClOM1nH
 ZWIjnHeSY2mSIsvi8iD4dfrKuWoKrbb2CVGOD3QsyJW+4Vl1p08pRa5GnJwoElHvlX
 r/e1VuRH8xmomh5ZyEQ0gi+CcO/6caEOnZ21QYLw=
Date: Fri, 15 Feb 2019 10:51:00 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Manszewski <c.manszewski@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Kamil Konieczny <k.konieczny@partner.samsung.com>,
 linux-samsung-soc@vger.kernel.org
Subject: [Bug] s5p-sss crypto driver doesn't set next AES-CBC IV
Message-ID: <20190215185058.GB12909@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_105102_813769_88FD8FCC 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

The AES-CBC implementation in the s5p-sss crypto driver is failing the improved
crypto self-tests I currently have out for review.  The improved tests check
that all CBC implementations update the IV buffer to be the last ciphertext
block.  This has always been required so that requests can be chained, but
unfortunately it wasn't tested for by the self-tests until now.

See the boot logs for Exynos platforms from the KernelCI job here:
https://kernelci.org/boot/all/job/ardb/branch/for-kernelci/kernel/v5.0-rc1-149-g64c945c018af/

alg: skcipher: cbc-aes-s5p encryption test failed (wrong output IV) on test vector 0, cfg=\"in-place\"
00000000: 3d af ba 42 9d 9e b4 30 b4 22 da 80 2c 9f ac 41

You can reproduce by pulling from
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
branch "iv-out-testing", unsetting CONFIG_CRYPTO_MANAGER_DISABLE_TESTS,
setting CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y, rebooting and checking dmesg.

(CRYPTO_MANAGER_EXTRA_TESTS is probably unneeded for this, but you might as well
use it.  Also you can optionally revert the last patch, which makes crypto
self-test failures cause a kernel panic for testing purposes.  It's possible
that ctr-aes-s5p is failing too but it was just never gotten to...)

The patch series is also available on the linux-crypto mailing list:
https://patchwork.kernel.org/cover/10811951/

Note that I don't have this hardware myself, so if it turns out that no one is
interested in fixing this anytime soon I'll instead have to propose disabling
these algorithm(s) until they can be fixed.

Thanks,

- Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
