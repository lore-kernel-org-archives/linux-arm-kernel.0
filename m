Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B29C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D44F217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F75HUcIk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JEZ4+jTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D44F217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S9eFwCsEaGXt3ivlCptgooZCxjbylgKVnjMYqd1DFOc=; b=F75HUcIkGVKUCi
	Nt4NXbuEYitBnbueVnwnUvZl5bnwcMNBmn83BQjuLxm9pAAO70/Mh3SKZE3uwJbmGcUzFiEJJtx2g
	qm7IGRBFxXfDVzceZCYrIQe5OQrh0hSKFJLGgXT4GBa6RNdo8+bXhkdcjJi3NBAYoYQf/MPj5oRzg
	vEg/hI6GzHcoo6XSbQBrW18Wxu6bN6B8Wgwo1DhHUdIeMZYzHiawTo/qhNEjku1x5C0ACqxawO4hr
	vQZAQv9Vb3KO6gsFO5qUdoFFHOwe+b8/etHKPMvn8t058+r/4NH2oItlS/GPmp7YabsiAzDK4ju7c
	qKnBNAcWwDGozEiM4HeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz6Bf-0001Od-GS; Wed, 27 Feb 2019 20:52:19 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz6BD-0000zh-2V
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 20:51:58 +0000
Received: by mail-pl1-x643.google.com with SMTP id d15so8597895plr.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8wmkdekUxLYxZChNgATUWmR0Z5SXg06nnSmuJG/WF0M=;
 b=JEZ4+jTHAPfENHWlUrv4QuVqM72M4ECKJLdlkTa0XIqSxvQFW53AeCE5zeIeY477yb
 m3cO5UhypROXmeoI0krV4xe3Y8+x5tK0zTxmMgefRVHkD2n26d/dikZpSfqAlys6JRu/
 VslrwI92iVq7VS5ySB+hO+SE41lm0O6X0fIWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8wmkdekUxLYxZChNgATUWmR0Z5SXg06nnSmuJG/WF0M=;
 b=HVHGL7AWNDF5fn7ya01/DW/K2/kNMO8Eosj6G1Yaa9Ss7QjR/gzSH/HuaNM46tTt21
 Hhz/gEwhe+Sj6idFI2oMTEKIboRv9KeritZg9Pqo40avRLRQ8nKlPqJCdrN6Cpl6kXXm
 UxJQpr9VkplAVJOTjo6/adp2Sk4W5v6zwsA0uJlD9VQkaLqz4jYRrx1Vfxo/glCX+bNY
 midXDLEhESa+ezKjnVNZo4sjsjg5lnkQJFEVhsUa258xWSjU7K6GxoGF7IxmLACkSnwp
 w0tA/LJZhLojCLYERZV6yH1Ru1L348vKw2brtynad8A4ga5tlNNTZfZ88PHmp9xXbOL3
 I8UQ==
X-Gm-Message-State: AHQUAuYN6VVL30Agqe3Wqp645CtC3T1H10Rb7+xyG1jFl1blG7I8oCG5
 CY+sf9n+vnUlS8/JYxfLrKThGQ==
X-Google-Smtp-Source: AHgI3IZZ/Ogx6tKI0poxhsJNOZHMzo5UPZ8ynB1LyMFy9Q4SeY9kqh8wFXMPRN4aHmnVLA1qwdWohQ==
X-Received: by 2002:a17:902:2de4:: with SMTP id
 p91mr4193177plb.215.1551300709989; 
 Wed, 27 Feb 2019 12:51:49 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id z7sm36689613pfl.4.2019.02.27.12.51.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 27 Feb 2019 12:51:49 -0800 (PST)
Date: Wed, 27 Feb 2019 12:51:46 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
Message-ID: <20190227205139.GE174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_125151_921818_73355377 
X-CRM114-Status: GOOD (  34.50  )
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
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>,
 Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On Wed, Feb 27, 2019 at 10:02:16AM +0000, Marc Zyngier wrote:
