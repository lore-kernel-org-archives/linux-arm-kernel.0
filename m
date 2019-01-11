Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:11:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B112133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="msef4nxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B112133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D5hkg69zMXTB+v0HAMfcINZ4Vzg+SSdQZpjyzX7LeU4=; b=msef4nxrMUNEck
	lrVttiFr4e884ipeFIYf/DrjsxonHnzuKwzefGHzF7zOp22Ma4SdmTWVYjpoWAnphy+h8YEoiAwnb
	N9A90EYGNI3Wh5pP6g7oPhjm4rsEdkwA1WjpzAweZ3e74FHnAceTgY+eKMTDQQWs+bTlzQ6c37WrR
	oz5azx9xi3vQkuxPzJdIXQmaUpB+g8o19f11Cv37kfwQ+rNVu0UisrGTEk3/5CZha+QIPLImDS1Wn
	bAYoXNObNfzXr0Xjm/HoGNwqmaQki8UpV8disRIVu1XTaTfwVnH8hcoQiJPXd3NVev+dioZxwyFs7
	IqVuk09a9GS5RcGhRvLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi39Y-0001BU-GJ; Fri, 11 Jan 2019 20:11:40 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi39V-0001B1-5Q
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:11:38 +0000
Received: by mail-ot1-f67.google.com with SMTP id u16so14212866otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 12:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q2ZumaCzeCVRDmWhVySEc2M5WhLU9+Fq+Qj1ZVCepxQ=;
 b=GQ/d6L+iZay40zrJzL9otGh7mJ5Nsz88Zc87Qp8huWI8RwNXfUUb1qutZkTSTOKuCt
 q816JAerCdpvbUt97CdApQr+2o7oBarwwvhbWhWWYK7fUNb7h46higjIUoFIyTNPLSqi
 ypDv3XR4nrGbfLVzXo2ZLYY4oSBdnk3YlYuwkpXndXsTEYC6RxYqmEaUIC1ucW1+njBP
 7nY1QbTT3N+NeUvy5LUuGnFcI2eyfByX+uA1Ec9anD4mY0+kgf+NWze997jYX5F++l9v
 SCQSn9gVGj+KNVbLbni+ZlNl951Vo37J3zh9qolIRwJk/Fmgd3MXBo4FNQ+XtX+vYm2D
 hbKw==
X-Gm-Message-State: AJcUuke/aC0meibe8lGwXtRzDieCUSoeLIbf1Xn/iLc8KFtspSoO4HgC
 teibHxGnyLsJVkYRoiOLfabdGOpAOQ==
X-Google-Smtp-Source: ALg8bN6Dbogdgn5X/2YMxjCunA4TO1DiJ5s/kz0HQJm72dJIYkszrUGAeK5zMNPwaH8nwrwWl5209A==
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr1839239otf.111.1547237496375; 
 Fri, 11 Jan 2019 12:11:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w15sm35519928oie.43.2019.01.11.12.11.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 12:11:35 -0800 (PST)
Date: Fri, 11 Jan 2019 14:11:34 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: reset: Add bindings for ZynqMP reset
 driver
Message-ID: <20190111201134.GA28900@bogus>
References: <1546638982-12954-1-git-send-email-jollys@xilinx.com>
 <1546638982-12954-4-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546638982-12954-4-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_121137_206502_2DFED420 
