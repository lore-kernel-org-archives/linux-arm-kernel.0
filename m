Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29515C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E6720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NmAXYGan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E6720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RRGuG15VTSMYMHyj6pv9lc54cFDXNROvk1HS1msnS98=; b=NmA
	XYGanTHnRVN30sNSBWjdltmbxGDTr4/EoL6AA9YUfeXVAZIn7T5HlmXQYx9Fwro0UVDCfxNPtdESn
	FuOU2Y5M+BYg2oQ9KEtV00VhCDfif4Pmm+zDbRzHKHuszB7nXHWHKq65AzQis8Xe7bDK38XcArcCm
	UjwXhkRrreMvTNBdh9V4hEu8D0475a2+TOTP6orlZ30RjqHJvI1aBdAWsJFnWA9d43tAsMhTeZ48A
	Z1vv/v3z+O16ounl2ky/mP5WocKqjOTZMm/5ij3qVeUdaCG+zziAJLrwJlLMNRf/1V/oKST26q+Cq
	9O6stkknDjbTK5FKkcru0ZjHQ5SqcrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWd34-0003Vt-Jw; Tue, 11 Dec 2018 08:05:46 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWd2s-0003Kt-CQ; Tue, 11 Dec 2018 08:05:36 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43DXYW0kmlz1r2RT;
 Tue, 11 Dec 2018 09:05:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43DXYV3gQJz1qrnH;
 Tue, 11 Dec 2018 09:05:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id tDFbJxOgN1JA; Tue, 11 Dec 2018 09:05:16 +0100 (CET)
X-Auth-Info: m4Vdig746e9hPkTThlBiw/MmVd7ai+5M3GBXVgsboPo=
Received: from xpert.denx.de (unknown [62.91.23.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Tue, 11 Dec 2018 09:05:16 +0100 (CET)
From: Parthiban Nallathambi <pn@denx.de>
To: manivannan.sadhasivam@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
 mark.rutland@arm.com, wsa@the-dreams.de
Subject: [PATCH v3 0/4] Add Actions Semi Owl family S700 I2C support
Date: Tue, 11 Dec 2018 09:04:44 +0100
Message-Id: <20181211080448.24007-1-pn@denx.de>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000534_577972_48737250 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: devicetree@vger.kernel.org, linux@cubietech.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, linux-i2c@vger.kernel.org,
 Parthiban Nallathambi <pn@denx.de>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for Actions Semi Owl SoC family S700
I2C controller. S700 provides 4 I2C masters and with cubieboard7
2 (I2C0 and I2C1) are exposed.

Added pinctrl definition for I2C controllers in cubieboard7. This patch
depends on s700 pinctrl driver support (yet to be merged),
https://lkml.org/lkml/2018/11/19/514
https://lore.kernel.org/patchwork/patch/1012859/

Changelog in v3:
- re-ordering I2C and pinctrl nodes alphabetically in board DTS
- re-orderng of patch
- Typo and nitpick corrections 

Changelog in v2:
- Initial version https://lore.kernel.org/patchwork/patch/1011911/ only
added the I2C nodes using s900 compatible property. Now, new s700
compatiable string is added and used for S700
- Device tree bindings added with s700 compatible string
- pinctrl definition for cubieboard7

Parthiban Nallathambi (4):
  dt-bindings: i2c: Add S700 support for Actions Semi Soc's
  arm64: dts: actions: s700: Add I2C controller nodes
  i2c: Add Actions Semiconductor Owl family S700 I2C support
  arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1

 .../devicetree/bindings/i2c/i2c-owl.txt       |  4 +-
 .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi         | 40 ++++++++++++++
 drivers/i2c/busses/i2c-owl.c                  |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
