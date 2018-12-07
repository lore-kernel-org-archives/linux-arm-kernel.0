Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC5C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C513220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dh7utxT4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORdJPgSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C513220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:Message-ID:To:From:
	Subject:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eR/+hYrnD8chbaHKNixDHpOBZ6YZIw2pzxg2d3yY46M=; b=Dh7utxT4exBN1d
	IWo71rrvpY+eHPICOOpf/FltODxIAv0JZpCt7cWpUbbJXYJiS/I55EfVNx2ed85tgPYFSGEsuV2gP
	gI1Z6rjvVzJbHDp9g5eyuBhfHpZ0UhaVKYcD+ecAPmcu0IImSSgaKmzl47NEl3gz4P0d/pF9nO226
	DFlExD6mXFOx4tYelvN3lFlTnTlG7LXatiK2o7qbmsHnaiB7DP1tqbLSUw0jEF6vEV3Aw8l7Bhosi
	gFJ6wrsea4Fe2L10uMNN6ZRMEZDOWB85psv36pODU9PM7FbzEGBXjOzRdd7OSWQNVFYIHlzNX3POD
	46hsAfTIal9TtmjuIZgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVMwA-0006Yn-6D; Fri, 07 Dec 2018 20:41:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVMw6-0006Xs-V1
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 20:41:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A05520868;
 Fri,  7 Dec 2018 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544215272;
 bh=Yc0dRxw0Jepsddn/3hjkpROAC2x54HhwYVQha610dT0=;
 h=References:Subject:Cc:From:To:In-Reply-To:Date:From;
 b=ORdJPgScik6OlUe2RjwMPun0kdqwkmjjnbNl2VAU8YKMyZGq6JbhZstk/vJNcL6YM
 hcNPBU5Rb5Zpo+5qhv/T5Yrl5Vc9U1d0sok+lP1puuv1AIn0pKddl3efKNgfIJeP1M
 bT7biifaF35k0YQp5c0u/0ISg92mINttzZ2bKENc=
MIME-Version: 1.0
References: <20181207150158.vvfpjcxjikjjyj5m@flea>
Subject: Re: [GIT PULL] Allwinner clock changes for 4.21
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <154421527147.168715.17089570196269110319@swboyd.mtv.corp.google.com>
In-Reply-To: <20181207150158.vvfpjcxjikjjyj5m@flea>
Date: Fri, 07 Dec 2018 12:41:11 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_124123_020572_F1BA5362 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Maxime Ripard (2018-12-07 07:01:58)
> Hi Mike, Stephen,
> 
> Please pull our usual changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-clk-for-4.21
> 
> for you to fetch changes up to 6e6da2039c82271dd873b9ad2b902a692a7dd554:
> 
>   clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks (2018-12-05 12:08:20 +0100)
> 

Thanks. Pulled into clk-next.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
