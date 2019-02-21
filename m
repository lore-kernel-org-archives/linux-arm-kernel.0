Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ADAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482BB2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="InVF2t0D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulw0VhcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482BB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=37PubBCVmuJN3UyESJ6Il9olVemwsJq9cUgAFHE0kV0=; b=InVF2t0D+Gt7yj
	Ujp8jvTKlmHx0/CjlfEzeIPEN2cq+KrRuRPUhdNC/wQiF7Y7i2e4JFN1DtaSDrz3rCBXJoth+SNHK
	39/Ae9dx9BdRa25JAsMupxAYfWU6Z7v6t71oYKkStGvDHsXgmFY4J04yskgP42SCXFAiqwZs1vxD3
	MEZeTagcLCVW/qdCOng4TQCOipbLOV11oIclC2YLadQ54V+iG1o8Qwvr4djYeyt0Hhyra3c4JXi9+
	8TqAHw8I9IbW7EqRj52dJOb5dZhEVPkB9dj+fon1iBBWof5xPLTbhBSImPOAYt3mkHfN51w/CXTly
	xkTX54U1tw9plzryLUgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvy7-0003jK-6J; Thu, 21 Feb 2019 21:33:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvxy-0003YW-3X
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:33:17 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ACA4420836;
 Thu, 21 Feb 2019 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550784793;
 bh=irY+/5PALgB+L+zeN8czt5RJIiXzW8DIYcm8+fBZVdY=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=ulw0VhcHPn+eRnAFOyscVEw+JirvCTX37j7mROtyeIAJYUiMTGALGIHPUjLwJzJOI
 Lp6iuK8BmEiq4do+LMZuYo+F8bYMkfEekmTcKDoowalfohX/Nqx5gB29k4yYL9gffj
 BBV2fN0VjDK246UPMimLTxxtdBTgBDropSHwF6J8=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] clk: samsung: exynos5: Fix kfree() of const memory
 on setting driver_override
Message-ID: <155078479299.77512.7336673875297969172@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
 <1550749552-8133-3-git-send-email-krzk@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550749552-8133-3-git-send-email-krzk@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Date: Thu, 21 Feb 2019 13:33:12 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_133314_459622_6E3E39BD 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Krzysztof Kozlowski (2019-02-21 03:45:52)
> Platform driver driver_override field should not be initialized from
> const memory because the core later kfree() it.  If driver_override is
> manually set later through sysfs, kfree() of old value leads to:
> 
>     $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override
> 
>     kernel BUG at ../mm/slub.c:3960!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>     ...
>     (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
>     (platform_set_driver_override) from [<c058e908>] (driver_override_store+0x20/0x34)
>     (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1dc)
>     (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
>     (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
>     (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
>     (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
> 
> The clk-exynos5-subcmu driver uses override only for the purpose of
> creating meaningful names for children devices (matching names of power
> domains, e.g. DISP, MFC).  The driver_override was not developed for
> this purpose so just switch to default names of devices to fix the
> issue.
> 
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
