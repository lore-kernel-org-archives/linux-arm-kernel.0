Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B41C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA05E218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="coDIfRCT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NRxBWjZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA05E218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h+LGzM1YWcA1xu8OD69R4BT/wV/2cUJku4biNLULOso=; b=coDIfRCTjioLgl
	OIXDZPJGWl0Ro98H0AGWOrlhK+L9tKCxNxLM/AhteSFn+gRGOv4QbJUNVLm88mtpS0ivJ1sKJYdQK
	GdkhrvpaiE+h0CjHtnLOEPeje3vruhKyPBMTieynIdk9ZQmuUTRD7XtdOxAT3Myzz0a/hWdT+yxG7
	pwyeuXj3rV31L0VSoALZ5e0hBm4dac503uSJ/lenNdPvN+g6QW/IfEPdejh2V3cddskDNisZAO+x8
	2cCV8mPivKQfw/+wl4AFyxd0N3lzuEiwkFG2Efj8JHXMyrYd3ki7TH5ppQXfAjIQ10/qYN2u4aQlB
	CrmlZPr9naTM8aAZnOjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gym9J-0004Rj-5U; Tue, 26 Feb 2019 23:28:33 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gym9F-0004Qy-Az
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:28:31 +0000
Received: by mail-pl1-x644.google.com with SMTP id v11so1574303plg.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IbZV9S4wZ1HxFTbys16uZNUt6pTk6EVk+H8ofv4j4dA=;
 b=NRxBWjZPTu290aGn6Nlh6ugxbVVcKOmfoBak65wBBFF8fb/4UV5IIq0YQoRk+9TQOf
 OERM7KbXT+5aaVKs0tGmb768tNZRz0HXgrrPNlmTcjk3ZDTw4b84Rn55gkWJMd2T5Jj9
 sYVh6mjXDbdHZGCOgUbMIc/ngaOo5mRz7kclg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IbZV9S4wZ1HxFTbys16uZNUt6pTk6EVk+H8ofv4j4dA=;
 b=QoKJDGoCLmNgxscQ8HSvCmGipE8bMJZfDpTOyp8JIYfgsHpwvvrSJAIHnrwa+ngRUI
 MHE0Bvm75DGNDJHrt0BV+M/3TSYX3PlcmA/lGTk1g8dRRadNDJsbc7LOJss2ivMrGNfR
 mUkhx4AG/ljNK2/IR4BT0Ev8gzl+RO5PmYYO1vteNFHLB3tUiwFUjjxLwnKVmSrVLjiB
 7YRa6gbeuhCeLsKeSZDg7jRNm2KY4AyLzqJRApDczrVUTZqzZx1CWNigzeXxhywwjQTa
 sR6gAmOZpm016KP+gSytmmWQId7FxvB48tIU1DbtgM957+jKOT8x7e0Il7im9sJRMYLp
 C6UA==
X-Gm-Message-State: AHQUAuYy+1IBivgpIPls+2MYjEkNIVqROc7q+cQpS8FvVdKXQvkZdHpL
 yKBNadyQyYUZ9g8a5LMPnrsBcEGPSZA=
X-Google-Smtp-Source: AHgI3IaWDEehnBG8/uYRmmOdYRTU0/y7pu302/gRQZB19FWfvaxxRkhz3DpqilX0R27zax+jIsR8XQ==
X-Received: by 2002:a17:902:505:: with SMTP id 5mr6811546plf.337.1551223707313; 
 Tue, 26 Feb 2019 15:28:27 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id j68sm28306548pfc.64.2019.02.26.15.28.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 15:28:25 -0800 (PST)
