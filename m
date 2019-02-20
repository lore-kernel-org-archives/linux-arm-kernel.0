Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E9C10F07
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:01:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6402147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxGZN1+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6402147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VRnRjb9NI8P52UqDpQ99NwQLp5q2Gghgg4IiFN85lIA=; b=lxGZN1+yMEl5GI
	+xeQ8zfEmblRN1ySY2GyYDYQNeeoNCXmkWg2OmxiooAOCES0aZLDMMnMPFHtadp4sEm5x7yI95Iif
	4dVRdkzk7O0UXFZglcEI+Jtdhj6fvCOgr68peq9nw1NYP6IZj+RcKTm8ieiQPWAf/6pFxbKioWUBk
	mVhFViytouBSZHz1OCohAwNnuU5Mv84c69mHyaVp7yQTP0SIevkgW9hCs0lW7TzV0ILlugmvtThle
	QPcqRUzUigluFPmQF2YnuLodUiJN4SO6sX+bRkyBPZI+MY1jrLMoh1W0JXDAr8I96XOQd9gTxtR0m
	sXlLBPhHoomgP8P+uRZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwYzm-0005D4-HK; Wed, 20 Feb 2019 21:01:34 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwYzj-0005Cj-8d
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 21:01:32 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id BF71C80E1;
 Wed, 20 Feb 2019 21:01:40 +0000 (UTC)
Date: Wed, 20 Feb 2019 13:01:27 -0800
From: Tony Lindgren <tony@atomide.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver
Message-ID: <20190220210127.GU15711@atomide.com>
References: <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
 <20190220.112244.1206973642383679896.davem@davemloft.net>
 <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220.124155.2226787912266109280.davem@davemloft.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_130131_338709_45CE1728 
X-CRM114-Status: GOOD (  14.35  )
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

* David Miller <davem@davemloft.net> [190220 20:42]:
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Feb 2019 12:33:26 -0800
> 
> > * David Miller <davem@davemloft.net> [190220 19:23]:
> >> From: Grygorii Strashko <grygorii.strashko@ti.com>
> >> Date: Wed, 20 Feb 2019 17:25:19 +0200
> >> 
> >> > Deprecate cpsw-phy-sel driver as it's been replaced with new
> >> > TI phy-gmii-sel PHY driver.
> >> > 
> >> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> 
> >> Acked-by: David S. Miller <davem@davemloft.net>
> > 
> > Thanks for the ack, but actually I'd prefer you to pick
> > this patch at some future date. I suggest Grygorii just
> > repost this one after v5.1-rc1.
> 
> It's so much easier if you group this with those DT changes, they
> logically belong together as well and it helps someone reading
> the changes in the tree also if they are side by side.

I agree that a group of patches should go together in
most cases.

> Why don't you want to integrate this with them?

Because the arm-soc tree wants dts changes separately in
general. The dts changes are considered firmware describing
hardware. And it makes it possible to split the arm-soc pile
of patches into multiple pull requests. In theory there
should be no dependency between dts changes and driver
changes, but in reality that's not always the case :)

What I can do is set up a separate branch with just this
patch on top of the dts changes that the arm-soc guys can
then merge towards the end of the merge cycle. If that
works for you, let me know and I'll do it.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
