Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA07C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:47:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1295218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pp6N4OBI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zl/3Zocm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1295218D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jeRrUDNGLSj/WTCQwkATSRZG0QM/3XxDbAkxXTILciY=; b=Pp6N4OBIKAQSBZ
	ebzvucFjoveS5KxNte8a0naUs9tQ2AB1CnaD5aXuhQzf37mPmWpIRdx3AcYWsjv/EhS9cjhXJujS8
	2oPJ0i8Nd1kxwFVcXI0gDaEoO97hYbcpyWPsJiLo6qH3N/P+8KEDmq7zLIAbGUsMuAroggSEkfFl8
	Y/VleVbL/gsvEC0FfnxmgY6UaeXf8rT35kY21kyd3QL2371DqyFFQo8KhLWpWntGLtOIgL6mXrum9
	D1L/ajAkb6a3ADXJA5qSri1auIPsMpV1Su+ldbALLDgMtGECKN+qrNuvl9l6GuC/3BMUp6cTBKk7j
	lyTP2ys9hMxbL28/CCfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz0m-0002IE-4o; Fri, 25 Jan 2019 10:47:00 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz0j-0002Ht-4a
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:46:58 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0PAkr1B026373;
 Fri, 25 Jan 2019 04:46:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548413213;
 bh=AoFJnzLvBY+2V3CvJJslKo7VKvvkXZnCTZu9lTBCgB8=;
 h=To:CC:From:Subject:Date;
 b=Zl/3Zocm8PhLfhX++UkMOZGYburI5jBR5EGvcpMsOsgKUX84+FAy3c0nrCz8hrc1G
 cizNusMr/Yx7FiJjqMyFttRab5/TBISoYKF4KLZ+yIHGjuHL1hBdIaZoprBhAcbk+O
 hYeRTx97eSo92P3C430GiaPJk9EAz+TqpasLunTc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0PAkrr9025717
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Jan 2019 04:46:53 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 25
 Jan 2019 04:46:52 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 25 Jan 2019 04:46:52 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0PAkoTN003846;
 Fri, 25 Jan 2019 04:46:51 -0600
To: ARM-SoC Maintainers <arm@kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Subject: [GIT PULL] DaVinci fixes for v5.0 (part 2)
Message-ID: <92cfdbed-70aa-97e9-ea37-7c06af53cfca@ti.com>
Date: Fri, 25 Jan 2019 16:16:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_024657_274770_20E7522B 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit c25748acc5c20786ecb7518bfeae8fcef93472d6:

  ARM: dts: da850-lcdk: Correct the sound card name (2019-01-10 13:32:51 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v5.0-part2

for you to fetch changes up to e3966a766865da7ced1dece663697861dd5cf103:

  ARM: dts: da850: fix interrupt numbers for clocksource (2019-01-17 18:29:12 +0530)

----------------------------------------------------------------
This fixes a long standing typo in device-tree for DA850 in interrupt
number for timer. It did not affect us so far because we use non-DT
timer driver within mach-davinci. This was caught while mirating to
clocksource driver.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: dts: da850: fix interrupt numbers for clocksource

 arch/arm/boot/dts/da850.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
