Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22286C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:15:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7682081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OfCZd2Vi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYI1XXW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7682081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EwNZZyTm/Kn7s1IFYUuSUREIPSmRMu3IFTgVyE7ParA=; b=OfCZd2Vinm13Gc
	cRx/bqVv0hBPoOOPQn0amwBssglCezbBooXq2scDRtYvZUw2Cnfi/IdwpCPoLqmNGCxKddHobKFrr
	FFuI01nWZDbDGkGVyXPvGK+4yhz6+D2gvBfIbajyejTGAQoOg6oiBJ9Ja56NMPptDXIr7PNsZ2JJh
	7AGkupBIInyJV4RAASlxxs37R+bU5noXPWGj5gyOMhsN5PO2LPNqJUHyVA4fj6PHRi0HBCHJPzIbp
	lZhJ+Saz7hJ58ZIS8K3u7JEieiPMdarzQh7b+N4NWScO4dWh0vxx6JwBtKtP03kC6LCJKR8+B8/Zi
	pa0+ZN2R3HB/MIhg6dow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFEh-0007Pp-KS; Tue, 04 Dec 2018 18:15:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFEe-0007P5-Mo
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:15:54 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 510A62081C;
 Tue,  4 Dec 2018 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543947342;
 bh=Y4/p4moEvmuABAAGtdeSo+XewcMe4C8bg/taUOvaUtI=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=jYI1XXW6d/ILRf0IXat3o1QE4Ef1DptDzbS94L81/xFH6d3B1WoqwSzTB8iJfF8lZ
 LrAx4Ap+jL/SUrAhLHa6Jc7lfPMz3R/UgI4914rj5m8ytqHzjvAPpc/uBrkB/MR9c9
 q2JyEyIaNJ4XfHgOQGV+qnkuKEbc8fUqwEeFcyP8=
MIME-Version: 1.0
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-8-git-send-email-sugaya.taichi@socionext.com>
 <154356669840.88331.4455990896653868594@swboyd.mtv.corp.google.com>
 <298cd5a5-66cf-0936-405e-59bcc7c396ed@socionext.com>
Message-ID: <154394734173.88331.18352656286616172689@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 07/14] clock: milbeaut: Add Milbeaut M10V clock control
Date: Tue, 04 Dec 2018 10:15:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_101552_762442_E6D41B6E 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Sugaya, Taichi (2018-12-04 00:26:16)
> On 2018/11/30 17:31, Stephen Boyd wrote:
> > Quoting Sugaya Taichi (2018-11-18 17:01:12)
> >> +void __init m10v_clk_mux_setup(struct device_node *node)
> >> +{
> >> +       const char *clk_name = node->name;
> >> +       struct clk_init_data init;
> >> +       const char **parent_names;
> >> +       struct m10v_mux *mcm;
> >> +       struct clk *clk;
> >> +       int i, parents;
> >> +
> >> +       if (!m10v_clk_iomap())
> >> +               return;
> >> +
> >> +       of_property_read_string(node, "clock-output-names", &clk_name);
> >> +
> >> +       parents = of_clk_get_parent_count(node);
> >> +       if (parents < 2) {
> >> +               pr_err("%s: not a mux\n", clk_name);
> > 
> > How is this possible?
> 
> When the node has more than 1 clks...
> Or I am misunderstanding your question?

This looks like code that's checking DT for correctness. We don't
typically do that in the kernel because the kernel isn't a DT validator.
That's all I'm saying. I think this comment is not useful if the driver
design is done to specify parent linkages in C code instead of DT, so
don't worry about this too much.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
