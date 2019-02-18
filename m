Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA96C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:28:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D022177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YchN0as7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D022177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GR7CWr6pMQBFQW6ZLG7YahK/xfAUgAvrMQxA+u/5Eqs=; b=YchN0as7/0Pnhw
	ixj6kwURIOYqZkn+NZHhNaoPN4lLLCSMm4stH/IAbSxs++Hydb++t/FPYy+PHCpSX3wKxSl9f0KlG
	r+VSrzb1BhFnNYZV9lY3wW6u4hn3sDKmHKG9euu9/6uRK2lKR9aerBhsI45XlYVAaOprc00fyCVE9
	tWQTyXDWvX7onZKoA6iyXaeJ8n5dWPUKXy0wQCT8Gvb/yjGBbe985wgCrcAsZ6SmPb72Ycdo35Rx+
	IvQ0Tjbd5EN0wQY8j73+bdoOBy60aWgJvhxNUbvTgNRQUADgfczm3XePo1DFZpIYPmtj3JufzeA+P
	eqloXZWrmG1rnM1Jf5Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmiA-00006N-3z; Mon, 18 Feb 2019 17:28:10 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmi7-00005M-HM
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:28:08 +0000
Received: by mail-ot1-f65.google.com with SMTP id 32so29478217ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 09:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mp0Y4/w1Ryp7+w4aXGtF4QaXIIN4inc1wWBkogoPt20=;
 b=Zow2i9768xgDPIUzFJc6YaFiC48fuX5tmMy598M7mEbGYwWdVRvkANNa8OYxQ5EdqO
 ZznEasglt+mhH7VXHFsW3KE2eXjFVdG6KsBS6LuqklweqZS5FyCeq+8Y65+z8aQBk8eh
 EGh/dj7EXmGm2ylUvulU5FB5ShLL3Z3uf1bDfClGJCjLJIH3GKJLN/l7a6Z1VC/T35Yu
 cQdKyddjgt+wE4WDRh3Ml4LGEoagy1jVfYS+T41p1LEL3vZWcxebLtDwks9mbGICFeCh
 3ov5nn6d8ls7EDA2KVGDFeP3EkAnVcCil8GmS7hIfp3y9SiupuF/m5esxcAddB4EXPCN
 fVfQ==
X-Gm-Message-State: AHQUAuaflp9TK7jEuY0bLDntdXOhpgAel9mWksdt8JKuqA7r2IzdMqgi
 lp1XZVfEFDkzD3zVckEUvVBe+Tw=
X-Google-Smtp-Source: AHgI3IYNhY/rHEG0QCkalZy8YHsvnTFQ8ijleNLOx9z6vuriu0Ed8PLtefIglZXBUKUTWoc6kgdZmQ==
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr8269912otq.265.1550510884179; 
 Mon, 18 Feb 2019 09:28:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d65sm6751376oih.13.2019.02.18.09.28.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 09:28:03 -0800 (PST)
Date: Mon, 18 Feb 2019 11:28:02 -0600
From: Rob Herring <robh@kernel.org>
To: Nava kishore Manne <nava.manne@xilinx.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
Message-ID: <20190218172802.GA1376@bogus>
References: <20190211161736.23844-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211161736.23844-1-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_092807_574323_7E1E8C76 
X-CRM114-Status: GOOD (  17.69  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, atull@kernel.org,
 linux-fpga@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, jollys@xilinx.com, rajanv@xilinx.com,
 mdf@kernel.org, linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 09:47:36PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.

I thought I was told in the review of the firmware binding that is went 
away...

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Created patches on top of 5.0-rc5.
>                  No functional changes.
> Changes for v2:
>                 -Removed "----" separators.
> Changes for v1:
>                 -Created a Seperate(New) DT binding file as
>                  suggested by Rob.
> 
> Changes for RFC-V2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.
> 
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 0000000..1f6f588
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

There's no DT resources here, so there's no need for this in DT. Just 
have the parent (the firmware driver) instantiate the driver.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