Date: Tue, 26 Feb 2019 15:28:23 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Message-ID: <20190226232822.GA174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190224140426.3267-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_152829_373870_49C6187A 
X-CRM114-Status: GOOD (  30.59  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
 Xinming Hu <huxinming820@gmail.com>, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amitkumar Karwar <amitkarwar@gmail.com>,
 linux-rockchip@lists.infradead.org, Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-arm-kernel@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>,
 Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

+ others

Hi Marc,

Thanks for the series. I have a few bits of history to add to this, and
some comments.

On Sun, Feb 24, 2019 at 02:04:22PM +0000, Marc Zyngier wrote:
> For quite some time, I wondered why the PCI mwifiex device built in my
> Chromebook was unable to use the good old legacy interrupts. But as MSIs
> were working fine, I never really bothered investigating. I finally had a
> look, and the result isn't very pretty.
> 
> On this machine (rk3399-based kevin), the wake-up interrupt is described as
> such:
> 
> &pci_rootport {
> 	mvl_wifi: wifi@0,0 {
> 		compatible = "pci1b4b,2b42";
> 		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> 		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> 		interrupt-parent = <&gpio0>;
> 		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&wlan_host_wake_l>;
> 		wakeup-source;
> 	};
> };
> 
> Note how the interrupt is part of the properties directly attached to the
> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> altogether (Yay for the broken design!). This is in total violation of the
> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> specifiers describe the PCI device interrupts, and must obey the
> INT-{A,B,C,D} mapping. Oops!

You're not the first person to notice this. All the motivations are not
necessarily painted clearly in their cover letter, but here are some
previous attempts at solving this problem:

[RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/

As you can see by the 12th iteration, it wasn't left unsolved for lack
of trying...

Frankly, if a proper DT replacement to the admittedly bad binding isn't
agreed upon quickly, I'd be very happy to just have WAKE# support
removed from the DTS for now, and the existing mwifiex binding should
just be removed. (Wake-on-WiFi was never properly vetted on these
platforms anyway.) It mostly serves to just cause problems like you've
noticed.

> The net effect of the above is that Linux tries to do something vaguely
> sensible, and uses the same interrupt for both the wake-up widget and the
> PCI device. This doesn't work for two reasons: (1) the wake-up widget grabs
> the interrupt in exclusive mode, and (2) the PCI interrupt is still routed
> to the RC, leading to a screaming interrupt. This simply cannot work.
> 
> To sort out this mess, we need to lift the confusion between the two
> interrupts. This is done by extending the DT binding to allow the wake-up
> interrupt to be described in a 'wake-up' subnode, sidestepping the issue
> completely. On my Chromebook, it now looks like this:
> 
> &pci_rootport {
> 	mvl_wifi: wifi@0,0 {
> 		compatible = "pci1b4b,2b42";
> 		reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> 		       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&wlan_host_wake_l>;
> 		wake-up {
> 			interrupt-parent = <&gpio0>;
> 			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> 			wakeup-source;
> 		};
> 	};
> };

One problem Rockchip authors were also trying to resolve here is that
PCIe WAKE# handling should not really be something the PCI device driver
has to handle directly. Despite your complaints about not using in-band
TLP wakeup, a separate WAKE# pin is in fact a documented part of the
PCIe standard, and it so happens that the Rockchip RC does not support
handling TLPs in S3, if you want to have decent power consumption. (Your
"bad hardware" complaints could justifiably fall here, I suppose.)

Additionally, I've had pushback from PCI driver authors/maintainers on
adding more special handling for this sort of interrupt property (not
the binding specifically, but just the concept of handling WAKE# in the
driver), as they claim this should be handled by the system firmware,
when they set the appropriate wakeup flags, which filter down to
__pci_enable_wake() -> platform_pci_set_wakeup(). That's how x86 systems
do it (note: I know for a fact that many have a very similar
architecture -- WAKE# is not routed to the RC, because, why does it need
to? and they *don't* use TLP wakeup either -- they just hide it in
firmware better), and it Just Works.

So, we basically concluded that we should standardize on a way to
describe WAKE# interrupts such that PCI drivers don't have to deal with
it at all, and the PCI core can do it for us. 12 revisions later
and...we still never agreed on a good device tree binding for this.

IOW, maybe your wake-up sub-node is the best way to side-step the
problems of conflicting with the OF PCI spec. But I'd still really like
to avoid parsing it in mwifiex, if at all possible.

(We'd still be left with the marvell,wakeup-pin propery to parse
specifically in mwifiex, which sadly has to exist because....well,
Samsung decided to do chip-on-board, and then they failed to use the
correct pin on Marvell's side when wiring up WAKE#. Sigh.)

> The driver is then updated to look for this subnode first, and fallback to
> the original, broken behaviour (spitting out a warning in the offending
> configuration).
> 
> For good measure, there are two additional patches:
> 
> - The wake-up interrupt requesting is horribly racy, and could lead to
>   unpredictable behaviours. Let's fix that properly.

Ack. That mistake was repeated in other drivers and has since been fixed
in those. We need it here too.

Brian

> - A final patch implementing the above transformation for the whole
>   RK3399-based Chromebook range, which all use the same broken
>   configuration.
> 
> With all that, I finally have PCI legacy interrupts working with the mwifiex
> driver on my Chromebook.
> 
> [1] http://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> 
> Marc Zyngier (4):
>   dt-bindings/marvell-8xxx: Allow wake-up interrupt to be placed in a
>     separate node
>   mwifiex: Fetch wake-up interrupt from 'wake-up' subnode when it exists
>   mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN rather than disabling
>     it too late
>   arm64: dts: rockchip: gru: Move wifi wake-up interrupt into its own
>     subnode
> 
>  .../bindings/net/wireless/marvell-8xxx.txt    | 23 ++++++++++++++++++-
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  8 ++++---
>  drivers/net/wireless/marvell/mwifiex/main.c   | 13 +++++++++--
>  3 files changed, 38 insertions(+), 6 deletions(-)
> 
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
