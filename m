Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BCBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:30:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32F120836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n0WE/8oC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCWorGNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32F120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aqZkNWqXU9pai6Ge0W4lKBmy5F/BBvf+MM8FnWuUdVU=; b=n0WE/8oCWP7XT9
	JeSx7gaD59pp3IPv2vIqM7R/2sV36sZ7WfRdQcwSwsSPYoHQWIMaIE8ozIaTtLhWrX3dEwWrLjU9i
	TTGgJp+5H+L+uL1G+Kffc6/nZdY9qavYPYKv83p5Z0RxrhEHHKw6nKTU7b14qHGohPkHdGC78LWBo
	6J6RSe2Rf4odzMv5gNOhWMhy2zAdsZ1QpwkFRXGV7A3PWPmgwLea+3RBvKyU3J9d1NfmlH8ydlSTY
	ypi/3jXf7F4jzPqk6gOPoJUPZeXtVCdy/h9DeoD2KNXmxf1GprFDVPIy2wa7xjrktpiV1qQXgV7x2
	c1/ICYThHlciF4iNSDXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwqp-0001Pt-QU; Thu, 21 Feb 2019 22:29:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwweF-0005BW-Ci
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:16:56 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F1D5020818;
 Thu, 21 Feb 2019 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550787415;
 bh=lkdR7iOTNdzrZJ/MCEMysfvGwqPVUOqZA7F9Zbi2jGE=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=BCWorGNectwZh+YdGIk3tTL9teMKJKqKVMbjyoYpK23ZJo+WGtHPayPYpFROrn89f
 UtSFzlq+yrTkJGJy8oI66/UDQfyExwtnecVrXp0AJik6OAuj7I/dBVXSsS5Jo3Fl9X
 uKglMpJFTrnxWxQkgIIalbSd7RGy3C0ZLfhKNFSg=
MIME-Version: 1.0
Subject: Re: [PATCH v2] dt-bindings: clock: remove unused definition for
 stm32mp1
Message-ID: <155078741430.77512.14260216742704556101@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190214104242.1491-1-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214104242.1491-1-gabriel.fernandez@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Gabriel Fernandez <gabriel.fernandez@st.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 Feb 2019 14:16:54 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_141655_455007_4B6D09DE 
X-CRM114-Status: UNSURE (   7.90  )
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
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting gabriel.fernandez@st.com (2019-02-14 02:42:42)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> A copy of LTDC_PX and ETHCK_K (LTDC_K and ETHMAC_K) was introduced in
> stm32mp1 dt-bindings file by mistake.
> These bindings are not used and shouldn't be use to be conform with
> convention name of the stm32mp1 clock IP.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
