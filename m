Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB453C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915B52087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1dMVA5r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6M9YLHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915B52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Cui101N0WDlsgnRLM+HqJxjPvWUF3ESQgt2Kasqkjg=; b=p1dMVA5ri2PkVt
	EwZli0jww3+GBpCI/3wV3h7ACywjcwqUROWwjAJPkRlfvvo+hnEye6E2BdxLavQhkh3qbIwcF5dQz
	nplI+++7PaslEqOuFHsx2kSq60CwjD2ADfy60w5QN8DZoxMDiu3IW3QwlDYNTJB+TbZl2Y/M5hvp0
	ZFZclg5akwNO4Clva0zR8JGQco77FnnRu6A5dwj1SX8JL8KWfd2uErJ+hY60I7/i0wQ3AioNhmIIV
	UBv2CZNJ9nVHY1xEXyfrOPK7NSuyQ3+p/XBFvv8V60M9XgI0E7efOBnC2aRImR6xStQzEr7hkMjf4
	DMtSLROGDB6OJrExAPTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goaAW-0000Lq-8D; Tue, 29 Jan 2019 20:39:40 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goa9w-0008J1-T0
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 20:39:10 +0000
Received: by mail-pg1-x543.google.com with SMTP id s198so9265461pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XLB+LA1eAe3kDYs6gI43vB4A4plZV87iVFLZSgZKshY=;
 b=b6M9YLHLm95w2F8xMDJZyQxDaTG93Fr5J96f/gLEhPbW+TjnBVfOcU+thx/npnjai4
 QTelNVPJwh1pjp2fO5ZipEJG27CKoMAzmzanAQ2BBaWYONuk6OUiw/J94jh3alkA4k0p
 NVhhnwHwC1gAA7d/7BaYGsdAay0HQqnWn/umk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XLB+LA1eAe3kDYs6gI43vB4A4plZV87iVFLZSgZKshY=;
 b=KwzA1YXfxBhovo6QQWiD4MM0pVu3fQGPDpCkxfyN9RcJA7uFS2kDkxJurKw7Dj0bXm
 lIKbeY3xqwdrYfZOsPZxPZwdVzhPcMJm49AeUsbdTF+QbXePDsdSBF8VeYx7grLh9pnM
 tOWWkpH5DDmaNPz2P8A5N8Ckg8bd5VpXWx9a3Q20q7z07kM+4AJTFySMO/tR+UvyovZC
 qFmlBCw7wrxNBkeW5gsKgQ/WGbJeVlaIPnn7J18C2uixTCior8QpgE0EsnKeIcEdegfq
 f2Ni41VuLpd1CWS24SFqR7qtm1umMvkDN6qRo2gLHQ1L//LVQuCkIN/3A5zEXeRt6CnC
 t/fQ==
X-Gm-Message-State: AJcUukdVuf6sN98MP1dKzdlo62VWgwCadiEAdW2NTx5c34JoMokvW3p+
 Yd0tyzYmcVz/C9YIOAbj08r1CA==
X-Google-Smtp-Source: ALg8bN6l9RgIGPV500wq7bErcA6nagZmyIup1a/geaPxPdI5AJMf/J1VxFChwL2wcS0Ft1AXmi5tPA==
X-Received: by 2002:a63:134f:: with SMTP id 15mr24853357pgt.19.1548794344136; 
 Tue, 29 Jan 2019 12:39:04 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id g26sm45604376pfh.61.2019.01.29.12.39.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 12:39:03 -0800 (PST)
Date: Tue, 29 Jan 2019 12:38:45 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20190129203845.GB3036@builder>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_123905_331547_4657774E 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 vkoul@kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
 kishon@ti.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:

> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY

SuperSpeed

> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> new file mode 100644
> index 0000000..8ef6e39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> @@ -0,0 +1,73 @@
> +Qualcomm Synopsys 1.0.0 SS phy controller
> +===========================================
> +
> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> +chipsets

It's based on Synopsys IP, but it's Qualcomm's version, and isn't the
1.0.0 Qualcomm's version number for this block?

Also I think it "provides SuperSpeed USB connectivity on some Qualcomm
platforms".

> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-ssphy".
> +
> +- reg:
> +    Value type: <prop-encoded-array>
> +    Definition: USB PHY base address and length of the register map.
> +
> +- #phy-cells:
> +    Value type: <u32>
> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
> +
> +- clocks:
> +    Value type: <prop-encoded-array>
> +    Definition: See clock-bindings.txt section "consumers". List of
> +		 three clock specifiers for reference, phy core and
> +		 pipe clocks.
> +
> +- clock-names:
> +    Value type: <string>
> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> +		 property. Must contain "ref", "phy" and "pipe".
> +
> +- vdd-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator VDD supply node.
> +
> +- vdda1p8-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator 1.8V supply node.
> +
> +
> +Optional child nodes:
> +
> +- vbus-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the VBUS supply node.
> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". PHY reset specifiers
> +		 for phy core and COR resets.
> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy".

Perhaps "Must contain both com and phy, if property is specified", to
clarify that it's all or nothing.


Looks good otherwise.

Regards,
Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
