Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:14:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF75213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GdiJ3OfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF75213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rz+vCRWzXYmvcjWOALPW+3F0UWwHZNHXHDsVA7Sn6NQ=; b=GdiJ3OfQdHpX1D
	JugpnOpWX8/A293TbQWrmgUTEUwdXj8AEhHAT9bvlDYVUSpBxVzN1wLvfQy6cjVz9mun41AcIsYJz
	hS8/XS7vPnkkxqpbofr8Cn4CNiyOPiP8wACKrD4B4zh5NAGGbZdJtfCIvJA3ALfcJH4GiRUsBXqzJ
	bdaIaJkRLx5RE79EnEyenyJy33mbjRSByaC36nfzHO2NNbJVgT5hn6lo/Q3ixptJKEgEnhLbRX3QN
	5Ep4+v6+RbbFhwY+L48dvqE9w4FYYCwsSxe6vvfrxN28AFxtoMpGoc0vE04tg/qeH+8ep1VVQHSZE
	h5eGX9qP/YQH7fAuu+6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5bL-0005Hp-Jk; Wed, 27 Feb 2019 20:14:47 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5bI-0005GA-4V
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 20:14:46 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 7BD4B8042C;
 Wed, 27 Feb 2019 21:14:31 +0100 (CET)
Date: Wed, 27 Feb 2019 21:14:30 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] video: fbdev: atmel_lcdfb: drop AVR and platform_data
 support
Message-ID: <20190227201430.GA27395@ravnborg.org>
References: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190225212533.26432-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=P-IC7800AAAA:8 a=7gkXJVJtAAAA:8
 a=17Lo_IAAPqJK1KymrdkA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=E9Po1WZjFZOl8hwRPBS3:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_121444_352643_4511F079 
X-CRM114-Status: GOOD (  10.04  )
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
Cc: linux-fbdev@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Alexandre.

Nice patch, good to clean out unused code.
On Mon, Feb 25, 2019 at 10:25:33PM +0100, Alexandre Belloni wrote:
> Make the driver OF only as since AVR32 has been removed from the kernel,
> there are only OF enabled platform using it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
