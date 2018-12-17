Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:45:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2569B2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GOb9EAlt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvErTHEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2569B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SgV78L2dwTIfz1RDbzPRqZm7AarCdIpgbrAcbgCN4bg=; b=GOb9EAltu6mmTa
	Ys1oeXKPFDoCBt6GACiEWnqEiHmrewVCBdd3Q7eznaPHy9jt9rwRUJRMpvdLlsUTNroQL0hnJwL3d
	0IHmHD05XecGI8skY5cxYIbU5XDXNXRYW4rbXWd4NrvzOLT3k5W4+uSudTNJNP21HRGU/Eb/QiU09
	SAeX23EaAgROhSUMRmVLNixQWoVibbPbmGoo4YqUWbva4EmRWpMGeuS7U040y529dwvw5fawkQ73o
	XNFcecV+9Y+2wbHORgn0CfyRFop7U8eAcKPYibd0rlXzLmp0av6c7FPeePerF5KJQiPvdVDZJ294U
	PbgcF4C3O0ikjrLRbcxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYv4v-0002db-4a; Mon, 17 Dec 2018 15:45:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYv4r-0001Ro-RE
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:45:07 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD3952133F;
 Mon, 17 Dec 2018 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545061495;
 bh=3Am+O8bzLsX4lIsKqURhb2ZJECS0Dx436+AH/N21rPg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nvErTHEpWe0SUJryIKhiE9oTwhlveJRcKB5qgtc262n6OWWG6BwlUjl0NsAM3PcPT
 ZJx6PYi5OVOZDUGDVKsFENWl4wFF6rkR3hAblUOXU+rS+2SfWFfMWWhp2Ewj+2KDwN
 VgP/LVcUzTbni2hTEIFD3c67+m4MLX/uaOM5IYZo=
Date: Mon, 17 Dec 2018 16:44:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial: uartps: Add the device_init_wakeup
Message-ID: <20181217154452.GA9844@kroah.com>
References: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
 <20181217151520.GA12453@kroah.com>
 <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_074505_905789_8EB7E6AA 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: monstr@monstr.eu, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 04:29:56PM +0100, Michal Simek wrote:
> On 17. 12. 18 16:15, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 02:20:11PM +0100, Michal Simek wrote:
> >> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >>
> >> Initialise the device wakeup.
> > 
> > Why?  This says what happened, which you can see from the patch itself,
> > but it does not say why this is needed at all.
> 
> We will fix this.
> 
> > 
> > Also, you sent 4 patches, without any numbering, so I have no idea what
> > order to apply them in.
> >
> > Please fix the changelog entries up and send this as a patch series so
> > that I can correctly apply them.
> 
> They are all independent that's why I have sent them separately as
> single patches.

But when you modify the same file, how am I supposed to know that?

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
