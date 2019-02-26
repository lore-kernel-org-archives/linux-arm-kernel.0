Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D51C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4928B218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l34j6PA8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UZvFI2Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4928B218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ikQpE23KHDaniL0QhDy+XpVIY8CnKdkMybj1DQg7mU=; b=l34j6PA86js0CM
	+UmsjxBMOUxvsTmfM/1m1vEnhA+hEpCSvfEwIwo4qGkBZMqUkmjnR9QSw1ASLoHOAW6z6pUG6zhIC
	qf335DjZ2+l4HHAEyxzx7kG0CmJR42pAF/eD5Fq7jMAXCllwTrtvgHqdeO+th1NFkpYO/8oqAYswN
	p5UmWXKWpr+yVkIxi3b8m7cH1syarDvjysN2oYSqQsU7qavuO7uMSaAWDOeAujd185I5d9UEgVYhw
	fM+p5ml2AK/H/ws4rS+4QSTjjrILZIWWMXqh/bhtTefos0S3VQVq4Dth7AkRkKk+rXg+SVQ0pdTa7
	ujuSGsuyVd2oOfA5/RLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymOm-0003HX-Eb; Tue, 26 Feb 2019 23:44:32 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymOh-0003GN-JS
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:44:29 +0000
Received: by mail-pf1-x444.google.com with SMTP id s22so7028211pfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OFnLT5XdPjqDxL6/K91hoXuMuyo4KTpfIXDgQ+N2d3Y=;
 b=UZvFI2GjkVuuFoyBvh4bJSdn7ATJZRWjS30gFEmLU37mK1BBfLrV/tvmc9PnixBT8M
 So+FliEBPa/oBXiYdELL9iDYVDLDZxCO9RFLp2EA+64bpeYbFQDVdw4oHDBQkGSYTdkG
 cVFtuhjbYqBrxuCAhUOUjCSKls1M7GaSlU5S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OFnLT5XdPjqDxL6/K91hoXuMuyo4KTpfIXDgQ+N2d3Y=;
 b=K2n/tKH2Uy/Qs/nPB15OOxzs2EI6R6x4jiGfTzLSZjH10UvAl7RvcZSj9QWLRqv1fN
 V8cO+VSYXV7Ge0VFeqjJd4Vx0t7QGT+aaWWmT8fBq/jB997oWmKGXQojxw6GVx8r8elz
 OaVqLPtUp5wh4t92eZoE5p25js9t/4Pmzsaj+c8r9k9U/9siCzjfHY+ENpTCkPOJVaVo
 33fRZH9CsolMwM79XiIPfZoZ2qBw7MqMrOmZNTpnBaWxmLWTH5Bls54n4KYBPVoBySpZ
 aEv+3tilRHKI1ZN2Ftuw2t0IVj38rNioRI1F7irHVRPr8IPpKnS1zpJ8lOASTHniefKW
 Sh7g==
X-Gm-Message-State: AHQUAuYXVCKonhIGDZEbl0D94wZvZm/WGE8qR1xSfWVQ4FQjQ13iRaTL
 YRb59swHzhpoBHuE1Q8av2UJ/g==
X-Google-Smtp-Source: AHgI3IZ3b25RdTEFdcJ4w+m0hBHnIhGkp5dN+7k66Ly/vLQ284p0Gvn7FT9oPhFP4BcM72QTK1hXgA==
X-Received: by 2002:a65:4147:: with SMTP id x7mr22593pgp.54.1551224666997;
 Tue, 26 Feb 2019 15:44:26 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id q62sm24471018pfi.183.2019.02.26.15.44.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 15:44:25 -0800 (PST)
Date: Tue, 26 Feb 2019 15:44:23 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Message-ID: <20190226234422.GD174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <CAKv+Gu9OOzOxx0rTAZqM8r4q_hRmOp3b=KP7fwgNeiu67FCApA@mail.gmail.com>
 <5310b73b-4821-6dff-b9c0-34c59fb7fd72@arm.com>
 <CAKv+Gu_=bQyVZqgUnJm9moCcaCcpDrag6NWGEpaR65=pMiTFJQ@mail.gmail.com>
 <0c433a70-27f6-76ad-c46c-6015de1ffaa4@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c433a70-27f6-76ad-c46c-6015de1ffaa4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_154428_033774_58638DEC 
X-CRM114-Status: GOOD (  25.16  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>,
 Devicetree List <devicetree@vger.kernel.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Xinming Hu <huxinming820@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>, linux-pm@vger.kernel.org,
 "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Feb 26, 2019 at 05:14:00PM +0000, Marc Zyngier wrote:
> On 26/02/2019 16:21, Ard Biesheuvel wrote:
> > On Mon, 25 Feb 2019 at 15:53, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> It outlines one thing: If you have to interpret per-device PCI
> >> properties from DT, you're in for serious trouble. I should get some
> >> better HW.
> >>
> > 
> > Yeah, it obviously makes no sense at all for the interrupt parent of a
> > PCI device to deviate from the host bridge's interrupt parent, and
> > it's quite unfortunate that we can't simply ban it now that the cat is
> > out of the bag already.
> > 
> > Arguably, the wake up widget is not part of the PCI device, but I have
> > no opinion as to whether it is better modeling it as a sub device as
> > you are proposing or as an entirely separate device referenced via a
> > phandle.
> 
> It is not that clear. The widget seems to be an integral part of the
> device, as it is the same basic IP that is used for SDIO and USB.

It's not really a widget specific to this IP. It's just a GPIO. It so
happens that both SDIO and PCIe designs have wanted to use a GPIO for
wakeup, as many other devices do. (Note: it's not just cheap ARM
devices; pulling up some Intel Chromebook designs, I see the exact same
WAKE# GPIO on their PCIe WiFi as well.)

> It looks like the good old pre-PCI-2.2 days, where you had to have a
> separate cable between your network card and the base-board for the
> wake-up interrupt to be delivered. Starting with PCI-2.2, the bus can
> carry the signal just fine. With PCIe, it should just be an interrupt
> TLP sent to the RC, but that's obviously not within the capabilities of
> the HW.

You should search the PCI Express specification for WAKE#. There is a
clearly-documented "side-band wake" feature that is part of the
standard, as an alternative to in-band TLP wakeup. While you claim this
is an ancient thing, it in fact still in use on many systems -- it's
just usually abstracted better by ACPI firmware, whereas the dirty
laundry is aired a bit more on a Device Tree system. And we got it
wrong.

> Anyway, it'd be good if the Marvell people could chime in and let us
> know how they'd prefer to handle this.

I'm not sure this is really a Marvell-specific problem. (Well, except
for the marvell,wakeup-pin silliness, which is somewhat orthogonal.) In
fact, if we cared a little more about Wake-on-WiFi, we'd be trying to
support the same (out-of-band WAKE#) with other WiFi drivers.

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
