Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A18C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618E32084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jvKgemQW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkyOjiHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618E32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QyfOeNirIfEXulLYdCZsiaeVk6MBuKUh6mCfFmmMWbU=; b=jvKgemQWb6qvy7
	b5YT1ZxH8wwZvI0Dihcl7yg43c2MQm/jT9bXFjoewkEMiS3jLS91mHWAA8UPnsDnDpTuWX1Q7lZCG
	OqNF90Q1IvCIFeETQQWn3IAv79dbgH10xeKClLeePci4tb5GLsFHH5TFhZzLiEx6YmTvErQG8mrk1
	fnJ/mL71M2FzgfUZgqFXfUNhdJBhrcq7wkZodavEbaiaPiqyx0qIZK7K+wHqGZHEVWOoSXqO4waJe
	GEMZysMdCzZ9n1n/XMFf5RgZq4tavaihJsBGTWzvEQdwVbdvS+RLqxM+fFQJUkT9JBDrH3uw5wvy2
	wqVkI6+sXHKbsCxZaoGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUa5b-0003SZ-CI; Wed, 05 Dec 2018 16:31:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUa5Y-0003Oi-Bj; Wed, 05 Dec 2018 16:31:53 +0000
Received: from localhost (unknown [106.201.124.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31FC12082B;
 Wed,  5 Dec 2018 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544027502;
 bh=vKZ+T3/yLJvcJtv0n93/NaSsyMXA5esfFdr7EVo+Kjk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bkyOjiHnezjTSL+QwCkDSI+2XZYU2YVFd1CSC7m0RgQCN3uWOWqKnh2UMHQaIhijh
 w5E0Hg2h3k2lWs+2PcIF+gtw8QiEWDXpyPmxMk3ZMP1RSZ83kOgzBUQDfiD0V724LF
 deXHYd7TCUcdvpP93pZIaeXagsbc8Dr6f9T4l1Vs=
Date: Wed, 5 Dec 2018 22:01:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/4] add uart DMA function
Message-ID: <20181205163133.GQ2847@vkoul-mobl>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <20181205100306.GA12106@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205100306.GA12106@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_083152_417966_1910819A 
X-CRM114-Status: GOOD (  11.47  )
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

Hi Greg,

On 05-12-18, 11:03, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> > In Mediatek SOCs, the uart can support DMA function.
> > Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> > 
> > This series contains document bindings, Kconfig to control the function enable or not,
> > device tree including interrupt and dma device node, the code of UART DM
> 
> I've queued up patches 1 and 3 from this series in my tty tree, thanks.

Do you mind not taking patch 2, I would like that to go thru dmaengine
tree

Thanks
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
