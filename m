Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C53EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:49:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF8321019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zihe+GPo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3VEAA7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF8321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:From:Subject:References
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g0c9dhI5W2qDpgcipFdmBbI2+KdAbOyvFOzzptnpE84=; b=Zihe+GPoUVTQoG
	hpMGxnRNFg2Acw/d4t8IAxLdfP0izF5iANtefUX5StMF00A8cAlV3rwG1ZPDe/qprYZSUQIVRZJYP
	rInqV9kKGiA7UbkPvnevUMijvV1cmmURYKgFBjF1VUAh9az/E/drS41znyq0iECxJzjlHeatV3mHk
	ZcsPs4ZXm2I0ByLkJzSRyYBCxND6KeH85j+eqgbT/YQP7cXRrkl4gcUf/uFRncU0JzyE64hIN1fVM
	rhOrxCc3/TAVBeKpjfgbTD4sHl8nQ/cvadhdDfxL7snmQFBkbZ9msTsy5LAV+Sxftz8ocgJUfx8dv
	lG4OElx80dl6zK0WalrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm16g-0007m7-8U; Tue, 22 Jan 2019 18:49:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm16c-0007lQ-UX
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:49:04 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C5612085A;
 Tue, 22 Jan 2019 18:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548182942;
 bh=Jtz9B9hz7hchiClRws1OJLmBy0wplegWUTIbVzgbzfM=;
 h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
 b=k3VEAA7MKecXNmzRi9N9O7EVBPACAYOSjCV+QNWYVqFXgLc9CMnXHb6ssxeJjXcxP
 kc6wYjifJszRGEAXJYyKvVUEGYnFAdRdHt2FnWoTJyl8ykU3tiN5c6fcjxlT5fAgWy
 D+i+3odrva8D5Qrx6aiK62pGZx6CFNbTo/5gM9eg=
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20190117063804.GJ25498@builder>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154507555157.19322.2712807405425817338@swboyd.mtv.corp.google.com>
 <20190117063804.GJ25498@builder>
Subject: Re: [PATCH 10/13] arm64: dts: qcom: qcs404: Add HFPLL node
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818294180.20280.13967884067917226851@swboyd.mtv.corp.google.com>
Date: Tue, 22 Jan 2019 10:49:01 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_104903_003656_67E0C785 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, heiko@sntech.de,
 mturquette@baylibre.com, will.deacon@arm.com, david.brown@linaro.org,
 linux-clk@vger.kernel.org, olof@lixom.net, jagan@amarulasolutions.com,
 andy.gross@linaro.org, sibis@codeaurora.org, devicetree@vger.kernel.org,
 arnd@arndb.de, niklas.cassel@linaro.org, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, jorge.ramirez-ortiz@linaro.org,
 georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Bjorn Andersson (2019-01-16 22:38:04)
> On Mon 17 Dec 11:39 PST 2018, Stephen Boyd wrote:
> 
> > Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:27)
> > > The high frequency pll functionality is required to enable CPU
> > > frequency scaling operation.
> > > 
> > > Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > index 4594fea7..ec3f6c7 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > > @@ -375,6 +375,15 @@
> > >                         #mbox-cells = <1>;
> > >                 };
> > >  
> > > +               apcs_hfpll: clock-controller@0b016000 {
> > 
> > Drop leading 0 on unit address please.
> > 
> > > +                       compatible = "qcom,hfpll";
> > > +                       reg = <0x0b016000 0x30>;
> > 
> > Wow that is small!
> > 
> 
> I double checked and it's actually 0x34, but the last register is
> protected.
> 

Ok, so then it should be 0x34? I don't think we've left out protected
registers from the size before.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
