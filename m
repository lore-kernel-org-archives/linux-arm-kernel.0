Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B42DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656242087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JF3sMIOh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="2MI4XVbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656242087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thalesgroup.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=icdv4MY1OcQQhl7nCps5NBaBZwfzqEt5UR0w0L9/XXY=; b=JF3sMIOhTQK167
	igc6k/MmuJo+sm0eFjMltWqD7a6Wmm42BZ+88dsBCS6hEkKtfeVXtmMIp29Ihia9trnuwoTNzF35I
	7nQYTSBR4eld0fqvcnJfVgXwwdCTIkJuo31ZNhoUHomjMUb2DbPHlfZiVYY6SoSdYDjLj3DdfDtUL
	iMf8f6ol8rVKljDGCI2vagrXGOrkDuuBt+OvZZiAuB9KG/XnwoNyQ/VL0IaXHGZkXiFDsI5ooDHFs
	S0IT2jrGrYPISFlZgj7WZFWlJnHLjgcfDqhaMMeZA7cbWE4/+bg6ux8OIDP72uM1Tx/qhXjkuhwwz
	7fX87G5FCjCLDFvcgmzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggkbC-0002Eh-LM; Tue, 08 Jan 2019 06:10:50 +0000
Received: from thsbbfxrt01p.thalesgroup.com ([192.54.144.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggkb4-0001zY-6J
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 06:10:47 +0000
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 43YhhB529Dz44pN;
 Tue,  8 Jan 2019 07:10:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
 s=xrt20181201; t=1546927834;
 bh=tCkresmIC7qnyEnFvRZlnL+jlQ3zUxBb1fRBdq4VIzc=;
 h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Transfer-Encoding:MIME-Version:From;
 b=2MI4XVbgaVYyfFWqkQQdH2/BV+2U0+I/oe1xZCd0lh1B49NfuijhtGMwdbft7tfN2
 RuSCU+/EHvH+nwB99Hr5MtSVsw6JCSxiaaXrGJLDRJHqMl8AQm05NbWe24gRnM+VP7
 FMxtTH33ObzbH0UD9l1oBkrJLi1uGFZOZ1O+YbrUQGhI+Dvk3KEzrh/2XNWlf+e+g8
 EIw9L04gbTkmJeuNlSQjQqk/8uk4IMUhgZA0LxKXIocoNzAS7BACQiCy7rMcNNclX2
 1x04JmOga+FEIOfcb7c/j1uhZ4vUwBRzgmCYX74f6PTsAkzOEAxnN5mSNYBHAF/Xgn
 mZvapOEsNpNlA==
From: JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
Thread-Topic: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
Thread-Index: AQHUgjYTG3WrmQNv1kme8Oaw7bApm6VbdosAgAAw4YCAAAdvgIAALekAgAAXF4CASSivgA==
Date: Tue, 8 Jan 2019 06:10:33 +0000
Message-ID: <1546927833.511.68.camel@atviedlbe741.rss.d3s.at.thales>
References: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122092928.GF30658@n2100.armlinux.org.uk>
 <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122125100.GG30658@n2100.armlinux.org.uk>
 <1542900920.26115.92.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122165759.GH30658@n2100.armlinux.org.uk>
In-Reply-To: <20181122165759.GH30658@n2100.armlinux.org.uk>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.10.4-0ubuntu2 
x-originating-ip: [10.177.70.238]
x-pmwin-version: 4.0.3, Antivirus-Engine: 3.73.0, Antivirus-Data: 5.58
Content-ID: <87405284EB7D8544AA06768B14C0A1E4@iris.infra.thales>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_221043_204294_A1242F45 
X-CRM114-Status: UNSURE (   6.06  )
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
Cc: Chris Cole <chris@sageembedded.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi again,

I saw, that there are some findings in v7_dma_inv_range
https://patchwork.kernel.org/patch/10673097/


It wouldn't be better to replace it directly with C&I ?

Otherwise still there is risk that you lost writes in->out ?
(Exactly happens in my case)

v7_dma_inv_range:

from
mcrlo	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
to
mcrlo	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line


Thanks
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
