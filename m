Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6979C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:48:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE2221848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lrewF83O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE2221848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v0+AcaTrswBPyzfaQMJpbZZthq87kFbiSvlrVhbcxq0=; b=lrewF83OhWJL7X
	OsgPSYPN+ILb9TOIeKa/ld/LK0r7j5n0eduZZcoZECZfv8qAkDKbC9tEqI4vMOlrCkRLuI9Qx/SLm
	KrWk1A1uxzDNQNgPq2JuEJG+y5MweaPZqF5nizlHbnQ26xaZGKfqSOlG1deNiVTvrE7x3jhVDcuEL
	rwseN5zRWqGi6kHxEwt4azlPe+r9MXOVT0aZzG5eTjbXFTlJk8OMRveRe8XdB64jWOv+P5T/FX4Z8
	qNj1jeRY/pfp98Pd4EbkTLjeJPl1ZSAqoE8XmfIgbftEi0lf1AUvaasfDc0CF7UMqtPHCXBANn4Mw
	Sl+OtkQHvvVF5Us1TF6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwU6c-0004PH-Gg; Wed, 20 Feb 2019 15:48:18 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwU6Y-0004Oh-N6
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:48:16 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 925208162;
 Wed, 20 Feb 2019 15:48:24 +0000 (UTC)
Date: Wed, 20 Feb 2019 07:48:11 -0800
From: Tony Lindgren <tony@atomide.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/6] ARM: dts: ti: cpsw: switch to phy-gmii-sel phy driver
Message-ID: <20190220154811.GQ15711@atomide.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_074814_811201_45F89567 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [190220 07:26]:
> Hi Tony,
> 
> Hence prerequisite patches [1] have been merged already I'm sending final set
> of DT patches to complete conversation of TI CPSW driver to use phy-gmii-sel
> phy driver instead of cpsw-phy-sel. 
> 
> [1] https://lkml.org/lkml/2018/11/26/154

Great, I was wondering about update of that series, will
apply.

Thanks and welcome back!

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
