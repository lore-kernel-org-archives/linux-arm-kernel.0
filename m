Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C701C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:06:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CDBF20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="frUwPCvo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="jveXLHt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDBF20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cMv9rJksR6jqH2M+ScJ2FFwyQYSNTHkzo6IOIgyaOyk=; b=frUwPCvogxrzkmByPAFerHPXG
	RRp+Fnfdw7hi8J8E2gGJZiRBz9nu0PBtb3kyKxdazPxR93QSd6dxDWhdFFT6h7sF4wmX9EqLk9H+v
	TocHFs554lu6yNFHx3+6oYqJucOrrbIwFT7rLqq013TD15y8ok5U18ndE54CIeHc4um/2VrCm3DOn
	EQYMSfcLiremP1OjaQYJt8urXjiyGBInMOLscD64p0Urw8cB/2Ni8cJ/qLZH+vduwXtOeVSmKVK3G
	IFHVHEQW9WP3XIsOoiBXhox5v2CymHqADUtww4zRgZn4f1FQnYGJD1gdDqe4oP7mHule1D0rrbmIn
	3uuehAbAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqmNr-0007Z0-7z; Mon, 04 Feb 2019 22:06:31 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqmNn-0007Yj-Ff
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 22:06:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zEWsiLpUzf+OqCji6P5yLbl8b3/ldLwtVAqSbUjXBhc=; b=jveXLHt1g76Z+7vajtza/jMiLY
 YFxrdy/DBO9/mpKqfkzFsy4buw32tTRe5qnDYFRamzy2rt+vlg2PHEOLez4cxz2/7FFLzprVa765G
 Lu1VDya86WyUTImu8ThK7SB0itjtYSZpG2+sJ8KExCyfaYiOP3u2d95TB82OJ0YEqyEc/xvznMJmH
 cxYBviMTjq/5aF8vdA5yUTIDIaVnnEMw2hmTvP4SkDw0u8GpqddkQRo3xQ3jWnEL1oQA9guzcQm+x
 GUnSc9aVLj73lVkkuHiKXQT5jr4jOUdsNMNNQ+NakCyyL0qn4MWommsi8wUPhOxBNyscL/6eMAno4
 MldT4pdg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:57624 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqmKI-0002yO-EC; Mon, 04 Feb 2019 17:02:50 -0500
Subject: Re: [PATCH 04/35] ARM: davinci: pull davinci_intc_base into the
 respective intc drivers
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-5-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <339e09ec-e316-b8a1-8e10-f954fc9b9c2f@lechnology.com>
Date: Mon, 4 Feb 2019 16:06:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-5-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_140627_606335_4BF80A05 
X-CRM114-Status: UNSURE (   7.33  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This variable is defined globally in common.c. Define separate local
> variables for the aintc and cp-intc drivers and remove the global one.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
