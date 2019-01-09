Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470DF214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnVwh6IT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZsCxC04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470DF214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0K4J6IVVISYbkKznyEw9Xt1ZaIzrHwPpjDod1PwWJR0=; b=KnVwh6ITRNh42J
	0okkg3yCOeEKrePRlBEtbBZoj3nw9GKIe+hzNKCj5xMTAEwOV3mWvte6LtZ32d1cCjdCOM5UbrExA
	5fytR4uSyOMaeT9CS01I8MTsX0hSK+4SdbJnkzn207lJcGGS31vxtVsg2Km3KyJ8Wxe4SsUmYiAj8
	9ZCyVeLKl7LN9jWS6NJ5wpjVN8tRg32iVpu+iajsrn0vUCOCvGdXEuCaKG7eteiwcFCvg+r75Q+M+
	ob6JprbSSb4dKX05/b6lOji4i54Fnf66FhKuU15g1nT88uxvR/9sHMLuWw1b9NgycpqAq/FUWr1Ij
	0rM0QAp1PmjKLEUyx6wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh6Ic-0001HN-HT; Wed, 09 Jan 2019 05:21:06 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh6IZ-0001Gm-9j
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 05:21:05 +0000
Received: by mail-ua1-x941.google.com with SMTP id p9so2034404uaa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 21:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qdnoxA8NeBMLfxXE36TSRorZeN2Pl8DJrYZ14O5V0Ck=;
 b=JZsCxC047uOYJfnNG2QfJp3bFFDEsqOBoAYFAThbDsTKPvtIy7zDNaUHkjmkvr8oXZ
 5rOUYzOlrNNVXbDFjV0AaXGGiaNEVCq7tuYw6Fac+PJtojdRCGPMn0vx42+4AZlXlDux
 ltNI/gerFQIYLdSH1R1fpuMQ3ySRG2b2Gp5hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qdnoxA8NeBMLfxXE36TSRorZeN2Pl8DJrYZ14O5V0Ck=;
 b=UIa3/jwsBihX45aizvIObiH7QPBFF2LI7k8RpoqUB6BngXoP5S4aB7hJCK5m32pGsS
 i+2gRDORAwaYXdDfUPezqvN8R/vZccge+tJQr5mcc+Okxn6C5Jgs82wYIpWWa+J1zDNi
 nwYIhaWE6SWxOvPGY6ywV7DZrS2rX7y94fRhmK2P/o5oRQ3mOku8agLoskGcpm/H6tgc
 ih/jTu2cRIsBnaQkdz7ukLmvBeA8ZSe+5aq7RCUKJj21YbgOHVWuLP9RFgunhWD6+xxO
 9W7LwAbFfMau2rCNYtqBeQM3YB/iUVceu4oNc5F9/oCY35m+iaTKpaRc1Xearqi/bOtI
 DYDw==
X-Gm-Message-State: AJcUukdXSRuRRAso58LXJUP4HhxSn6mLvNs6k53sq4JGlqJxWpAkXLrF
 p6bjBva9HbcYC7HG1Lu3a/V+GArb6oI=
X-Google-Smtp-Source: ALg8bN5KwDEh8s52v6UrIowVVN2LqWEnnLqDD5osnM4Wv9+7C7SSZyKaISxwdt58DBDikj4/FGt0og==
X-Received: by 2002:ab0:550b:: with SMTP id t11mr1742467uaa.31.1547011259471; 
 Tue, 08 Jan 2019 21:20:59 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com.
 [209.85.217.49])
 by smtp.gmail.com with ESMTPSA id j95sm37014585uad.6.2019.01.08.21.20.58
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 21:20:58 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id z3so4000185vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 21:20:58 -0800 (PST)
X-Received: by 2002:a67:f598:: with SMTP id i24mr1887279vso.87.1547011257937; 
 Tue, 08 Jan 2019 21:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-7-jcrouse@codeaurora.org>
 <CAD=FV=VRv82aHfd1dQ_8mjtFFu-u_=JxNGz1qYG+5apTsmBz2Q@mail.gmail.com>
In-Reply-To: <CAD=FV=VRv82aHfd1dQ_8mjtFFu-u_=JxNGz1qYG+5apTsmBz2Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 8 Jan 2019 21:20:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WZkOV95Ka2MVtHtUAYLjzKAZwwe=H87LJCefbm06ogeg@mail.gmail.com>
Message-ID: <CAD=FV=WZkOV95Ka2MVtHtUAYLjzKAZwwe=H87LJCefbm06ogeg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_212103_369794_3360C268 
X-CRM114-Status: GOOD (  21.23  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Dec 18, 2018 at 2:57 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Dec 18, 2018 at 10:33 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Add the nodes to describe the Adreno GPU and GMU devices.
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> > v7: Updated the GMU compatible string and removed interrupt-names
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 122 +++++++++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 233a5898ebc2..4779014e4a05 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -11,6 +11,7 @@
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> > +#include <dt-bindings/power/qcom-rpmpd.h>
> >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > @@ -1349,6 +1350,127 @@
> >                         };
> >                 };
> >
> > +
> > +               gpu@5000000 {
>
> Repeating my comments from v6:
>
> nit that you're adding an extra blank line here that you don't need.
> Given the quantity of outstanding dts patches though, it's almost
> certain that Andy will need to manually resolve conflicts when
> applying this patch so presumably he can fix up when he lands.
>
> In any case, feel free to add:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
>
> > +                       compatible = "qcom,adreno-630.2", "qcom,adreno";
> > +                       #stream-id-cells = <16>;
> > +
> > +                       reg = <0x5000000 0x40000>, <0x509e000 0x10>;
> > +                       reg-names = "kgsl_3d0_reg_memory", "cx_mem";
> > +
> > +                       /*
> > +                        * Look ma, no clocks! The GPU clocks and power are
> > +                        * controlled entirely by the GMU
> > +                        */
> > +
> > +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                       iommus = <&adreno_smmu 0>;
> > +
> > +                       operating-points-v2 = <&gpu_opp_table>;
> > +
> > +                       qcom,gmu = <&gmu>;
> > +
> > +                       gpu_opp_table: opp-table {
> > +                               compatible = "operating-points-v2-qcom-level";
>
> I believe that the consensus from the v2 comments at
> <https://patchwork.kernel.org/patch/10727121/> are that this should
> be:
>
> compatible = "operating-points-v2-qcom-level", "operating-points-v2";
>
> ...same with the other one below...

OK, so I read and re-read all the discussions about this that have
happened since my last email and also had an offline chat with Stephen
and I believe the decision is _not_ to do the "operating-points-v2"
fallback even if your table happens to have "opp-hz" in it.  So
presumably that's resolved.  One reason this works OK for us is that
we have the "operating-points" as a sub-node of the GPU and thus don't
have to worry about the messing with the skip table to prevent a
device from being created (as discussed in the comments of v6) [1]

...but in the meantime Rajendra has had to change his bindings, so you
still need to spin this to account for Rajendra's v9 bindings [2].
Specifically you need to make changes like:

-                               compatible = "operating-points-v2-qcom-level";
+                               compatible = "operating-points-v2-level";

...and:

-                                       qcom,level =
<RPMH_REGULATOR_LEVEL_TURBO_L1>;
+                                       opp-level =
<RPMH_REGULATOR_LEVEL_TURBO_L1>;

...when you spin for this, please make sure you account for the nit
(blank line) I commented about above.

-Doug

[1] https://lore.kernel.org/linux-arm-kernel/7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org/
[2] https://lkml.kernel.org/r/20190107100959.14528-2-rnayak@codeaurora.org

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
