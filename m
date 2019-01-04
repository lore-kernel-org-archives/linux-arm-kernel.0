Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:50:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FCA2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7fMZ+gp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGj3J5b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FCA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KTjwJYIh1e+sFdywOpbH5cr1AsqjG2wQFjD81gNcFYI=; b=e7fMZ+gpxlXhNL4UJZOtT7kqrU
	x/PjOluI5H3L1jTKmcHzDv7rRpnO6YhWdtTTsanCGHLA9+5dQRHozgnpgFfv0nq4IexSUp+fs7jO1
	ziibkoJ2SUW0oFkeeRYjVvY4XjLrNBCeHQZtlRIjaPVe3dTJXbzaWCkL1bkN1CdtQQ+rf0xEKf993
	k0ofUmXTiBew+ZpOCyV10QWXtTSzLfsXLGQahzLauwvGbJY5N77WkrCNZQLYZ0aH3v3dRBrFZ2eTH
	h6W/TOTkhos9LXxcejpfTmhUBeBkdu3qIIzLaQ36f2t5VAaOHSTxWdO+rFUu1Y8fRVRvjL61b0j8x
	NuHQm/3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfHQy-00015S-RS; Fri, 04 Jan 2019 04:50:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfHQv-00014q-Sa
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 04:50:11 +0000
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C06BC21871;
 Fri,  4 Jan 2019 04:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546577409;
 bh=A0KpDl1H7ilXRVeVGaWBumchBX0arDtAzXbVMPxnYWo=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=sGj3J5b02DV6vuyTADQ5XSMMybEqRHzxD5+gs0tWtVscUKe/BEfm1oYt7gMrUyYLS
 pABGJQJMKGqfG0yad3QUp9pzpd4HIi5wv+WYe+eUHwghN7slBhs6Ixjrb+vdQuVKOa
 9NNND4WioIqcm2Ioiw3rTsN3/hvMAXsaiBkw8twA=
Date: Fri, 04 Jan 2019 04:50:08 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: compat: Avoid sending SIGILL for unallocated
 syscall numbers
In-Reply-To: <1546539240-20647-2-git-send-email-will.deacon@arm.com>
References: <1546539240-20647-2-git-send-email-will.deacon@arm.com>
Message-Id: <20190104045008.C06BC21871@mail.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_205009_946285_EE30069F 
X-CRM114-Status: UNSURE (   7.48  )
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
Cc: , stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
 pihsun@chromium.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.20.0, v4.19.13, v4.14.91, v4.9.148, v4.4.169, v3.18.131, 

v4.20.0: Build OK!
v4.19.13: Build OK!
v4.14.91: Failed to apply! Possible dependencies:
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")

v4.9.148: Failed to apply! Possible dependencies:
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")

v4.4.169: Failed to apply! Possible dependencies:
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")

v3.18.131: Failed to apply! Possible dependencies:
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")


How should we proceed with this patch?

--
Thanks,
Sasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
