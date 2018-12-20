Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F278C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBA421773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eqSrO7S9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ7qrSEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBA421773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zOPsnEGmC8v3ffmD5bvTftJFCtbbq7KrrFnN0jCEX+c=; b=eqSrO7S95AUr+B
	UqjZ1b6XBYGHrNeonjvDPqdRdmqrofzIus8a6slfFjcAHX96vwupC0zcavWjAMuL0O6AhhoqW/GI7
	/j0D9sAHxGNdrg1nL6Wt4glytC39QJyrvojhdwOVNd1X5OtedPzupSJYtAHT68Ap+KKh4rQl39CEU
	BcJmONVVoaT7zvUzmN7/DalhmNUaEVV1+aGChPno1/h8Fx72cqly8NYMgCVEOk7LWW5GsnZCKHUiH
	vnAvduOvad1iQHeirQNES71AhCzBxspCGowafxnUDky/4B9c90N0UHA4ApK8rTb8u7R4kU+Lbb+xR
	8nZCb6nBvk9h5X5+0dsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZwHx-0003We-PM; Thu, 20 Dec 2018 11:14:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZwHv-0003TA-5h
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:14:48 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4FC3321773;
 Thu, 20 Dec 2018 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545304476;
 bh=ZX3E9KLkZSZsJIlGRBHs6DgIyYx6jyueqRFmLMqTX+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZZ7qrSEpD/CaMKf6SSCS75j1gH4L1gdw1lpCyPhjgfVrQfu46kJzU4MwZ0qNdZ3H+
 TmXikLU4l+sgfSa6ULD09hryUW7VHhu23HgTfuzQKb6gGW1CBhXqXjXTmWkImEdZFG
 LzJi0IrDRDVcqoXYvolOQOeX2KzpZwGnqdsYW9PI=
Date: Thu, 20 Dec 2018 12:14:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v4 3/3] driver core: add probe_err_ptr helper
Message-ID: <20181220111434.GC10978@kroah.com>
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102300eucas1p210735c7753688a52a73ccf026884dd11@eucas1p2.samsung.com>
 <20181220102247.4911-4-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181220102247.4911-4-a.hajda@samsung.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_031447_231220_C4542C4F 
X-CRM114-Status: UNSURE (   8.72  )
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 11:22:47AM +0100, Andrzej Hajda wrote:
> probe_err is useful in multiple contexts where error is encoded in pointer.
> Adding helper performing conversion to error value should simplify code
> further.

Same question as on patch 1/3, please some someone using this.

Also, it's too late for 4.21, so no rush on this.  My trees are now
closed.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
