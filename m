Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A602C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:32:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B5520849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WMkmtbD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B5520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jLPoYrkyz7884YYJ18UHHmz/8OjYZFeO4VIeFCntjRo=; b=WMkmtbD56ePGow
	LKWQIYwFNTQivpSY4F8CHePXFTWyxhWA/9vzRY0+MBeReRDs0PZ9uYRX4hyCNs0u8a/pJ9mLzgNYL
	PCvEOBxp6qyggXRDkn0G1b2FSXIWq6v96phwvdn0bCzws3bQ128jhvNNkh2yukNNw3Lc89Op4klZ0
	/6+eIGUvhKEvWkN8aGsxL1m3Gg5jtJ5TFIpXkG7juGheB2HkiaNQe52stBk1YKOeQDOb0Nb+RTAAa
	JUW/gkDV4dpnqSYtsVyQhuvnUvlg4yWeJRefO9g+IjZiLcTHPvRW2DeYcyHctaWHS3//UqkawAGYp
	4KgkMQZTgI+hHd+VTNpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNMO-0006WR-8q; Thu, 13 Dec 2018 09:32:48 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNMJ-0006UT-JT; Thu, 13 Dec 2018 09:32:45 +0000
X-UUID: 926697806b884b48a978688681d5b666-20181213
X-UUID: 926697806b884b48a978688681d5b666-20181213
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1351068479; Thu, 13 Dec 2018 17:32:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 13 Dec 2018 17:32:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 17:32:27 +0800
Message-ID: <1544693547.11699.40.camel@mhfsdcap03>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From: Qii Wang <qii.wang@mediatek.com>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 13 Dec 2018 17:32:27 +0800
In-Reply-To: <20181211202931.xav4gzi7rzh2scgx@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
 <20181211202931.xav4gzi7rzh2scgx@ninjato>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013243_849679_21599008 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-11 at 21:29 +0100, Wolfram Sang wrote:
> > +  - ch-offset: base reg offset for multi-user.
> 
> What is "multi-user"? Why can't you add this offset to the reg-property
> directly?
> 

Thanks for your comment.
There are 3 channel in one MT8183 I3C controller, and every channel can
be used as an I2C controller.
Take the following diagram as example:
If use I3C channels as I2C bus,
1. CH-A/B/C offset are different;
2. If use CH-B or CH-A as I2C, they must config registers which's
address are in CH-A.
 ____________________________________
|     ________                       |
|    |        |<--- offset:0x00      |
|    |  CH-A  |                      |
|    |________|                      |
|    |        |<--- offset:0x100     |
|    |  CH-B  |                      |
|    |________|                      |
|    |        |<--- offset:0x200     |
|    |  CH-C  |                      |
|    |________|                      |
|____________________________________|
        one I3C controller               

Because of CH-B/CH-C depend on CH-A's register, it can't add offset to
reg-property directly.

MT8183 doesn't need to support muti-user according to the latest project
information, and I'll remove this feature from patches.

> > +  - mediatek,share-i3c: i3c controller can share i2c function.
> 
> Please explain in more detail? Is this an I3C controller?
> 

Yes, it is a i3c controller, and it is compatible with i2c. I only use
the feature of i2c, so I need a flag to do some extra settings.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
