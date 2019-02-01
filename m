Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD10C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC8E21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RGZhQ72h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E/nNdVKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC8E21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PQDNe+FVMQsNUjl1CQx0cmETMZflhMTMEWHI/IM922s=; b=RGZhQ72hYVfkZ/
	AQ5Aiuv8RlTk3qaRPtCvuOatyVajv4SQKXFcWdbLRRrCMLvu5kIJh+YR9kj4uu190XoCSnSgYl8M7
	rfTxDtrEKAwcyVXFOfPzMgi8hbGaOY9y8deVR60nSc8Ecgtj4VosJbr3kIAd8Q74Q1RYg6jHLcbzJ
	nBXE6CWNbZaIaEiElKtGRBE+7tYW7cyYZwIb6At+QVpNJ3aAhE2+nc99hKJMM2EfkWTw5nBJRiHSA
	Xb3TscBORhlLA6sZk5fkGeNGwdWIMmcb26qidN6NFghplIIWRinuJqii1ckdloiK5KHISqLYmekcC
	Cr/5kx7G14ZxmLKAJocA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUSI-0000Ub-1S; Fri, 01 Feb 2019 08:45:46 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUSE-0000Rg-Dp
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:45:44 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x118jbmZ021367;
 Fri, 1 Feb 2019 02:45:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549010737;
 bh=qmssCgl6jlt2P4iYWc5KRxtZ+77V1p4CL/FQzoiY9Mg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=E/nNdVKw3z38v+cKTF8zzbXJvNEm9lZ4wZdm1mHYkrh0XJxBSB4BMJqFQxM8UEZnq
 nLFPEUrYvU35mkmKlBpwpl18tDO2BTdk/DTsi67Q08sE1DEKqogb/xJgJCp4KhAZm6
 YLWw9UWQ/P3Lr75aXFZJmza0skTbO0oiQhFaq53U=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x118jbvK092479
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Feb 2019 02:45:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Feb 2019 02:45:37 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Feb 2019 02:45:37 -0600
Received: from psplinux063.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x118jX5v005565;
 Fri, 1 Feb 2019 02:45:36 -0600
From: Sekhar Nori <nsekhar@ti.com>
To: ARM-SoC Maintainers <arm@kernel.org>
Subject: [GIT PULL 2/2] DaVinci DT updates for v5.1
Date: Fri, 1 Feb 2019 14:15:33 +0530
Message-ID: <20190201084533.12881-2-nsekhar@ti.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20190201084533.12881-1-nsekhar@ti.com>
References: <20190201084533.12881-1-nsekhar@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004542_562848_7B481FA9 
X-CRM114-Status: GOOD (  14.06  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v5.1/dt

for you to fetch changes up to 7dd2e8f8a5dc6266a4df4ed6f269ab7bacae596c:

  ARM: dts: da850-lcdk: Enable the analog mic input (2019-01-10 13:36:16 +0530)

----------------------------------------------------------------
DaVinci device-tree updates for v5.1 contains a patch to enable analog
mic input on da850 LCDK board.

----------------------------------------------------------------
Peter Ujfalusi (1):
      ARM: dts: da850-lcdk: Enable the analog mic input

 arch/arm/boot/dts/da850-lcdk.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
