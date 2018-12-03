Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D515C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6ED120848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V9QRiL/E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHpQVXsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6ED120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qIE13VCkwr6SBM1QJ9uFLa9A8rZwc/EXuiUaipbRXIA=; b=V9QRiL/E+zXL0e
	VQ1pXAwWTvWtTYu0HNsFpWsk/xlr/ac1vLbtBM9PSSk+gsijoZrpSem+ZibZuTPyAIe5fqCGOGNHz
	Z+eY20WpDttzXsHjgsgh2yJDUsuAG9LegQ9YRu3Ku44aV8OzqS22hFtkVp5zbY3jb/DDcXX8EUs/M
	S+EnbmsHhjq6M6rh/icaX5wW2dwHQDtpQp9fDpeJ8/EGhqSuBTPUaTO0mNcEpZibVjvUYmkNvdFxq
	DCnx47taF9jp1+qjtpJszoaVmSwFIvttfFRei8AmrhC9BAz2GhhfNsS3ohsyjILZfI9LzNzm5d/Gu
	AF1CYNUilNsBPhfXYSJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrp4-0003g0-GN; Mon, 03 Dec 2018 17:15:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrp1-0003fQ-9q
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:15:52 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8313E20848;
 Mon,  3 Dec 2018 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543857340;
 bh=ysPNaHS1PxY9ROXZfZNrYWzk2JgfBqchDmUPIGrH2yA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=ZHpQVXsafzEmQSns22ljQoCHhONhB1GiQdn9cJqH5o03UbvW3GZSxu82WKCQgLDle
 E4AYFkNHh8C9bAtFxOiWXRxCkGwNFrqmmwO/8Cbzeg6A1ur6z3V2bfHWCAk/EQ3jq7
 8/YHENf3+1RezGr/6p0OPQV/qxa5un4ucmtMetNg=
MIME-Version: 1.0
To: Lucas Stach <l.stach@pengutronix.de>, kbuild test robot <lkp@intel.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <201812010931.vrPHNqVZ%fengguang.wu@intel.com>
References: <201812010931.vrPHNqVZ%fengguang.wu@intel.com>
Message-ID: <154385733975.88331.517929167531670456@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [clk:clk-imx8mq 2/5] clk-frac-pll.c:undefined reference to
 `__aeabi_uldivmod'
Date: Mon, 03 Dec 2018 09:15:39 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_091551_361350_99FE54B0 
X-CRM114-Status: UNSURE (   8.46  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting kbuild test robot (2018-11-30 17:08:33)
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-imx8mq
> head:   de9cffdeeef50f513954ae83e91e1a465906ace5
> commit: 9fd680d0fafd4cfef36088cf866c98ecb028ac34 [2/5] clk: imx: add fractional PLL output clock
> config: arm-defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9fd680d0fafd4cfef36088cf866c98ecb028ac34
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_round_rate':
> >> clk-frac-pll.c:(.text+0x50): undefined reference to `__aeabi_uldivmod'

Oops. I forgot to drop this branch from the clk tree. Thanks for the
reminder.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
