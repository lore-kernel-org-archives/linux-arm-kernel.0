Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93574C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:11:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612DE2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pORA8x/9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfUlUD+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612DE2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DCU+oxSWoLQRtZRKzP/whf3+ocUwPXv0p8Rc6aSqM4s=; b=pORA8x/9yk9rcj
	53SvIEGi1e+p2OVKV0AHbR7lOVLvx7IUk/bapRWNOVSo+ZbsFMiPmbI631J61X4eq5HWu9uC2yCSc
	ITZPVl2Sl/OqFdOxfSGe4f2hcIqQP3VXm+k6sS7jSd0SZQ/MtzuQj63L04O2pJSZb/ooBzfx6ebTE
	x0nhHrJk3cSRtYwtRHk/7P6Xw7YripkgJoO53iV4b5G8148BZox99AaL1BmYalNz75uDByl3i4QBy
	eD2yS4Ez9ggHLKMo+Xd1KYyXPEk8+GhYtz+OJimooa7SJ062CCBE7NEMRiY15+ADAH1O0pc9/q15a
	f0Y8TLEEWSYAQpQYOZSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcAA-0001Cv-Cp; Mon, 21 Jan 2019 16:11:02 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glc9t-0000wv-9N
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 16:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nvnhEXcuhP3OmdqvOdrSFnY6N5HEGpiOmg3bXkrs2eU=; b=LfUlUD+0LJwKqw+O3cDvG50Yz
 X+4oDvAcKWNgshY6sL0o8UqqvF3Xt12BnCUR15ADd2lVIPPPR9lLmAStRygr5V9/KbVDLtRozcFhG
 QV+J7vaLJemtVpRUJa1FJakWxLkf4f22N1bwZIAw8v1E05mnDVTVP3KoY8km7cmHk/ywA8GQpZI77
 A0iUgI7LWfeRcEU6gxlKkqcu7y17xCiri4YXY5JZdHdTiyAB/WYKwbtMIqbnX0avBtiW9c1ZvqorH
 BsDbiFT4w/MFlvKcv62EG1UP+LMvCGJVs2xXScrakT7Mh2xjrkBljjE2mm70LUGNzxYAX9FES4Xa+
 0S6FPPuhw==;
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbpO-0007SN-9X
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:49:34 +0000
Received: by mail-ot1-f67.google.com with SMTP id v23so20882465otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nvnhEXcuhP3OmdqvOdrSFnY6N5HEGpiOmg3bXkrs2eU=;
 b=rgu1X/0uXC0dWiWCKjRyw3zb2r9QTqySSxs5L2bhQRdU0XUszASmR8srwmzwWMcuRl
 DA0iq+QuvpoZkIs0SxwAt8VW6DaoGbtXV8YJUf/QaIg63nigeqgH7+xT+uxYikKI7oTC
 oDquy7NKo0Jxmd8ZbEB79HGLOEDKDlQdpoI4MtjVrzKEE14c7Eca9pMcmMafIEedbVdw
 +UastbzJ7eO+LzF69ewXTtyM3unCGgffiOqWc+SX7IDYkHbX2v+HME9oRI07lZiioBYT
 +xs6+SQEu02yKb9NwCZ7PxYoj6IeLK4sNIul5uI8A5UtolYntbTMdWUfYlFv6XhiYaeR
 9eOA==
X-Gm-Message-State: AJcUukcaCbdyMq5pQJ8bHCbkRV5U0EsfqB+JhXkap6C349rSBdqYcjTZ
 MaD3IXPWgZr6bpOcxmcA5g==
X-Google-Smtp-Source: ALg8bN7APw3eXU3AmWu0TV7lozUCJ9u4nJffqFs2O5AuRhXh30YdEzlNFdykmbSuTcaN5dpHM7JWPg==
X-Received: by 2002:a9d:1982:: with SMTP id k2mr18981973otk.197.1548085769003; 
 Mon, 21 Jan 2019 07:49:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id h25sm6004941otj.27.2019.01.21.07.49.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:49:28 -0800 (PST)
Date: Mon, 21 Jan 2019 09:49:28 -0600
From: Rob Herring <robh@kernel.org>
To: Nava kishore Manne <nava.manne@xilinx.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190121154928.GA32129@bogus>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-7-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121173835.21173-7-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_104934_346059_AB34A8BF 
X-CRM114-Status: GOOD (  18.38  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, JOLLYS@xilinx.com, RAJANV@xilinx.com,
 michals@xilinx.com, linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 11:08:35PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Removed PCAP as a child node to the FW and Created
> 		an independent node since PCAP driver is a consumer
> 		not a provider. 
> 
>  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..1f6f58872311
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,13 @@
> +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
> +using ZynqMP SoC firmware interface
> +For Bitstream configuration on ZynqMp Soc uses processor configuration
> +port(PCAP) to configure the programmable logic(PL) through PS by using
> +FW interface.
> +
> +Required properties:
> +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	zynqmp_pcap: pcap {
> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};

There's no need for a DT node. Just make the firware driver create a 
platform device for pcap.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
