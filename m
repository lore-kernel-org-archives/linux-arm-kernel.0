Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D013C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:06:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C958320C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NEtxqs7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLm41XR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C958320C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wpY9yPW3NznFLgoA6NTBuVDlrQY1W6k0Y6eMXeTrcis=; b=NEtxqs7DDW4bRn
	1lpja+UTwvxfKDDt4X+zKeOiaWV6A4/BzIF0WPzj2uhq4KoMh+BVHq3R0NAj0tWm5Kw9LAw4E5/1R
	xnR62qRCF9++wO0UiaAkZSfCogf3xzZXzs3otAioSGltgX7Ld9kywNuLdAg4xq8JQr+cxgMmy6n7J
	tyf6lHVT6ajSkjx/bufV2HfZcGTyr1K8lYT1ENIzcBoWQ5LwRH/cfUeVOkdnu/5JsEA9IECeHB/oj
	N67jfT/oLbaahNa9qJLZaO7+1vTujHpdIKhh2KVhNCc61GR8XzmgyYPN8GY63b560wjrrCQWzaNNn
	YzTDgHILgYsBnk6Y2NSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz4XV-0008Cm-H6; Wed, 27 Feb 2019 19:06:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz4XR-0008BQ-4s
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:06:42 +0000
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 69A7A218AE
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 19:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551294398;
 bh=lM1ELI/k8dCbQnwNanFXBTkQJXP+Ff4wQxwg5W07IQg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=gLm41XR6xJ5dD6vH5tYdqxCGmg2nmAYHVfcdscHzl0m1nWY9PIpEzX5zUpSbfUVWk
 xfNF4BHLIqdUIuWRskZAZajmQyynUgb0Gt+I7xX1EvtGg8jgMJ7xe9Jh/el10IEu4D
 ZGA8gV0ijRhQ8FDY3V5ht1j20x0IBkrOrToL2njc=
Received: by mail-oi1-f181.google.com with SMTP id g16so14402356oib.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:06:38 -0800 (PST)
X-Gm-Message-State: AHQUAub5emJ5o7Nfk59lgIn4cc0Dbg4faB4muJykHAKbRC5Tw7FnQhvC
 X0vZUNGa/G2zU1RwHlT31PzyII7azCOguid2SRFXnQ==
X-Google-Smtp-Source: APXvYqx6NF4OKEEiatSs/WbXmDF9IxmniVBRhb4np+k4gLUzDzHBmCErp6GRgvSitsTqtD2NWQ7YvXCJ2hAzUJDmmko=
X-Received: by 2002:aca:c307:: with SMTP id t7mr575243oif.46.1551294397621;
 Wed, 27 Feb 2019 11:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20190201123235.1693-1-jbx6244@gmail.com>
 <20190225165923.GA2578@bogus> <b183d099-dcb3-9c3f-7031-2bd54d7fe5bb@gmail.com>
In-Reply-To: <b183d099-dcb3-9c3f-7031-2bd54d7fe5bb@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Feb 2019 13:06:26 -0600
X-Gmail-Original-Message-ID: <CABGGisyUfENpaHgE3u9ECiMYn-fvC22x3BRKdj2y3eCdgFjKUA@mail.gmail.com>
Message-ID: <CABGGisyUfENpaHgE3u9ECiMYn-fvC22x3BRKdj2y3eCdgFjKUA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: rockchip: add document for rk3066
 hdmi
To: Johan Jonker <jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_110641_225045_B74D1601 
X-CRM114-Status: GOOD (  29.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, airlied@linux.ie,
 Mike Turquette <mturquette@baylibre.com>, hjc@rock-chips.com,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-rockchip@lists.infradead.org,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 12:04 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Thanks for your advice.
>
> On 2/25/19 5:59 PM, Rob Herring wrote:> On Fri, Feb 01, 2019 at
> 01:32:35PM +0100, Johan Jonker wrote:
> >> This patch adds a binding that describes the HDMI controller for
> >> rk3066.
> >
> > This is not using the DW block like other Rockchip SoCs (IIRC)?
>
> As outsider it's a little bit difficult to comment on that.
> Maybe an insider can give a better answer.
> The rk3066 is there early model.
> Reusing blocks like in the later improved models wasn't in the fashion
> yet I think.
> Also comparing the rk3066-hdmi driver to the inno driver gives too many
> differences in registers, sound support and irqs.
> If it was similar they would have combined it in there own kernel.
> Given the age there won't come any other support for it.
> This is what we have...

Okay, if it looks different then good enough for me.

> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>  .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60
> ++++++++++++++++++++++
> >
> > Using the compatible string plus '.txt' is the preferred naming.
>
> Will change that in V2.
> rk3066-hdmi      -> rk3066-hdmi-rockchip.txt
>
> How about the other documents?
> rk3036-inno-hdmi -> inno_hdmi-rockchip.txt
> rk3288-dw-hdmi   -> dw_hdmi-rockchip.txt
> rk3288-dp        -> analogix_dp-rockchip.txt
> etc.

Just leave them for now.

> >>  1 file changed, 60 insertions(+)
> >>  create mode 100644
> Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> >>
> >> diff --git
> a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> >> new file mode 100644
> >> index 000000000..6a8f3754f
> >> --- /dev/null
> >> +++
> b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> >> @@ -0,0 +1,60 @@
> >> +Rockchip specific extensions for rk3066 HDMI
> >> +============================================
> >> +
> >> +Required properties:
> >> +- compatible:
> >> +    "rockchip,rk3066-hdmi";
> >> +- reg:
> >> +    Physical base address and length of the controller's registers.
> >> +- clocks, clock-names:
> >> +    Phandle to HDMI controller clock, name should be "hclk".
> >> +- interrupts:
> >> +    HDMI interrupt number.
> >> +- power-domains:
> >> +    Phandle to the RK3066_PD_VIO power domain.
> >> +- rockchip,grf:
> >> +    This soc uses GRF regs to switch the HDMI TX input between vop0 and
> vop1.
> >> +- ports:
>
> Should "ports" be replaced by: "hdmi_in: port"?
> What is preferred?
>
> There are two different methods in use:
> -1
>                 hdmi_in: port {
>
> -2
>                 ports {
>                         hdmi_in: port {

Generally, you have 'ports' when there is more than one 'port' node
which you should in this case.

> >> +    Contains one port node with two endpoints, numbered 0 and 1,
> >> +    connected respectively to vop0 and vop1.
> >
> > You should have an output port to an hdmi-connector node (or bridge) as
> > well.
>
> Which hdmi-connector node?
> Could you explane with an example?

grep hdmi-connector in the tree there's lot's of examples.

> The Rockchip hdmi nodes I'm aware off only use the port nodes as a way
> to switch the hdmi input between the vop's.
> The vop nodes can have multiple outputs.

Yes, that's the input side. And generally, muxing is represented as
multiple endpoints.

Not all cases of HDMI have defined a connector node as that came along later.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