X-CRM114-Status: GOOD (  17.20  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nava.manne@xilinx.com,
 michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 Jolly Shah <jollys@xilinx.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 04, 2019 at 01:56:21PM -0800, Jolly Shah wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP reset driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt           | 148 +++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> new file mode 100644
> index 0000000..e9c1af8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> @@ -0,0 +1,148 @@
> +--------------------------------------------------------------------------
> + =  Zynq UltraScale+ MPSoC reset driver binding =
> +--------------------------------------------------------------------------
> +The Zynq UltraScale+ MPSoC has several different resets.
> +
> +See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
> +about zynqmp resets.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required Properties:
> +- #reset-cells:	Specifies the number of cells needed to encode reset
> +		line, should be 1
> +
> +Reset outputs:
> +	0   :PCIE config reset.
> +	1   :PCIE bridge block level reset (AXI interface).
> +	2   :PCIE control block level,reset.

Presumably, you will have a header for all these? If so, then don't 
define them here.

> +	3   :Display Port block level reset (includes DPDMA).
> +	4   :FPD WDT reset.
> +	5   :AF_FM5 block level reset.
> +	6   :AF_FM4 block level reset.
> +	7   :AF_FM3 block level reset.
> +	8   :AF_FM2 block level reset.
> +	9   :AF_FM1 block level reset.
> +	10  :AF_FM0 block level reset.
> +	11  :GDMA block level reset.
> +	12  :Pixel Processor (GPU_PP1) block level reset.
> +	13  :Pixel Processor (GPU_PP0) block level reset.
> +	14  :GPU block level reset.
> +	15  :GT block level reset.
> +	16  :Sata block level reset.
> +	17  :ACPU3 power on reset.
> +	18  :ACPU2 power on reset.
> +	19  :ACPU1 power on reset.
> +	20  :ACPU0 power on reset.
> +	21  :APU L2 reset.
> +	22  :ACPU3 reset.
> +	23  :ACPU2 reset.
> +	24  :ACPU1 reset.
> +	25  :ACPU0 reset.
> +	26  :DDR block level reset inside of the DDR Sub System.
> +	27  :APM block level reset inside of the DDR Sub System.
> +	28  :soft reset.
> +	29  :GEM 0 reset.
> +	30  :GEM 1 reset.
> +	31  :GEM 2 reset.
> +	32  :GEM 3 reset.
> +	33  :qspi reset.
> +	34  :uart0 reset.
> +	35  :uart1 reset.
> +	36  :spi0 reset.
> +	37  :spi1 reset.
> +	38  :sdio0 reset.
> +	39  :sdio1 reset.
> +	40  :can0 reset.
> +	41  :can1 reset.
> +	42  :i2c0 reset.
> +	43  :i2c1 reset.
> +	44  :ttc0 reset.
> +	45  :ttc1 reset.
> +	46  :ttc2 reset.
> +	47  :ttc3 reset.
> +	48  :swdt reset.
> +	49  :nand reset.
> +	50  :adma reset.
> +	51  :gpio reset.
> +	52  :iou_cc reset.
> +	53  :timestamp reset.
> +	54  :rpu_r50 reset.
> +	55  :rpu r51 reset.
> +	56  :rpu_amba reset.
> +	57  :ocm reset.
> +	58  :rpu_pge reset.
> +	59  :usb0_core reset.
> +	60  :usb1_core reset.
> +	61  :usb0_hiber reset.
> +	62  :usb1_hiber reset.
> +	63  :usb0_apb reset.
> +	64  :usb1_apb reset.
> +	65  :ipi reset.
> +	66  :apm reset.
> +	67  :rtc reset.
> +	68  :sysmon reset.
> +	69  :afi_fm6 reset.
> +	70  :lpd_swdt reset.
> +	71  :fpd_reset.
> +	72  :rpu_dbg1 reset.
> +	73  :rpu_dbg0 reset.
> +	74  :dbg_lpd reset.
> +	75  :dbg_fpd reset.
> +	76  :apll reset.
> +	77  :dpll reset.
> +	78  :vpll reset.
> +	79  :iopll reset.
> +	80  :rpll reset.
> +	81  :gpio_pl_0 reset.
> +	82  :gpio_pl_1 reset.
> +	83  :gpio_pl_2 reset.
> +	84  :gpio_pl_3 reset.
> +	85  :gpio_pl_4 reset.
> +	86  :gpio_pl_5 reset.
> +	87  :gpio_pl_6 reset.
> +	88  :gpio_pl_7 reset.
> +	89  :gpio_pl_8 reset.
> +	90  :gpio_pl_9 reset.
> +	91  :gpio_pl_10 reset.
> +	92  :gpio_pl_11 reset.
> +	93  :gpio_pl_12 reset.
> +	94  :gpio_pl_13 reset.
> +	95  :gpio_pl_14 reset.
> +	96  :gpio_pl_15 reset.
> +	97  :gpio_pl_16 reset.
> +	98  :gpio_pl_17 reset.
> +	99  :gpio_pl_18 reset.
> +	100 :gpio_pl_19 reset.
> +	101 :gpio_pl_20 reset.
> +	102 :gpio_pl_21 reset.
> +	103 :gpio_pl_22 reset.
> +	104 :gpio_pl_23 reset.
> +	105 :gpio_pl_24 reset.
> +	106 :gpio_pl_25 reset.
> +	107 :gpio_pl_26 reset.
> +	108 :gpio_pl_27 reset.
> +	109 :gpio_pl_28 reset.
> +	110 :gpio_pl_29 reset.
> +	111 :gpio_pl_30 reset.
> +	112 :gpio_pl_31 reset.
> +	113 :rpu_ls reset.
> +	114 :ps_only reset.
> +	115 :pl reset.
> +	116 :ps_pl0 reset
> +	117 :ps_pl1 reset
> +	118 :ps_pl2 reset
> +	119 :ps_pl3 reset
> +
> +-------
> +Example
> +-------
> +
> +firmware {
> +	zynqmp_firmware: zynqmp-firmware {
> +		...
> +		#reset-cells = <1>;
> +		...
> +	};
> +};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
