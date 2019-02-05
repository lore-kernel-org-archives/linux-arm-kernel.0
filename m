Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7428C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:36:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E61220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oCsW1o5H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Jnd3wVDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E61220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Dn2d5tRa6kZlKHBQtJljt0DojFZTyGYw/wTx1+SdzjA=; b=oCsW1o5HOccOEhZCtgg/ZEC+o
	anSnqlpvB9/H7DbcR21TjGM8X4+MoD1UV7zSYXmm60FG2yEIBFBOHxYp/QbVqkpHGyt3A2L+IGqV9
	Wy5Lxp1Evb5ftNPfJ3swjnrgT2WJQRaBCHIOPa+BNT74OZ7By2LyBRZywpofPVvegN0jSlkJU1df1
	47bfQyNJjBWxoZy4u+T++N7SHgFKi72Hz8jH8r8voIAZuysFOJyfj48tYBdueWrixlhAbyQtRvbsQ
	09FLoKlG4BTHzN1KOwV2zMpR9gY8VrUsLA2gD886y5sXqrVxKGU09HssoMWrr+OAA/XQBrCFONfS+
	DfpVY4DuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqqb9-0001fc-C1; Tue, 05 Feb 2019 02:36:31 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqqb5-0001fG-N7
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 02:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Ii2OrRv8q9QhqsfyxkKY3clIW4xYpWnSM6/z8OuiBc=; b=Jnd3wVDwh3Tc+aD5z0VGypVT0+
 wiXtPXeNaAlhs9SJXlqvcx+7x2nXWgVRkJouubfCAtSwsKGwk5zOK9kY/Cd+FA5IQnegylbld7c43
 IOb1MJUINKamoa/+qjwwV1g+4JldsztRXOfoZ/jGGJf6SLXt/4t9X0Uq3RWeUgLXfCGD2Z2vIWhi+
 XQz7c88Tb45bu08ZHeyzsNIlucNuVWXTnOzlFKd5SmD2f87rgnU7Y7W0gdw+1b5w5Tqo+FzgYy/rO
 Uql7S7tFH/jOX0xDW+KEELlBN9zRwGWSSKs7DtCi/RHsjo6H6xWnDDMcJFE4XhQ6AIOIxDWzoll69
 WUMts2ag==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:34532 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqqXa-0008Fr-2e; Mon, 04 Feb 2019 21:32:50 -0500
Subject: Re: [PATCH v2 06/12] ARM: davinci: da830: switch to using the
 clocksource driver
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-7-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <e1430729-49c6-c1ad-508e-d3090208e29f@lechnology.com>
Date: Mon, 4 Feb 2019 20:36:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-7-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_183627_869903_12F0EF26 
X-CRM114-Status: UNSURE (   8.85  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now have a proper clocksource driver for davinci. Switch the platform
> to using it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

same comments as da850 patch



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
