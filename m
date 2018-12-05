Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7832C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9CD208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j9B4hPyW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2NZiu16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9CD208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LXCLACN9cctfvcdCBKrDK3mM9Ig0OErKnE6wPu94GXU=; b=j9B4hPyW/ggwYU
	RDxCW9DrvNkVQHMzvOn/s8xZFpZSN43WNe4xGf2EFWiPfYX13waJCIkS95RZzbRvWjglQv4MMX4RG
	PJkn70MQtje6pi+8ZrwjkemXylK0fPPvfivlVQUZpfeC6JbfsMOHKwqvxCPJWROO7nSxLmMeWvrpu
	qnOZum8GWQrIRrqrJeKaRCWlDx9n0/u06LtvaeHDOStDwU5sLxc2v0YaHQtChheU1F1g4GOuJDFrc
	fI5ceBETQlpOkwUzPnA35KC6ZbXHq9DeuOJBXlNNBDZDmkLZzlP0crR0RK7FL3L7YSgwxw8S1YSZ0
	V05Vqlwbx5Rr9lw5hzwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUcGB-0003Jq-2a; Wed, 05 Dec 2018 18:50:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUcG7-0003Ix-Mq; Wed, 05 Dec 2018 18:50:56 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D21920892;
 Wed,  5 Dec 2018 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544035845;
 bh=GdCfjL6xDzP1JbtpXJKSTTapkT7HFC/yoaXpg4smSeo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t2NZiu16hROCQ7p8r0n3MrISAQ2KI8Ht3c8KBcjofgywbBeS11tdWNWZkyrNmtdEc
 3ahwGISOVgzQG1xAfsNk6Ka5P1JymffARJETkY4vNNPCfc1/Spn2/UVBvnqH+Qt8ku
 DvLdx4I+YGie/xrVoqBHCFOa2k95tRUUdOfixqQ0=
Date: Wed, 5 Dec 2018 19:50:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/4] add uart DMA function
Message-ID: <20181205185042.GA27295@kroah.com>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <20181205100306.GA12106@kroah.com>
 <20181205163133.GQ2847@vkoul-mobl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205163133.GQ2847@vkoul-mobl>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_105055_764886_C869745F 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, srv_heupstream@mediatek.com,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
 Long Cheng <long.cheng@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 10:01:33PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> On 05-12-18, 11:03, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> > > In Mediatek SOCs, the uart can support DMA function.
> > > Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> > > 
> > > This series contains document bindings, Kconfig to control the function enable or not,
> > > device tree including interrupt and dma device node, the code of UART DM
> > 
> > I've queued up patches 1 and 3 from this series in my tty tree, thanks.
> 
> Do you mind not taking patch 2, I would like that to go thru dmaengine
> tree

Like I said, I only took patches 1 and 3...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
