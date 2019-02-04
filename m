Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EECC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:02:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3A02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ojuj6BkD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxEEI4MZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3A02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aV5VchrqpF1ylzH8Z19ccNg1M2o8R3WTwE2w1qQKYxM=; b=ojuj6BkDbuDrbq
	FiMM2Plv37Llp0H1P9NE8jL19zGe+J5hMJBgNw2sayFrxfEwPyOVYhdPbJ3CjXyAu1ZVZU0vYNd/1
	1l/HLEk0GmTIJo+nulzUvAQTxwFKfd0j4evryX7azvlJQ5whjCeGe4ATTkqlgTg55aCZj1SDB75Nz
	Ic3Ds4jCp5Pj8gKrm0rry2paH4UOOaoKRsdVo73LWlx9myAwNUq0PuUpv34JlALKfZ6iN55e7smvu
	+8spC9RuQT5uOMa1PE5cd0cJzVqRftHN/sA0Zhk2EdSOvPiObzOBOzNG0vR9a7w4Cjr5/LdT1fBrn
	mFsRAjw/tar2jojYVU8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqghW-0007ne-AB; Mon, 04 Feb 2019 16:02:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqghJ-0007Yi-A3
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:02:17 +0000
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com
 [70.114.128.244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D1AE2082F;
 Mon,  4 Feb 2019 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549296132;
 bh=okbiJcgY0oTADs4DAbVmhP1tGCjNZWDLyPh2TQekMUM=;
 h=From:To:Cc:Subject:Date:From;
 b=sxEEI4MZMayF+CRC6HzCTyjvgrZDpbCkPbAMhpXJ9o8sF2N91IewhA0XLs4L160IJ
 Gq63z2wltqW8jbbXRnUuiIxFxKlOrOc7jth/Gq1i7chAG80avez3S3f5Di84wlOjh1
 R7WyFSiuw7ouBylyGzLX0FL2DDtfEqmPcyZwbg0U=
From: Dinh Nguyen <dinguyen@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 1/2] ARM: defconfig: socfpga_defconfig: updates for v5.1
Date: Mon,  4 Feb 2019 10:02:09 -0600
Message-Id: <20190204160210.18046-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_080213_366530_E4F6D026 
X-CRM114-Status: UNSURE (   8.97  )
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
Cc: dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this defconfig update for v5.1.

Thanks,
Dinh


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_for_next_v5.1_defconfig

for you to fetch changes up to 594f1e8a240f33bd66bd7c7bcbf9952211260104:

  ARM: socfpga_defconfig: enable BLK_DEV_LOOP config option (2019-02-04 09:30:34 -0600)

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: socfpga_defconfig: enable BLK_DEV_LOOP config option

 arch/arm/configs/socfpga_defconfig | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
