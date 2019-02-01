Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:08:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC5E20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIPk1clq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC5E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=40lD8BFSZKBBbKrtUkTj2yJhTcZChJe1QPCE1fQ9bZI=; b=NIPk1clq4pcT/8
	UpjfKrv4u6bCMSWmqYFA3Pd+3UWemjexz2iSWG5GCquAnPYCNKnntOGOfhtGyMgBI3ZB1cKOMH/tX
	9Is2tr2Dse/UtDRfW/IsZgfIZsqptpxNaoGbcrfjYrC4lI8qmPweEtm6kK5ydp12Pw7nM4+VK0/aY
	DBP+temXPaLvGfAd/sH0/Ygwqo3QqXiWstnIh2BucLTrYkfH5cBoIiqGNOruCIyXPdnvfns9ekSVP
	GCSUh/b536fDx0uOJamOaq6oHIwNJcwIDb9ldV8njMcGyIOlXHo7i9gHbNoye3m/c9IfeGeQjJ3lq
	FL1wmgKPQzOjwP8RgHlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUnq-0001nS-6t; Fri, 01 Feb 2019 09:08:02 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUnn-0001n9-82
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:08:00 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0349368CEC; Fri,  1 Feb 2019 10:07:56 +0100 (CET)
Date: Fri, 1 Feb 2019 10:07:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: fix a layering violation in videobuf2 and improve
 dma_map_resource v2
Message-ID: <20190201090755.GA16464@lst.de>
References: <CGME20190118113751epcas2p2d7d678dcf247806a119316aabb4dde21@epcas2p2.samsung.com>
 <20190118113727.3270-1-hch@lst.de>
 <774dc557-b690-203f-898f-38755b099068@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <774dc557-b690-203f-898f-38755b099068@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_010759_437687_0D77E0DD 
X-CRM114-Status: UNSURE (   8.34  )
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
Cc: Niklas =?iso-8859-1?Q?S=F6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Pawel Osciak <pawel@osciak.com>,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDg6MDU6MjFBTSArMDEwMCwgTWFyZWsgU3p5cHJvd3Nr
aSB3cm90ZToKPiBXb3JrcyBmaW5lIG9uIG9sZGVyIEV4eW5vcyBiYXNlZCBib2FyZHMgd2l0aCBJ
T01NVSBhbmQgQ01BIGRpc2FibGVkLgo+IAo+IFRlc3RlZC1ieTogTWFyZWsgU3p5cHJvd3NraSA8
bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgoKVGhhbmtzLiAgSSd2ZSBtZXJnZWQgdGhlINGVZXJp
ZXMgaW50byB0aGUgZG1hLW1hcHBpbmcgdHJlZSwgYW5kIEkndmUKYWxzbyBtYWRlIGEgc3RhYmxl
IGJyYW5jaCBhdmFpbGFibGUgYXQ6CgogICAgZ2l0Oi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMv
aGNoL2RtYS1tYXBwaW5nLmdpdCB2aWRlb2J1Zi1tYXAtcmVzb3VyY2UKCmluIGNhc2UgaXQgbmVl
ZHMgdG8gYmUgcHVsbGVkIGludG8gdGhlIG1lZGlhIHRyZWUuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
