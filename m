Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB8BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:01:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EA021726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H22om5nZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EA021726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:
	MIME-Version:References:In-Reply-To:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvLlBJXDlNlukn/0IGEwqf3QJv804Q3jLhMnbcjTY9s=; b=H22om5nZL6xooW
	iIxBhEj0Ldq4wTBZA9ROIyce/59TWUweQ54XRmbmuFqm17kryKGVbzJDYF7l5naWWr2xkK/mRumXr
	y1fC2rdefFktThMrN6m01B3+XikUsBRO1lDh4oY2pt2HCPUnwJZ0Le++X/5bLOj50w5usELckMDB3
	93cMG6Hv4OvDcoPo+52IXo9nFdel6fV2tJQ1jLcraSk7vWNUbjUkr9w3sgN+sf3FG1B+8iypTxP4c
	Sz2IiCGphYOERXBwBLab7t1lLVMNuB/OPECXNszikgLp434CXiLssQnmfl9DDVN14V9bQvyD7N/bP
	umJnq33qlH2vp4YCEUJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmHDM-0000g2-91; Wed, 23 Jan 2019 12:01:04 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmHDE-0000fJ-L0; Wed, 23 Jan 2019 12:01:02 +0000
Received: from [10.218.201.250] ([88.128.80.113]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKmP-1hHR0D3ONN-014T38; Wed, 23
 Jan 2019 13:00:49 +0100
Date: Wed, 23 Jan 2019 13:00:46 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190123075327.27366-1-joro@8bytes.org>
References: <20190123075327.27366-1-joro@8bytes.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iommu/mediatek: Use correct fwspec in
 mtk_iommu_add_device()
To: linux-mediatek@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
From: Frank Wunderlich <frank-w@public-files.de>
Message-ID: <BEC8FBEB-A827-44ED-9E1D-F994EB23F58D@public-files.de>
X-Provags-ID: V03:K1:n4Uk6LKnBzOT9NQtJdthhQHlUOcihyYzLT0X2yU0m4cJFFVf/vv
 PuysTMXWcpxZkl2L5IsGbt+PEi0eFmNhpRrSkQ70LTJuse9+0+blbufKStsA6O86q+oQRbt
 gwEhtKul+bhToDF7oO72D/svni6KHSxeAJKEXmSWQIrQXjcVN1Lr80353eiyilU26KsAG1+
 BGXee8g57jdUbEjeuNZkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Ro7i/tBgNg=:d1WQ70O+hFw0rGBJ7HpDr/
 iZt7x7psH5sfyIFQA9FFMq8QkLnXuRxVxhO8T4O/wMfi9meharCIzHiX+Gi0Ecjmk4NpiQMfF
 Q9+iF+j420uV6Xo2nwoqIoB8MTw7PcucZwAn33emfP2QuSetCg69yKhC5sV7VRmzkJfEqwhYA
 ds4wW+ZbwH2i9a0Vqz6YXR9X5WMNMVVMgXEDJfUYWsXOYgR3j6pXoPqy6PgwQirEQxhTYVHAO
 GUb50r37mj5JLMcbP95PvjmXlxKz2/UMrHtFm1cUqhJRdTgGgIv41wm8j+T1oWusQGW39WN3E
 gRTgyVC1KedtFTRWXq4Mh30zgIfQ4p6PQklrlsWpNOpjLjko5l1T4b2I+xlCGsLfBIVQrTNNY
 EKnueH22u3QkyxRvLq//hnwx0M6STg0J47tkMkC/FrQQ6dT+gtlEhLHQIA6ggeFppIdcZ/hmQ
 Jqq5nugUOpLHNNBFvWR/eX/R2iyYmCsyzuG2zrT3uBMtu6JVAe1CrvtOv6LumLlOCF3/aPjyT
 c+KS2SHiVUnxQwo2TrjypI8iRUyCKwX2st/Neg3vodLRmtM24O0VR3bH4EpUI50OX/aRkibio
 gDZG2Xbk4r0sCXFXdw/0wic1+AgJI2WqmAU7gMELDo0M+vmWN9drjVNryRqtGr4yce9KQUfXK
 8C2f/2tU1SjXHLjJljRxKsJwBPnpN+M4zSkRoWwqB1RVkoLga9fbwugythIq9F2O7zr/q0guq
 4LsFScljzMQvYME/W5q7V4hHz5iPtvmFYsOr6ams7Ht9LnckxAPCy7VAUYW1JsiKhfq0IzlQy
 qYldDrnRFe8QCeGT0oqruR/nqAPYYMKYbeSAzKCGM1WKrQ3vmIdttjdXaVV2dy2ScJoWXV/nI
 vGCC6/hYSeNQLkXTWMvED6ebnIAMusDighmikiPoW6DqSNUqHDbzcfuKq+RIOAknivgzZD35a
 ANxkSoiri6zn1wtNJxZNiUz1j/s/2oSQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_040056_992225_A0CB0BDF 
X-CRM114-Status: UNSURE (   3.28  )
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
Reply-To: frank-w@public-files.de
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Tested-by: Frank Wunderlich <frank-w@public-files.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