> On 26/02/2019 23:28, Brian Norris wrote:
> > On Sun, Feb 24, 2019 at 02:04:22PM +0000, Marc Zyngier wrote:
> >> Note how the interrupt is part of the properties directly attached to the
> >> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> >> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> >> altogether (Yay for the broken design!). This is in total violation of the
> >> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> >> specifiers describe the PCI device interrupts, and must obey the
> >> INT-{A,B,C,D} mapping. Oops!
> > 
> > You're not the first person to notice this. All the motivations are not
> > necessarily painted clearly in their cover letter, but here are some
> > previous attempts at solving this problem:
> > 
> > [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> > https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
> > http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> > 
> > As you can see by the 12th iteration, it wasn't left unsolved for lack
> > of trying...
> 
> I wasn't aware of this. That's definitely a better approach than my
> hack, and I would really like this to be revived.

Well, in some respects it may be better (mostly, handling in the PCI
core rather than each driver). But I'm still unsure about the DT
binding.

And while perhaps I could find time to revive it, it's probably more
expedient to kill the bad binding first.

> > Frankly, if a proper DT replacement to the admittedly bad binding isn't
> > agreed upon quickly, I'd be very happy to just have WAKE# support
> > removed from the DTS for now, and the existing mwifiex binding should
> > just be removed. (Wake-on-WiFi was never properly vetted on these
> > platforms anyway.) It mostly serves to just cause problems like you've
> > noticed.
> 
> Agreed. If there is no actual use for this, and that we can build a case
> for a better solution, let's remove the wakeup support from the Gru DT
> (it is invalid anyway), and bring it back if and when we get the right
> level of support.

+1

Today, something simple like NL80211_WOWLAN_TRIG_DISCONNECT and
NL80211_WOWLAN_TRIG_NET_DETECT may work OK, but I'm not confident that
anything more complicated is really a compelling story today (well,
outside of Android, which has a massively more complicated--and not
upstream--setup for this stuff).

> [...]
> 
> > One problem Rockchip authors were also trying to resolve here is that
> > PCIe WAKE# handling should not really be something the PCI device driver
> > has to handle directly. Despite your complaints about not using in-band
> > TLP wakeup, a separate WAKE# pin is in fact a documented part of the
> > PCIe standard, and it so happens that the Rockchip RC does not support
> > handling TLPs in S3, if you want to have decent power consumption. (Your
> > "bad hardware" complaints could justifiably fall here, I suppose.)
> > 
> > Additionally, I've had pushback from PCI driver authors/maintainers on
> > adding more special handling for this sort of interrupt property (not
> > the binding specifically, but just the concept of handling WAKE# in the
> > driver), as they claim this should be handled by the system firmware,
> > when they set the appropriate wakeup flags, which filter down to
> > __pci_enable_wake() -> platform_pci_set_wakeup(). That's how x86 systems
> > do it (note: I know for a fact that many have a very similar
> > architecture -- WAKE# is not routed to the RC, because, why does it need
> > to? and they *don't* use TLP wakeup either -- they just hide it in
> > firmware better), and it Just Works.
> 
> Even on an arm64 platform, there is no reason why a wakeup interrupt
> couldn't be handled by FW rather than the OS. It just need to be wired
> to the right spot (so that it generates a secure interrupt that can be
> handled by FW).

True...but then you also need a configuration (enable/disable) API for
it too. I don't think we have such a per-device API? So it would be a
pretty similar problem to solve anyway.

> > So, we basically concluded that we should standardize on a way to
> > describe WAKE# interrupts such that PCI drivers don't have to deal with
> > it at all, and the PCI core can do it for us. 12 revisions later
> > and...we still never agreed on a good device tree binding for this.
> 
> Is the DT binding the only problem? Do we have an agreement for the core
> code?

I'll have to re-read the old threads. I don't really remember where we
got bogged down... I think one outstanding question was whether WAKE#
should be associated with the port vs. the device. That might have been
might fault for confusing that one though.

> > IOW, maybe your wake-up sub-node is the best way to side-step the
> > problems of conflicting with the OF PCI spec. But I'd still really like
> > to avoid parsing it in mwifiex, if at all possible.
> 
> Honestly, my solution is just a terrible hack. I wasn't aware that this
> was a more general problem, and I'd love it to be addressed in the core
> PCI code.

Ack, so we agree.

Thanks,
Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
