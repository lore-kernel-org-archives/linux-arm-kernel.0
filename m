Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA42EC282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FBD21848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UWMyuNO1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="04SYhoHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FBD21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijJS43Y95JD/fv+tBrSKXcNLy9hbkp6AuI+T8VvfcCk=; b=UWMyuNO18HOc4l
	RVKEzO+jjR8wm5fsR2fm2BDxmKDhcQU3oUtheq1yc0+y+GmYisBon6XFeUhHJ+Y+4aLoqjWAxAJV9
	45a4SUb9KHtSb4rEVsus54YD/8lBQcv/+7l0+NsL9VGSpiEcDGkwSThttY4zBXpf2ZbF1rSRWCvdT
	dsuZVrGKRTnRqmuHZPqynIzFIvyJyUnx4mC7Wx4/rPW/BPhpdpqPDIxenVwuQ7viPXlHXh27l4Knk
	5D+jVSc9mIlVC4ommcdu1dWYa5SXLlP0hrRZC4G358BUTygztc+oXaAida710wFRA3xByvf65BMIO
	yVnXSlDGZae6SYrXp+0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gok3W-0002DP-SK; Wed, 30 Jan 2019 07:13:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gok3T-0002CW-E0; Wed, 30 Jan 2019 07:13:04 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9AAC21473;
 Wed, 30 Jan 2019 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548832381;
 bh=WeY9aW6CanI3Djkj7YNyj1HXPwX54l3e0H00jVyiAic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=04SYhoHUHcPuetG5ZWQ3SzUgyXKmstw7/cwRSVRqyeY5A4FvdSGmbzewde42tC50j
 668pgODplcRVGBwZTZfG+kfn8Pg6J9wyLqA24X76PpumuJVzUQicGUVHjXQxwQMzdB
 SnUKGOHtSvef8Nc5lLw2xUUWip2GEsxD7FN0OJR4=
Date: Wed, 30 Jan 2019 08:12:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: [PATCH] usb: xhci: remove unused member 'parent' in xhci_regset
 struct
Message-ID: <20190130071259.GC1204@kroah.com>
References: <1548814341-15116-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548814341-15116-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_231303_492596_70D39ADB 
X-CRM114-Status: UNSURE (   7.96  )
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
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:12:21AM +0800, Chunfeng Yun wrote:
> The member @parent of xhci_regset struct is not used in fact,
> so remove it
> 
> Change-Id: Ic6727c28f7200782fe4516bcb41c789b427318a2

No need for this line :(

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
