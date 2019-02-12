Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E25C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:47:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C294222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JZJB4P0G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM+PUZNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C294222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bpnr0wb/80D5a1iVcRwd/Qt2fmvMAY9Pb+KBbIhFPIw=; b=JZJB4P0Gg/4/Jr
	67mlv2FpXahSbJvgRQ2M2n3VI9EKXF0eGWKN+oIo9552XpJd7JdkzWvcM4mMVux8AZ1QtvE/pdy6y
	9lFdkclfkWekOL1PeRnE6SnYLo/HpEtnBIQf25pWH1+tpD+pTfvjo6htxVv6dSR10vvBpcgAqJqiv
	osUhYKRkQz6wB21nNa7cFIeEn/62pfXogaHahlBxT8mZThQupMVdfBgtaT9h0vC2fmOFFlMmGLGto
	VNsyUXrE0x5sdRMEJtF8IPyc+rJxIdUWja5BFV/jpqPbrnu3ZyRvHacMjqv4Vz/IXbCfE3ghkaYpP
	0Rfm7khFD2NE59Eu9Pew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtexs-000162-VP; Tue, 12 Feb 2019 20:47:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtexo-00015W-Fn
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:47:34 +0000
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E94B222C7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550004452;
 bh=dG3SYe1pky2pZMnt/9eiwxUcZ72JgJN0XyaOEoZJn3w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FM+PUZNK3D89uRZ6qfG335Uq5hmBsBhvekSeSKmu1XIgN++9c4jwSIJW6YrKr4NPL
 LtDj24vbtJ1A1M2pyhqZdin8igeDdXL28v5/NJKHXsGqUDecFAdTmqGMfvRR/flUZk
 VYAiR/qwIQagZHx2bfzfJpIBoS5jDU+QcSC06D2U=
Received: by mail-qk1-f172.google.com with SMTP id y195so16864qka.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 12:47:32 -0800 (PST)
X-Gm-Message-State: AHQUAub6zofdWAKeNg9FWBXh8znWEOzm/149hlqL8lPV/qOqVr+cxLOM
 d9UfhNFiBqBRo3ICmFXArF2Ct+rsChLHBCvd7Q==
X-Google-Smtp-Source: AHgI3IblU/uhnwzaW4iMyxiQLo6YZeD4EDKEJn6whYdWRAEpevbjO/8tQgQXZlTuw77NdG7YUMVYNz0Rbqgu9os8s2I=
X-Received: by 2002:a37:b646:: with SMTP id g67mr4109588qkf.326.1550004451191; 
 Tue, 12 Feb 2019 12:47:31 -0800 (PST)
MIME-Version: 1.0
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190130200218.GB5908@bogus>
 <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
 <63959c4f-211e-bc2e-12a4-c4ef61c818a9@linaro.org>
In-Reply-To: <63959c4f-211e-bc2e-12a4-c4ef61c818a9@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 14:47:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3Ttr8wGsDkx0q0VJRVWx2Zt41xY=NUB8GCJ1LjLk_tw@mail.gmail.com>
Message-ID: <CAL_Jsq+3Ttr8wGsDkx0q0VJRVWx2Zt41xY=NUB8GCJ1LjLk_tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_124732_557331_ADFADDDA 
X-CRM114-Status: GOOD (  21.92  )
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
 jackp@codeaurora.org, Shawn Guo <shawn.guo@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Vinod <vkoul@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 8:11 AM Jorge Ramirez
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> On 2/5/19 12:02, Jorge Ramirez wrote:
> > On 1/30/19 21:02, Rob Herring wrote:
> >> On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
> >>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> >>> controller embedded in QCS404.
> >>>
> >>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> >>> definitions.
> >>>
> >>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> >>> ---
> >>>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
> >>>  1 file changed, 73 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> >>> new file mode 100644
> >>> index 0000000..8ef6e39
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> >>> @@ -0,0 +1,73 @@
> >>> +Qualcomm Synopsys 1.0.0 SS phy controller
> >>> +===========================================
> >>> +
> >>> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> >>> +chipsets
> >>> +
> >>> +Required properties:
> >>> +
> >>> +- compatible:
> >>> +    Value type: <string>
> >>> +    Definition: Should contain "qcom,usb-ssphy".
> >>
> >> This is in no way specific enough.
> >
> > ok. will remove the old unused bindings and reuse qcom,dwc3-ss-usb-phy
> >
> >>
> >>> +
> >>> +- reg:
> >>> +    Value type: <prop-encoded-array>
> >>> +    Definition: USB PHY base address and length of the register map.
> >>> +
> >>> +- #phy-cells:
> >>> +    Value type: <u32>
> >>> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
> >>> +
> >>> +- clocks:
> >>> +    Value type: <prop-encoded-array>
> >>> +    Definition: See clock-bindings.txt section "consumers". List of
> >>> +            three clock specifiers for reference, phy core and
> >>> +            pipe clocks.
> >>> +
> >>> +- clock-names:
> >>> +    Value type: <string>
> >>> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> >>> +            property. Must contain "ref", "phy" and "pipe".
> >>> +
> >>> +- vdd-supply:
> >>> +    Value type: <phandle>
> >>> +    Definition: phandle to the regulator VDD supply node.
> >>> +
> >>> +- vdda1p8-supply:
> >>> +    Value type: <phandle>
> >>> +    Definition: phandle to the regulator 1.8V supply node.
> >>> +
> >>> +
> >>> +Optional child nodes:
> >>> +
> >>> +- vbus-supply:
> >>> +    Value type: <phandle>
> >>> +    Definition: phandle to the VBUS supply node.
> >>
> >> Does the phy actually get supplied by Vbus? If not, then Vbus supply
> >> should be defined in a USB connector node.
> >
> > yes per the documentation vbus can optionally be routed to the phy to
> > drive a signal to the controller.
>
>
> funny enough when vbus is optionally routed to the phy is not to be
> controlled like we do when the vbus-supply property is present.
>
> So to all effects no, you are right, the phy does not get supplied by VBUS.
>
> would defining the connector like this be enough?
>
> usb3_phy: usb3-phy@78000 {
>         compatible = "qcom,snps-usb-ssphy";
>         [...]
>         usb3_c_connector: usb3-c-connector {
>                 compatible = "usb-c-connector";
>                 label = "USB-C";
>                 type = "micro";
>                 vbus-supply = <&usb3_vbus_reg>;
>         };
> };

IIRC, the connector node is defined to go under either the USB
controller or a USB-C controller (if a separate chip controlling the
USB-PD and alternate modes). We generally don't put PHYs into a node
topology, but keep them as a phandle reference.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
