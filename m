Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B202EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:36:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734CA2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oLblQMSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734CA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/lTY56zG9wX+tGRLZcsWhZs0NeDoNYE/7oDQT+UxxSA=; b=oLblQMSAx1TsHT
	SG4p9D05hxVW52EqxGq+u1OW3+FIFU39USGEzv/N3qs+7Jr+vaEheYntKUynRqsRN2EGmApPdqcKl
	cAlnV+IBeMdgpWlH4NZQiihGvCb4yJgUg8QkOK7OyYjkA5Anvb5MdSnT2e+ACWjypWkFiYIAyQFQN
	xLXpHjbGVD9C7pWVwchoHI9IBgvH8RRD//DHdWQokYKL5SSZURHlL3x6LxUIUbMShxV/7WRS2l3o2
	8BdYp6YeMBafbILvptwaJaIjdw9y/VcwowibAZ9MyngZvLsMYKBin7xrR/DX4BvIqG3lyIxWiS3d1
	+2hxJTCT+VJSDYXx50iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwrL3-000893-Hf; Thu, 21 Feb 2019 16:36:45 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwrL1-00087t-1v
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:36:44 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id B5D3F80C8;
 Thu, 21 Feb 2019 16:36:51 +0000 (UTC)
Date: Thu, 21 Feb 2019 08:36:38 -0800
From: Tony Lindgren <tony@atomide.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Message-ID: <20190221163638.GW15711@atomide.com>
References: <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
 <20190220210127.GU15711@atomide.com>
 <20190220.161831.2067856031892978.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220.161831.2067856031892978.davem@davemloft.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_083643_136652_640945E8 
X-CRM114-Status: UNSURE (   8.96  )
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

* David Miller <davem@davemloft.net> [190221 00:18]:
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Feb 2019 13:01:27 -0800
> 
> > What I can do is set up a separate branch with just this
> > patch on top of the dts changes that the arm-soc guys can
> > then merge towards the end of the merge cycle. If that
> > works for you, let me know and I'll do it.
> 
> Yes, it does work for me.

OK I've applied this patch into omap-for-v5.1/cpsw.

Thanks,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
