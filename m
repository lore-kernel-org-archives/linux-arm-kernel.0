Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D6C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3919C213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZvaS4w7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IS2KUIgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3919C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T3ODGDiAi6RmHVflOr333qhtysmM39BAHXk5EBzfoIQ=; b=EZvaS4w7I/ORUI
	5o2/RzHOJiuSBd7oHOQ+DKBw6jHbDBQ9sBfEftTcVSAGf/Nv2vAAg22IUr2AH/Nqw7BVXam4bwShu
	/QN/2dlCgQ+toyLB5K48nJk86Xn0wH3s4UYxvUvBcAw5zBnerM+fBGidhKfDQ8gGdX8jDrpd4bx/Z
	Wn4ocQsVFR9O7x601kaH9IWg5BbIYAV4UHt/i05NZhXQefR1lVGCxhTDuyFGyB9d+m1bzoRgQDPP4
	7cL1XHGzVu6TOUWxZ8PP/D0G0TUUNogbzZwetyyavnbtYbXG+vAAdHmYQiv1Q05zQWxLfot3k0Pbr
	HNw3x+gnSHvFc3GR96/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz6HD-0003Xk-Cz; Wed, 27 Feb 2019 20:58:03 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz6H9-0003Wd-CI
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 20:58:01 +0000
Received: by mail-pl1-x642.google.com with SMTP id b65so5559179plb.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 12:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c8VWH6zBnriKrNXSEqZVVW0Kns2rlHqKeHT5OroTUIQ=;
 b=IS2KUIgJgNd0ucZl768yoRseJvxnyHKS/3NycTcRYZSEjwRArteaDb7lvOR0zwBhRi
 L2SS43CEyx7h8uKvGY7A1lRRYU4pBbWznUqXM+5XqUH5WoJyArubm/N9omPO7BVaXcsM
 5IczBEs4mrCr+ygxwTwUdkywizoVCgkRMI04s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=c8VWH6zBnriKrNXSEqZVVW0Kns2rlHqKeHT5OroTUIQ=;
 b=AVNaYHKvzzHzVDC3NnFyf4mW4Z7gcmXisr/i8VcHx1XTC7RZYajW2T1ey2JOJ59UQS
 OrOlP6UzXiy7+YrpFCB2nuHw/Lohwoa/c/1AL+8bPORIfOT5Lr+keN65XdDRRm2gKsTF
 YRuRx91uGtjWnnd8MyxoZuMnIYxoKcXBu2FXSPw+SR4nmisHGskBnp26JHxt1LfwJ6G1
 9oWiPoH9Zigg8rBIl3zEGkdJGT5FHX8xxKOqfcIqwEfJSXMTWzE1VUwIIt5zkBLTM08H
 qtU6sr8pKbEjoe9syj/ipSF2hUgAxrGo3DuSwulEjTd4H9BBWXLWXDAH44yFQM6zVrAs
 4L+A==
X-Gm-Message-State: AHQUAubzoJl5NBnNuyTdlKuQmVPk4lB49hZDepK2L1QYtsFvGW24He6g
 PCbg5q5Hy/BUw1StaffQ2vEEEA==
X-Google-Smtp-Source: AHgI3Ib7syP6DcLdP9NHp9gQdrO6NgYoCGNPaMVqk/1Djv5xl6BX3qIYqHBiYM9BCmgFgaVwqAgWdQ==
X-Received: by 2002:a17:902:6a83:: with SMTP id
 n3mr4161242plk.313.1551301078637; 
 Wed, 27 Feb 2019 12:57:58 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id u11sm17044796pfh.23.2019.02.27.12.57.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 12:57:57 -0800 (PST)
Date: Wed, 27 Feb 2019 12:57:55 -0800
From: Brian Norris <briannorris@chromium.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Message-ID: <20190227205754.GF174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
 <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_125759_444079_88E7B3FD 
X-CRM114-Status: GOOD (  23.56  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Amitkumar Karwar <amitkarwar@gmail.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Ganapathi Bhat <gbhat@marvell.com>,
 Xinming Hu <huxinming820@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ard,

On Wed, Feb 27, 2019 at 11:16:12AM +0100, Ard Biesheuvel wrote:
> On Wed, 27 Feb 2019 at 11:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 26/02/2019 23:28, Brian Norris wrote:
> > > You're not the first person to notice this. All the motivations are not
> > > necessarily painted clearly in their cover letter, but here are some
> > > previous attempts at solving this problem:
> > >
> > > [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> > > https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
> > > http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> > >
> > > As you can see by the 12th iteration, it wasn't left unsolved for lack
> > > of trying...
> >
> > I wasn't aware of this. That's definitely a better approach than my
> > hack, and I would really like this to be revived.
> >
> 
> I don't think this approach is entirely sound either.

(I'm sure there may be problems with the above series. We probably
should give it another shot though someday, as I think it's closer to
the mark.)

> From the side of the PCI device, WAKE# is just a GPIO line, and how it
> is wired into the system is an entirely separate matter. So I don't
> think it is justified to overload the notion of legacy interrupts with
> some other pin that may behave in a way that is vaguely similar to how
> a true wake-up capable interrupt works.

I think you've conflated INTx with WAKE# just a bit (and to be fair,
that's exactly what the bad binding we're trying to replace did,
accidentally). We're not trying to claim this WAKE# signal replaces the
typical PCI interrupts, but it *is* an interrupt in some sense --
"depending on your definition of interrupt", per our IRC conversation ;)

> So I'd argue that we should add an optional 'wake-gpio' DT property
> instead to the generic PCI device binding, and leave the interrupt
> binding and discovery alone.

So I think Mark Rutland already shot that one down; it's conceptually an
interrupt from the device's perspective. We just need to figure out a
good way of representing it that doesn't stomp on the existing INTx
definitions.

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
