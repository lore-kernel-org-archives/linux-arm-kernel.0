Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF78BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:08:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A7920881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jESAWx/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A7920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NeRCKe8Vss4GflAbDVYRYqm4Wy1xes2naC6cgHwMGQY=; b=jESAWx/v2+37jV
	aS5PY8O5b8GX8O5uP+CzjBUrRDoZXgmOWbB2LQzbqei1TQ4yKn100dDOuaGVNODDWY6MPm5w0iNDM
	zfilPz6JdELA3flLyjcvPwfZAc3jjA5dC2V0dVE+/XUhE/yFnC6ZvAj0OiiJR6W3Tk0TbCmFovObr
	+mbxx5vjN8AZwKyvt0a45PSQKxlOIww38P32GjljYgcrtqMExGGI96qy89ycsYVUFtwxM0SeLqJ1J
	p9nspVldNATbHC2VCNpz2tZLr3vabQkVJ6HT0I7Q3gT3kwclgoOF0X3Q6cPsGPvSToyX1CTcXSdhe
	UdmvTTTVYz+iowghDwvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSBk-0005es-H5; Tue, 29 Jan 2019 12:08:24 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSBg-0005e6-E6; Tue, 29 Jan 2019 12:08:21 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id F3C85272182
Message-ID: <e80f7cea65a51a2746aaef2c4efb1c1a474fbc1e.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: rock960: Enable HDMI audio devices
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 29 Jan 2019 09:08:11 -0300
In-Reply-To: <20190129114031.GA17014@Mani-XPS-13-9360>
References: <20190129113324.29440-1-ezequiel@collabora.com>
 <20190129114031.GA17014@Mani-XPS-13-9360>
Organization: Collabora
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_040820_611512_BF49A648 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-29 at 17:10 +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 29, 2019 at 08:33:24AM -0300, Ezequiel Garcia wrote:
> > This commit enable the hdmi-sound and i2s2 devices needed
> > to have audio over HDMI.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> 
> Since this patch affects both Rock960 and Ficus, it should be mentioned
> in the description. Other than that,
> 

Wish with named this Ficus board as just Rock960 EE, so it'd be obvious
that it's part of the Rock960 family.

> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Thanks!

> Thanks,
> Mani
> 
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > index f04a31d48ba4..1bbf0b1f9374 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > @@ -94,6 +94,10 @@
> >  	status = "okay";
> >  };
> >  
> > +&hdmi_sound {
> > +	status = "okay";
> > +};
> > +
> >  &i2c0 {
> >  	clock-frequency = <400000>;
> >  	i2c-scl-rising-time-ns = <168>;
> > @@ -336,6 +340,10 @@
> >  	status = "okay";
> >  };
> >  
> > +&i2s2 {
> > +        status = "okay";
> > +};
> > +
> >  &io_domains {
> >  	bt656-supply = <&vcc1v8_s0>; /* bt656_gpio2ab_ms */
> >  	audio-supply = <&vcc1v8_s0>; /* audio_gpio3d4a_ms */
> > -- 
> > 2.20.1
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
