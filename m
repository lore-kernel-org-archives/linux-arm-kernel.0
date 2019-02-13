Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F60C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2592086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sp9VgzFV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zZ/MEZ0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2592086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cN2aiXzKo8R7+r9VMSWj8GqfCDjmGxrzK111S+cATWk=; b=Sp9VgzFVyZFPmw
	j+vzn/JM2B+pjkKN0mGJT/Jhaj6Z/r3aK4A/haw5c7IHBASJpWSNB7WGfzqjmT2GtyDL4R1cY7Gpa
	XzPtqeL1iRWliL815FueJQJGJdkk1B70iNXby0RNMr6iGRS2Wz4Swr+I868KM7AtR3bK1uuE5IyR/
	FmCFQXboTp2h0CLRtTBzCIMl5ZMPYBPx48b2LryJ+FILSgM/NVG+MIoSYsL7gH7Zu2iTnb4T1I+tr
	mhOZ2r8mxU11gSDomJyvpFykaL56SKA/6boIBMxSIfUUeC5CjMjV6HM9b6wegLzyW67GHtHzSA2ai
	KQgHErsClADENXEtrdRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyl3-00060t-Iw; Wed, 13 Feb 2019 17:55:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtykx-0005ul-Vk
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:55:38 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 409E9222B1;
 Wed, 13 Feb 2019 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550080535;
 bh=mzOeovzamvkxdP8MQLu4eGQgRa6Mt95/laR5yOxjrMk=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=zZ/MEZ0F3A8vE6MMsaId4cTj5Yj9ImX5wdqW7RRBFuBArAVn9GwukZNJUgSCo6IwU
 roQB3H3MumD8b9muXyYrKTWpqVsprWmsXCVWfRb4yv+ffsRp3Ic5PYhTfA2Oag92Aw
 kyYrWT+aExW9Yl+A9FUr5CcMFcb9z8HnwO0nycYA=
MIME-Version: 1.0
To: Sugaya Taichi <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock
 description
Message-ID: <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
References: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:55:34 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_095536_386442_E9BD19FF 
X-CRM114-Status: GOOD (  11.89  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Sugaya Taichi <sugaya.taichi@socionext.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The subject seems to have been cut off? "ndings"?

Quoting Sugaya Taichi (2019-02-08 04:27:03)
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> new file mode 100644
> index 0000000..bcfc5df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> @@ -0,0 +1,49 @@
> +Milbeaut SoCs Clock Controller Binding
> +----------------------------------------
> +Milbeaut SoCs Clock controller is an integrated clock controller, which
> +generates and supplies to all modules.
> +
> +This binding uses common clock bindings
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,milbeaut-m10v-ccu" - for M10V SoC
> +- reg: shall contain base address and length of clock registers
> +- #clock-cells: shall be 1
> +- clocks: shall be an external clock
> +
> +Example: Clock controller node:
> +
> +       clk: m10v-clk-ctrl@1d021000 {
> +               compatible = "socionext,milbeaut-m10v-clk-ccu";

I thought there was some length limit on compatible string names. 32
bytes? Just barely under!


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
