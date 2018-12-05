Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A12C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A8320892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tyzXhskc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGhavkkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A8320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HkMXdgBEM4krY4t5wWRJsEKMaNE7kQD+iQNX0XLjCnY=; b=tyzXhskcikMTtB
	NLtnbWMdjamg3FXC7MJzCiGCAWNozpTtTXXkX6D7TC16fyrSOCQN7BLQrW4n7dT0azWi4oe7pTN2x
	644nKRkOpw2o+LVtphtexdQnMuafGDWnQNYBRhwqKSsOQU2lB7YABHSsyAVxc/HG9P6ZIcC/VPW7y
	uF+T+fUZHnLyiwadJ9jy5b34+rtudC337cwGxWJMiVqDMimZjlF4aDFHQPN6GEPYSRCtBqdnVb67A
	bG0I2KRaX1vXfRK4xOocAh4zf0KOtohcF8FxnuAVWaYicAhUppT9lrSVAmJvcJ3c/N+2PALNcIv7B
	wwWrt5g9s0JSvbhePmTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUcxJ-0002QD-H1; Wed, 05 Dec 2018 19:35:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUcxG-0002P0-7v
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:35:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1827120892;
 Wed,  5 Dec 2018 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544038519;
 bh=UQcEC3lOYxzmO7G3948nOyr4EYkWEM4aL5QnY6s0R+w=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=FGhavkkRZhVmFhwBh/loWWnIPWRHGIt2+CZuPSXjxfUWkdCKZS2e2sl4gumnEiZj4
 k78K635v1p//Ov67xqqjZ02PhIypJ4QMFU6yk6UXr7yx61E+URmcW2zKe/LjK5dFIl
 aGRvF7Q1dMzN3RLnwcWC4hVTRDPCE/C+IwnUjfw8=
MIME-Version: 1.0
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181205182058.GF31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
 <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
 <20181205182058.GF31204@localhost.localdomain>
Message-ID: <154403851843.88331.12634260159268245703@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Date: Wed, 05 Dec 2018 11:35:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_113530_300992_6C8711D9 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Matti Vaittinen (2018-12-05 10:20:58)
> On Wed, Dec 05, 2018 at 09:19:33AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-12-04 23:00:46)
> > > But that won't solve the issue if we don't do "dirty hacks" in driver.
> > > The devm interface still only gets the device-pointer, not the DT node
> > > as argument. And if DT node for device is NULL (like in MFD cases) -
> > > then there is no parent node, only parent device with a node. For plain
> > > of_clk_add_provider() the driver can just give the parent's node pointer
> > > in cases where it knows it is the parent who has the provider data in
> > > DT. But our original problem is in devm interfaces.
> > > 
> > 
> > I was misunderstanding the MFD design. Should still work though, so I
> > squashed this into the patch to clean things up a bit. Does this work
> > for you?
> 
> This looks good to me. Especially changing the of_is_clk_provider to
> get_clk_provider_node which allows to remove some repetition. If you
> apply this then I will drop my patch from the series. Just please let me
> know. I will cook version 7 of the series at Friday - tomorrow is the
> independence day in Finland and I'll be offline =)
> 

Ok, I applied it this patch with the squash to clk-next.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
