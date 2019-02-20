Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C323C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:42:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165FE2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N/EOu9pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165FE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cdaYxfe7AiqO0lnqQYyYo4is057YtX9wWQ2s3f3Wi3Q=; b=N/EOu9pz71vlkr
	QV4+cpmGWNTjGgkhL6QaRAmGpn6ppO0eBo60Tef/H5bRVk+TzyPXn63RGrDO7itvGAe6u7JUzFR/k
	ArWFh0riLeOnbZ6udCzUfaidUoc1JB8j7mjwPwt608eRH6mdELot0MjvKTBrjDJ6gw6b0irrKAOse
	h2GHVOEomUZTSbLRDTZjfwldIEdGF7L2Lz9tSD15vpANwNSqtBxa+GaMF5Rq+ZIRf94/D01+y0CGf
	se9clXcXFqPwxfkWrFfFr8WDxzDGA2m8SRmELwNPzEf7RM/BXb4k58hCmGk+NsHQoSQpYs27JhIFc
	afUa5FbsmEKBjcFPACgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYgu-0002HJ-DS; Wed, 20 Feb 2019 20:42:04 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwYgr-0002GB-4u
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 20:42:02 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id DFD2512536DA8;
 Wed, 20 Feb 2019 12:41:55 -0800 (PST)
Date: Wed, 20 Feb 2019 12:41:55 -0800 (PST)
Message-Id: <20190220.124155.2226787912266109280.davem@davemloft.net>
To: tony@atomide.com
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190220203326.GT15711@atomide.com>
References: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
 <20190220.112244.1206973642383679896.davem@davemloft.net>
 <20190220203326.GT15711@atomide.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 20 Feb 2019 12:41:56 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_124201_201561_3053771B 
X-CRM114-Status: UNSURE (   8.80  )
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
Cc: devicetree@vger.kernel.org, grygorii.strashko@ti.com,
 netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 kishon@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Feb 2019 12:33:26 -0800

> * David Miller <davem@davemloft.net> [190220 19:23]:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>> Date: Wed, 20 Feb 2019 17:25:19 +0200
>> 
>> > Deprecate cpsw-phy-sel driver as it's been replaced with new
>> > TI phy-gmii-sel PHY driver.
>> > 
>> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Thanks for the ack, but actually I'd prefer you to pick
> this patch at some future date. I suggest Grygorii just
> repost this one after v5.1-rc1.

It's so much easier if you group this with those DT changes, they
logically belong together as well and it helps someone reading
the changes in the tree also if they are side by side.

Why don't you want to integrate this with them?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
