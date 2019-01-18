Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C0C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:34:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A968D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eqqrkBDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A968D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SGemjuK/DHdrDdBnB9OGs3Rg8k0vyXPUp9kKTE9rtOE=; b=eqqrkBDgJJGXdM
	zB9MRDe9bLR9+cELWeeWe422OfrTFa1DK+p5v8V8+YlQcwXPw3t+LqxNXzFbcY0fvFM86BVSOEcKy
	8Bw1Ga7SrLty2TWNWptsF0TKX4QIJ3rViBJNd3BnFrkdirvDhelpiWTfGcJlYKTOiwYbdPsfmy3jz
	DQRs0+4CO8M5qyN2qtotx7lpVSPYMfZHlyU5eCODsFOHlrvXowjcGt+90KLtgD1ZWb5+ArlIIBDqd
	kuUsnN839OZJLshnW/m5y+hIE15B28I6L9DiGc51QMZAViynm+c/+ByP7swmyt4EUiyhk3zlMprX7
	n/iNfw3nYD7xDo8XCkCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkVEL-0001zB-CX; Fri, 18 Jan 2019 14:34:45 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkVEH-0001uU-4v
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:34:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D4EEBD;
 Fri, 18 Jan 2019 06:34:38 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 356653F5C1; Fri, 18 Jan 2019 06:34:37 -0800 (PST)
Date: Fri, 18 Jan 2019 14:34:34 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: kmemleak panic
Message-ID: <20190118143434.GE118707@arrakis.emea.arm.com>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_063441_330666_1CA325B7 
X-CRM114-Status: GOOD (  12.20  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 02:36:46PM +0100, Marc Gonzalez wrote:
> Trying to diagnose a separate issue(*) I enabled a raft of debugging options,
> including kmemleak. However, it looks like kmemleak itself is crashing?
> 
> (*) https://lwn.net/ml/linux-block/f792574c-e083-b218-13b4-c89be6566015%40free.fr/
> 
> Did I do something wrong?
> 
> We seem to be crashing on this code:
> 
> 		kasan_disable_current();
> 		pointer = *ptr;
> 		kasan_enable_current();

There was another regression reported recently:

http://lkml.kernel.org/r/51e79597-21ef-3073-9036-cfc33291f395@lca.pw

See if reverting commit 9f1eb38e0e113 (mm, kmemleak: little optimization while
scanning) fixes it.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
