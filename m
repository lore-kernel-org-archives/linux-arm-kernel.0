Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A0C282D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:19:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D488F2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P1m1D4in"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D488F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X4JGLDR9TCgH0YGHInHR6noCG9BzuCcmWC1TxQWdxu4=; b=P1m1D4inrGW9Tv
	4SIybFS8fbxW49e5a9k28NeAD5kkneV4vkUqDy4WpPABNy73GaNGwPEl2OmYydFVTIJnX8ZculUxI
	QZ100+qd0Et9oVNByoj69a/6bq/+RNLKFKS2RVNCJza0rAJ5+AIuUKPvvMgaZNFTTP0iZoLPFMUvF
	e+gm1iEP8U+hI0M5+KaNUrNS7Wihl58KbpjXlaeLjrCEq7OHBDVD67I0ZkujOU6Ap/4ombKVJcPun
	+Xj7Q8uaKSlYuH8ztRJ2hUVTMwiIiQrHiM7u/YFUd/EnI0EokayevPRFvgn3NwQfmnet8MiY04/OP
	tQHKi8JJeuw0I4gzMGcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goX2O-0008Jp-SK; Tue, 29 Jan 2019 17:19:04 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goX29-00083w-UL
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 17:18:51 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id D6600804F;
 Tue, 29 Jan 2019 17:18:57 +0000 (UTC)
Date: Tue, 29 Jan 2019 09:18:46 -0800
From: Tony Lindgren <tony@atomide.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171846.GD5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
 <20190129171151.GC5720@atomide.com>
 <20190129171538.GH10524@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129171538.GH10524@sirena.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_091850_011393_9705AF93 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>, Doug Anderson <dianders@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Mark Brown <broonie@kernel.org> [190129 17:15]:
> On Tue, Jan 29, 2019 at 09:11:51AM -0800, Tony Lindgren wrote:
> 
> > OK. Let's see if Sebastian spots where pwm_vibrator_start()
> > and pwm_vibrator_stop() might get called multiple times
> > or something similar.
> 
> Given that nobody has noticed that the driver stops working entirely
> it's possible that the pattern is something like:
> 
> 
>     pwm_vibrator_start()
>     pwm_vibrator_stop()
>     pwm_vibrator_stop()
>     pwm_vibrator_start()
> 
> so it's a temporary underflow that gets corrected (or it could be that
> not many people are using mainline kernels on these systems).  On your
> system it's the dummy driver but presumably some other users have it
> connected to actual regulators.

Yeah that makes sense.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
