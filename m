Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E67C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:16:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380B520989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QvvmiaRn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWbMTxTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380B520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KrLRLb22HW59L3jJEd2iyX2rsYxRUPRUQr4EMGOZ7n8=; b=QvvmiaRnh0JhPW
	20qBr4XCYdYF22ZMRMcTHiGkv0ZP0wfwK68l9oU7PUeomzVqWgGNLuzK6i/aqLCONs6jlhJ435pIb
	6Zt0bCatAVxPQKm/Xf4l9WC1mQmppWJFru+QOhwZjmleclmJaVbaqsvRRcPjatMKyxxW+zMQ0N4qe
	7tFLpRaDeniwd/g5gaQyAC8ZcgYGitHQ9Grgx2ZMMcGCDjV2VxqCxfYH/T1KWTivIb+e4Fq1dzU83
	JfnZCrzhBphL5/AM4CAQYHWZSssPhmbf3v3HgA37U9j/XwXW7YpBbCWGa2obB1cu5fq275laX9+dP
	dYc/Tp0U0/zm+UfbEfmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy9YS-00044p-Vc; Mon, 25 Feb 2019 06:15:56 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy9YP-000441-ND
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 06:15:55 +0000
Received: by mail-ed1-x543.google.com with SMTP id h58so6544080edb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 22:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V62Uz4EHki/THwMW+97zKf5gjJc9H9jlASqKmiHBVkg=;
 b=MWbMTxTclmA/hcJq2w9uXz4jmf010tHXyINMRP7ukx0HuCFxS6lU2CrER2Yrx1ThvX
 1skBLrB6ta4zxMfvGAFXOPTeccUiPXHT2Z8ER7AMMi3OLePQ7bqRdW0fBtV4r6+IwcKl
 wR6RhB24wXW3trY4B17nhkb4yBD5aSJM7QeHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V62Uz4EHki/THwMW+97zKf5gjJc9H9jlASqKmiHBVkg=;
 b=aFFqndIX8jCJ3ALBGyiV/7KhdLv9n7giL3zdsurkU7YucVcUchFwH4HjK9Mc+a0+qV
 s4nteIZlzmaueDwlVOASFhJr5ufA34h70N0ZyzSC0cKkDa2j4Rhnx7ZWOYBLta7NCaaB
 m28XamRSKC9vjqPcpfsQYdN9gWaxMUNnre05oO+zxN2B6UtFURduw1buRyuz10gy1cL0
 Qn21vcbn7hRvyKGwZeYTk5JLe7DPpsNHYj+m5penOwYGaH0zUyA+3Vio4At5wX8yBAwW
 v3Qw2yXvsla5Fuw+Xkfsfs9ulfZls1IpLkURC6CInmiLhofBiBDE2bvrTcM1NasrZ1AA
 GgLg==
X-Gm-Message-State: AHQUAuaByqSplKHZlg+OjbZFQ8CbUnwTgMhAejfx+5H1s95mS2ktjLIq
 CPn00yb+Xwi+uKgwPKBsTp3Vn7CkHiDqX7PRsdsEHw==
X-Google-Smtp-Source: AHgI3Ia1q9a83hP7aUcZN36LVMzgN7MUNtrPt2RuRyjCrdlDygHJ2nc8vTLwHR9HEOSk76pB2TLPzYBL6tTSIpSO9dw=
X-Received: by 2002:a17:906:561a:: with SMTP id
 f26mr11885639ejq.167.1551075350868; 
 Sun, 24 Feb 2019 22:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20190221084729.101784-1-pihsun@chromium.org>
 <20190221084729.101784-2-pihsun@chromium.org>
 <20190222144316.GA19284@bogus>
In-Reply-To: <20190222144316.GA19284@bogus>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Mon, 25 Feb 2019 14:15:40 +0800
Message-ID: <CANdKZ0d+2CqbVEwruW+pbqUeRMBwzXV7tFC7Cp7i+98CWiB_4w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_221553_783098_71BB4B2D 
X-CRM114-Status: GOOD (  27.50  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 10:43 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 21, 2019 at 04:47:24PM +0800, Pi-Hsun Shih wrote:
> > From: Erin Lo <erin.lo@mediatek.com>
> >
> > Add a DT binding documentation of SCP for the
> > MT8183 SoC from Mediatek.
> >
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> > Changes from v4:
> >  - Add detail of more properties.
> >  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> >
> > Changes from v3:
> >  - No change.
> >
> > Changes from v2:
> >  - No change. I realized that for this patch series, there's no need to
> >    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
> >    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
> >    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
> >    created by SCP name service.
> >
> > Changes from v1:
> >  - No change.
> > ---
> >  .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > new file mode 100644
> > index 00000000000000..8cf8b0e0d98a4c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> > @@ -0,0 +1,37 @@
> > +Mediatek SCP Bindings
> > +----------------------------------------
> > +
> > +This binding provides support for ARM Cortex M4 Co-processor found on some
> > +Mediatek SoCs.
> > +
> > +Required properties:
> > +- compatible         Should be "mediatek,mt8183-scp"
> > +- reg                        Should contain the address ranges for the two memory
> > +                     regions, SRAM and CFG.
> > +- reg-names          Contains the corresponding names for the two memory
> > +                     regions. These should be named "sram" & "cfg".
> > +- clocks             Clock for co-processor (See: ../clock/clock-bindings.txt)
> > +- clock-names                Contains the corresponding name for the clock. This
> > +                     should be named "main".
> > +
> > +Subnodes
> > +--------
> > +
> > +When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg
>
> Bindings can't depend on kernel config options.
>

What's the recommendation here if the subnode only has effect when the
config is enabled? Should I just skip the sentence "When ... is
enabled"?

> > +devices. The names of the devices are not important. The properties of these
> > +nodes are defined by the individual bindings for the rpmsg devices - but must
> > +contain the following property:
> > +
> > +- mtk,rpmsg-name     Contains the name for the rpmsg device. Used to match
> > +                     the subnode to rpmsg device announced by SCP.
>
> I don't think this belongs in DT, but without some examples I'm not
> really sure.
>

This is similar to the qcom,smd-channels property in
Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt, a example DT
for this:

scp {
        compatible = "mediatek,mt8183-scp";
        ...
        cros_ec {
                compatible = "google,cros-ec-rpmsg";
                mtk,rpmsg-name = "cros-ec-rpmsg";

                cros_ec_codec {
                        compatible = "google,cros-ec-codec";
                        ...
                };
        };
};

> > +
> > +Example:
> > +
> > +     scp: scp@10500000 {
> > +             compatible = "mediatek,mt8183-scp";
> > +             reg = <0 0x10500000 0 0x80000>,
> > +                   <0 0x105c0000 0 0x5000>;
> > +             reg-names = "sram", "cfg";
> > +             clocks = <&infracfg CLK_INFRA_SCPSYS>;
> > +             clock-names = "main";
> > +     };
> > --
> > 2.21.0.rc0.258.g878e2cd30e-goog
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
