Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B4C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:03:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CEF214E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KD9WBXbA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOn0JkPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CEF214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gMmITLYztRM5CiR/se+/40d922o3COaWlXyjN6XZ0Yk=; b=KD9WBXbAxdHrmN
	fU0wqh4kgiwK1bxoJsur+nB47jpibz8mGjRB558YoYO3LV9a5zpTMrnggSNCOmVNE2gGxVAdf+Yyk
	KXpIKBFzzpmYW+o/1+EQ+nhu/IJ5TRyJcVewM8RYqZqgtZIDYVTChlMs/KcLSckmjwgujesgmGIw8
	AsBRXXcZSFN8qm2hCA8NtYoTShWNZrB7x4YIBXa6/jUGe3EY0zdKuIZveHeWYpnyuCgTvXPSoOQmk
	pCuwtgWuMRxl5TplBFsWYwroI0LqWmpLirypm8IbAtnDXsoqh0zBoz0zUDlqBSwk9ye+oLXFB78V/
	JPW1uZjxLjS/bxJIvBvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUU1a-00031W-1M; Wed, 05 Dec 2018 10:03:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUU1W-0002ya-Fo; Wed, 05 Dec 2018 10:03:19 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF92F214C1;
 Wed,  5 Dec 2018 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544004188;
 bh=id3Hy8SLfpthRW254ddehmNdy5cfWf1emeIptw9dh6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iOn0JkPRyAQ500q+vw3nLPO22McBxoX8XhWS4ob/nZ4jpEWjMhMW/H9Shtk5mf/By
 e2fGoNAMu8yHmMiS7JvCjU9PNl1bFhIhPtHHjHUNWWbSrIWpQPlCK6eilPNmf4q2M1
 yCnNMVdxUWcNFiQwK7usG2Qe88fBKH1DYaeXEHBI=
Date: Wed, 5 Dec 2018 11:03:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v2 0/4] add uart DMA function
Message-ID: <20181205100306.GA12106@kroah.com>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_020318_546823_D3D0DC7B 
X-CRM114-Status: UNSURE (   9.41  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, srv_heupstream@mediatek.com,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> In Mediatek SOCs, the uart can support DMA function.
> Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> 
> This series contains document bindings, Kconfig to control the function enable or not,
> device tree including interrupt and dma device node, the code of UART DM

I've queued up patches 1 and 3 from this series in my tty tree, thanks.

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
