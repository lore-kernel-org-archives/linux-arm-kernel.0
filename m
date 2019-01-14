Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69474C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:28:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B42720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OTPvo0Jq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6xvO5AD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B42720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DWqXVddBLQJSC3zxRKgj/4GOQiRkXxiHuTTF+awf0mg=; b=OTPvo0Jqfx4YdV
	SbQxLrsJdL8lcLqT6tJ7U9WJ/338U2qNFZCtDSCvTzLrT2W/VjPO+3l2Z++8MFtIihVSdKJBCjZ0b
	k03ETyH10KextBQKj9ZzQ5NjaPRj7Gf6FTcpyX2bYYq2PDTq/hIMHhpjyM+n7nZ9uP0LCrVsazVKo
	qHdg5zlgrIH7Bx3/HzocYdc765nKFXvd173BJSbPQUPMe0QijZcwD2FdIo94dsj3HAUuXILch1OGi
	o+4gHZGFg3ggRG7cAi5hMQ0N2taYUoyUIWAEBjtTgDO2w1QOad7OafIUiWXOtMBjwEiVBJGICtC0f
	ZTB2oTmpeG5d/oPBhRHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj49u-0002ql-PO; Mon, 14 Jan 2019 15:28:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj49r-0002pu-Bc
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 15:28:12 +0000
Received: from localhost (unknown [122.167.106.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6D4E20657;
 Mon, 14 Jan 2019 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547479687;
 bh=cqu6imNTqYjl8eCYnCCtHgUvAjuni4/kL3nEHFQwWTw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L6xvO5ADvkPiBv9XCtZHRvKfP5hnb0ySxNgPfy9Y0zEX3iYMJmIulTS7PY8jkfYaG
 vOhFtU5ZBz+qJVUK7dUbKBUdzqnfUx57tn/IehG0NRERFftba2mvf2G+xPuC1YJ85Q
 NnC7wZaaGpF8y7zmfZfmvPeDr5xjPv+SuRLkyyh0=
Date: Mon, 14 Jan 2019 20:56:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/7] dt-bindings: net: stmmac: Add the bindings
 documentation for delays
Message-ID: <20190114152631.GA13372@vkoul-mobl.Dlink>
References: <20190102091729.18582-1-vkoul@kernel.org>
 <20190102091729.18582-4-vkoul@kernel.org>
 <20190111150104.GA1465@bogus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111150104.GA1465@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_072811_418991_809D9C3F 
X-CRM114-Status: UNSURE (   8.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Niklas Cassel <niklas.cassel@linaro.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI Rob,

On 11-01-19, 09:01, Rob Herring wrote:
> On Wed, Jan 02, 2019 at 02:47:25PM +0530, Vinod Koul wrote:
> > Some controllers require that phy delay should be disabled. So add
> 
> If the MAC requires it, then the compatible string should imply this. If 
> it depends on the PHY, then okay.

Thanks for the review, yes this was targeted to PHY. After feedback
from Andrew, I have removed this is v2 posted earlier!

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
