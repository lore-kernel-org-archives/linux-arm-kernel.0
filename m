Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A85FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:17:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE30E2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORcw3x84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE30E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ezl4z4SLVQxXbAK3sSUZFrYFg36rBxhv8kER0Xitiho=; b=ORcw3x84s4IQAi
	djU9VcWoA+rP96okVUT40UNG6LHZ02aAX01Xk59WLY3DojINxVfAXUTK9j1ORiwfuR/QgIdx6Xrzl
	3BsvTjHjVgIcUAvrAt5Q8LvbD0YvPCvu1RTx3aR+xVdg9kfrTtpvU5JWSGuGd+ORrL8pTyHoa5fe1
	X38dD+7OdkcBxbICXn4sVJi+RpXi/fghNquMlKfaMh10kF0e8GlxizJM5imyeKb4I6HFq84a8EG/9
	j5uzLsIlIDoJXtgjGUApt7yEpzoqUG48T4a6QwigE7LSFp6njd+QC3QqhM/+k4GwprJyGvthaLCxu
	GTxSvB+ImYoD1J1Tls5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqIL-00049e-0s; Mon, 18 Feb 2019 21:17:45 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqIH-000495-Gx
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:17:43 +0000
Received: by mail-ot1-f66.google.com with SMTP id i20so30756647otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3bLilkxupU5biE5l2YtxaXDj1b79ugELOWAt/WK8Yj8=;
 b=LZix/CMh/pO8G1H/TVHHY4ASxDryq1GWtIeHFAirUtYxAysofh3XydeR0vGPx8RFSn
 RaaRWRaImIqOSUSCIKvSVk7ShbycrZTH99A11YhbUBEUvenh+KbURmuFP4Qxg59z8Ki6
 gAwzavr5Lz1Ha/xJjWN9tswwDKBcD2yIQjyiKsgH+n6o8ODphjiojvv6L+WqrF5s4rid
 h36nFLjsZDYJ1lXRdODvnDIiXnDRlB4uCrszxxc5fei8eHndL17AFY/l3Ze/qwIU6HRX
 I5GIOAMld5ldyfk4Ih4vVjUqB83DWl4XdAgg0FV/RTFSJh/opWwdYQb8181YO2QFUcUv
 wNqw==
X-Gm-Message-State: AHQUAuYnr1/M3vLZlqM4XWkssDKEYNx67qumjm2x9lUPycittX52R+/i
 qNqzvMoWnPP8hCz4L6Xolw==
X-Google-Smtp-Source: AHgI3Iaa/RtJdj/eenhBEA1SkGhA7JfuvzlvX9Zqp9ycSTR6GsBlBExeqb6/5QwMseEecUzlIXY2dQ==
X-Received: by 2002:aca:50c1:: with SMTP id e184mr517052oib.148.1550524660798; 
 Mon, 18 Feb 2019 13:17:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g3sm8205614otb.66.2019.02.18.13.17.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 13:17:40 -0800 (PST)
Date: Mon, 18 Feb 2019 15:17:39 -0600
From: Rob Herring <robh@kernel.org>
To: Hyun Kwon <hyun.kwon@xilinx.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: xilinx: Add the dt binding for
 Xilinx AI Engine
Message-ID: <20190218211739.GA19490@bogus>
References: <1548119537-1788-1-git-send-email-hyun.kwon@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548119537-1788-1-git-send-email-hyun.kwon@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_131741_563181_07217A01 
X-CRM114-Status: GOOD (  20.75  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 05:12:16PM -0800, Hyun Kwon wrote:
> Add the dt bindings for Xilinx AI Engine, which is a tile processor
> with many cores. The compatible string, 'xlnx,mathengine' is kept for
> backward compatibility as it's the legacy name.
> 
> Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt | 19 +++++++++++++++++++
>  MAINTAINERS                                           |  5 +++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> new file mode 100644
> index 0000000..fade9d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> @@ -0,0 +1,19 @@
> +Xilinx AI Engine
> +----------------
> +
> +The Xilinx AI Engine is a tile processor with many cores (up to 400) that
> +can run in parallel. The data routing between cores is configured through
> +internal switches, and shim tiles interface with external interconnect, such
> +as memory or PL.
> +
> +Required properties:
> +
> +- compatible: Must be "xlnx,ai_engine", or "xlnx,mathengine" for legacy name.

Use '-' rather than '_'. No legacy names. It didn't reviewed and we're 
not going to be stuck with it.

Only 1 version of the IP? The compatible should be more specific.

Are details like number of cores discoverable?

> +- reg: Physical base address and length of the registers set for the device.
> +
> +Example:
> +
> +	ai_engine@80000000 {
> +		compatible = "xlnx,ai_engine";
> +		reg = <0x0 0x80000000 0x0 0x20000000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d44447..d119d1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16040,6 +16040,11 @@ F:	Documentation/driver-api/uio-howto.rst
>  F:	drivers/uio/
>  F:	include/linux/uio_driver.h
>  
> +USERSPACE I/O (UIO) DRIVER FOR XILINX AI ENGINE
> +M:	Hyun Kwon <hyun.kwon@xilinx.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
> +
>  UTIL-LINUX PACKAGE
>  M:	Karel Zak <kzak@redhat.com>
>  L:	util-linux@vger.kernel.org
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
