Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A07C10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F012085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NTCKQ/Jf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqTBnm1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F012085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MUEGiHpdZzNDZof8k8KzPLykNYqDhOED3Ki1n0LcyVA=; b=NTCKQ/JfzFWsHP
	A1Wrg6+ai6Py5rfEKxJ2vFq95j6hrUt6tdPip0/MlgsCnjMtgw6pcflc8m5jaE88CIBmNAqWxm92A
	JDNorDqkQxyWB/o3rrB9EdVI+LssbVrdB6MbB4brsGyTu4C4Sa86MyP8mbgRTjG5OMXWMPGh88B75
	nrjPPQYhUUiGWmlmyfV7ZSy7YU1g4suMXmEQDonki+ej1W6H5K6l+ZWY+U+ZGyFFIXxsZ2nKSlXks
	JlGmmY9c1RbpPtI9Fy2wKXXo2YRapTOvLz3b7axoWs2DSCLhAOxTMOaM+bNfHEFNewTr+l7ktLxUH
	W9ZhM9C4IzlDdT0Y2xxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvxw-0003XF-NB; Thu, 21 Feb 2019 21:33:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvxt-0003Wx-Mx
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:33:10 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2FBA720818;
 Thu, 21 Feb 2019 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550784789;
 bh=sA7VhBFf+IzaFqjsolIFDiXiFvP2LNW92/ovKseyWus=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=CqTBnm1yyJ4F47xyYK4nu0S563a3rDP+0ij+o/g5ky3FiG0N06GQ61oeviAF3L7G0
 hp9h5/JdB1xwCeIJkqPd2PAhkU7iXK77AU/P2IwMV55NXlLrxfMfbuh3j+JgXSPKM0
 f0IH2w3lqBJOaD8qcR0VVshy4D5TfxNQYtq94y5U=
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] clk: samsung: exynos5: Fix possible NULL pointer
 exception on platform_device_alloc() failure
Message-ID: <155078478830.77512.13175629638067796591@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
 <1550749552-8133-2-git-send-email-krzk@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550749552-8133-2-git-send-email-krzk@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Date: Thu, 21 Feb 2019 13:33:08 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_133309_769048_F7A73A55 
X-CRM114-Status: UNSURE (   9.25  )
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
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Krzysztof Kozlowski (2019-02-21 03:45:51)
> During initialization of subdevices if platform_device_alloc() failed,
> returned NULL pointer will be later dereferenced.  Add proper error
> paths to exynos5_clk_register_subcmu().  The return value of this
> function is still ignored because at this stage of init there is nothing
> we can do.
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
