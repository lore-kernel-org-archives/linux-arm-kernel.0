Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F95C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD0E20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQ9mwKaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD0E20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fg3v5kR7Uo4YvrayIeyjvUrtY9VRP3WuZpnmPa96l2o=; b=aQ9mwKaU8Z+WrF
	dYLSuWP6wMjXS9NhtHK4L5eUroR3zRTwcPG1OyAuPWfJNOFh61PFWK0/Rn3qxccCxyot8NGqbybCX
	i5QetBhYVXzSdgSkax1DSJ041QU4VJ3aHzpFCSf4VB5kf/UBE8U0AItuWOPHzv8dVqt05w267Bz/W
	DcOjw846KsQvDdtzTZJLjSNue8W507YrgytHB28r82E/knGacTaKGFfFux76kBavWLNMclaR3eE0d
	Vg6lNsJPhd2j+KXUDcPhXwY6u/uYYZQOVtuVpMqP0yzTRkiTvt9ZxMawDWukdfGBXidSs3GAiCIJ0
	m51biqT9UZkLl32CRGrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcYzQ-00052L-Bi; Thu, 27 Dec 2018 16:58:32 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcYzM-00051X-Jq
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 16:58:30 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 0E5A18105;
 Thu, 27 Dec 2018 16:58:19 +0000 (UTC)
Date: Thu, 27 Dec 2018 08:58:12 -0800
From: Tony Lindgren <tony@atomide.com>
To: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
Message-ID: <20181227165812.GS6707@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
 <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
 <20181223163040.GO6707@atomide.com>
 <CAHCN7xJKyjXb6br-f+_q_dQxkqWHFxFfA+X_yYG4eh8w7RW8SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHCN7xJKyjXb6br-f+_q_dQxkqWHFxFfA+X_yYG4eh8w7RW8SQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_085828_692921_E4D54488 
X-CRM114-Status: GOOD (  16.47  )
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
Cc: devicetree <devicetree@vger.kernel.org>, linux-omap@vger.kernel.org,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Adam Ford <aford173@gmail.com> [181227 14:33]:
> On Sun, Dec 23, 2018 at 10:30 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Adam Ford <aford173@gmail.com> [181222 20:54]:
> > > I noticed for your patch, I noticed you listed both the IRQ, gpio 149
> > > as well as uart1_rts.  Looking at the device tree, I see that
> > > uart1_rts is configured as gpio 149.
> >
> > The uart1_rts is just the pad name used in the TRM, so it should
> > probably say uart1_rts.gpio_149 meaning pad uart1_rts is muxed to
> > gpio_149.
> >
> > Would that clear the issue for you?
> 
> That part I understand.  I poorly phrased my question.  What was
> mostly confusing to me is why both irq and wakeup interrupts are
> needed since it seems like
> 
> <&gpio5 21 IRQ_TYPE_EDGE_RISING>,
> 
> and
> <&omap3_pmx_core 0x14e>;
> point to the same pin.  Or did I mis-interpret the datasheet again?  :-)

Ah OK. Yes the same pin can trigger interrupts at two different
controllers. During runtime a proper GPIO is triggered, and then
in deeper idle states only the padconf interrupt is triggered as
the GPIO can be powered off. So the padconf interrupt is there
to provide wake-up events if configured. This allows the device
to enter off-mode during idle with things like ping and ssh
working with some extra latency :)

The padconf interrupt can also be something other than a GPIO pin,
such as UART RX pin, and the padconf device is separate from the
GPIO device. So they're treated as two separate interrupt
controllers. They can be both active the same time although that
is undesired for the extra overhead.

Eventually we should be able to make the GPIO interrupts work
in a transparent way with the padconf interrupts.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
