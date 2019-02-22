Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA434C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:03:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99D520818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I73YdGCI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsCXaJtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99D520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YXrI9lJR843IPE6twCrQfPi7KYyx/GHYSHK1CfwwGFE=; b=I73YdGCIYbFRsZ
	oSf2i8LBIK6jyI3M6FldneAcwG/7yg6dPOBgpbO4NPbsMy1CbYbBtEHJPKcdIZprkv7asbXiCz65z
	p4bZKk0Cbmti98TK749V6vwTBKI6LMT5tUBd9zjuJIuuLPpnsNdvMh1kB0ZEHp4NzQxErDIljELOC
	mgiy7p1j+vckGuaFePLbpFiseGrC5ic35AKA/zhHWbyLxN4UCKG+ItCL36vORSFIrCc9+bCh7kIE1
	Czl7ZV1oQMyZj7snonOsk48nvIu++bdfoa4jSfrg0snNsNjH5kaTIhZ4RXQ3xXx0HHwNcNQhiZUzl
	nnzZNgG7Yc0s4xITlNig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx5nn-00022R-Ki; Fri, 22 Feb 2019 08:03:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx5nW-0001mu-Vn; Fri, 22 Feb 2019 08:03:10 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D4962086C;
 Fri, 22 Feb 2019 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550822586;
 bh=B+hxSpo5sj6W1BRmJxu55fXbV+HKy9aHmCOhAt6Qn4Q=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=MsCXaJtxxAtxI/5PRstbwzzIkAkncHZ3XH0/tPPbc0C1ywFbAbLRWzv9uvguEZrwZ
 quH8EJmdCOCuv+t/KjorrpR6gfzKJBwXBS/r4k5BZpZSoD6bKc6aZj5Ew4iDzSofX8
 9hhBtitTl++ypjBBCILNmjevUd2e54JFCjfdgjsU=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add DT bindings for Actions
 Semi S500 CMU
Message-ID: <155082258579.77512.3841323897834397638@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
 <20190115033340.25016-3-manivannan.sadhasivam@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190115033340.25016-3-manivannan.sadhasivam@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Date: Fri, 22 Feb 2019 00:03:05 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_000307_406897_30F415DB 
X-CRM114-Status: UNSURE (   4.73  )
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
Cc: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Manivannan Sadhasivam (2019-01-14 19:33:36)
> From: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> Add devicetree bindings for Actions Semi S500 Clock Management Unit.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> [Mani: Documented S500 CMU compatible]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
