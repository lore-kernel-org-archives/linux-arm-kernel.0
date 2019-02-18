Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E755CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:20:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79DE2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hRV5eAfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79DE2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fMBa2WfvG7qg5/hGe7vfXY5Q55qFsV+ZMTBijThLpNc=; b=hRV5eAfK0966cB
	wXPig9QTzNlhqyjTliiacrZathKscuaFKBixKZlIw4duLlx7sUYNP65nDSmKVNfA4TltY5BwdBFXP
	wYCOAd25Y6iBRuHQlpZxLCXNgPeDBB0XCJZcqnK/rKO8HYImIM0nMMw4asTdN34njIgta7eTUNBGH
	IPb9LRYbymOUFUs6jqd0l28PahTZUfpU8Jdr2YR00C/qY8CY3TUERN/452/Jfp7L9BucerREDFq2R
	YxqN3MuYStSOnM/sHGwnbvjI48i/K6/hCvQnL31U/dznbcFF5EeSlGfOWYOGy+UwyAplm7oDYqXCx
	fYfTE9eqyY2m94xwRiNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gviqN-0004a8-Hk; Mon, 18 Feb 2019 13:20:23 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviqJ-0004Zp-Tc
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 13:20:21 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1IDHAHG025384; Mon, 18 Feb 2019 14:20:04 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2qpc6x2khq-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Mon, 18 Feb 2019 14:20:04 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C049231;
 Mon, 18 Feb 2019 13:20:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4CD7B2B38;
 Mon, 18 Feb 2019 13:20:02 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.48) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Feb
 2019 14:20:01 +0100
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add STM32 factory-programmed romem
To: <robh+dt@kernel.org>
References: <1548866336-14765-1-git-send-email-fabrice.gasnier@st.com>
 <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <c733fe5d-0686-8596-6dc1-369969c782ed@st.com>
Date: Mon, 18 Feb 2019 14:20:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548866336-14765-2-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-18_10:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_052020_254240_3F1F9BC0 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: mark.rutland@arm.com, lionel.debieve@st.com, alexandre.torgue@st.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, mcoquelin.stm32@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 5:38 PM, Fabrice Gasnier wrote:
> Add documentation for STMicroelectronics STM32 Factory-programmed
> read only memory area.

Hello Rob, DT Maintainers,

Gentlemen reminder for new DT bindings review.

Best Regards,
Fabrice
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> new file mode 100644
> index 0000000..fbff52e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
> @@ -0,0 +1,31 @@
> +STMicroelectronics STM32 Factory-programmed data device tree bindings
> +
> +This represents STM32 Factory-programmed read only non-volatile area: locked
> +flash, OTP, read-only HW regs... This contains various information such as:
> +analog calibration data for temperature sensor (e.g. TS_CAL1, TS_CAL2),
> +internal vref (VREFIN_CAL), unique device ID...
> +
> +Required properties:
> +- compatible:		Should be one of:
> +			"st,stm32-romem"
> +			"st,stm32mp15-bsec"
> +- reg:			Offset and length of factory-programmed area.
> +- #address-cells:	Should be '<1>'.
> +- #size-cells:		Should be '<1>'.
> +
> +Optional Data cells:
> +- Must be child nodes as described in nvmem.txt.
> +
> +Example on stm32f4:
> +	romem: nvmem@1fff7800 {
> +		compatible = "st,stm32-romem";
> +		reg = <0x1fff7800 0x400>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		/* Data cells: ts_cal1 at 0x1fff7a2c */
> +		ts_cal1: calib@22c {
> +			reg = <0x22c 0x2>;
> +		};
> +		...
> +	};
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
