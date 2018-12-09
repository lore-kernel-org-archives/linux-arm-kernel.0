Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C34C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:45:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3AB20837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S5MJQSFT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc/a/Mt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3AB20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KSUEv9+Jtn9j3A77GPJCzS2yOVkI0JpcEoAJfBn7kkU=; b=S5MJQSFTO4ko3K
	M4WfssA/dzXoK+cQsCmzSlcXObvSJ9s1HJo/2dENZhxCInmZDDPnzHlIdgsCyaIxsScnmovIbCphv
	pQ+Unnk6ZOaj8RgwbT35R/2t8IsvSGT4SIpfSLUTlK4EzI8lTa9pB8Q2NqnzYgfGv7Wvc2Vh35tOd
	5ygDCUZJuAs4BtVtt3r+mvkHl7kC28oshJrg5xU6nKbExwC6LTdcP8gbvdqNN63d/zaRX3Gx4IcQN
	m5gK5X9grhvImNIWc6DTDuwWvUAd743TTIjOp42c56j92LbPLPMubeMLLFaxwpBnIfSdAaR8Nn3xL
	3D2SJ2Dzd3ylhJuZzf+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVySH-0000i2-1N; Sun, 09 Dec 2018 12:45:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVySD-0000KH-Fy
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 12:45:02 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9240820672;
 Sun,  9 Dec 2018 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544359491;
 bh=rCWDA+ZDbSpzlhOykRuLW5bERIZWw4iTBbBtykQnc8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dc/a/Mt8bAxRjwnvrbWPvWwb8Tk687m3uBrjl6pGrw3BwzsdkZYkJv4WXNxT/X+8n
 kbn8M+oz3MSvUH3URmBiT3/cM96OOTrphZd1xeD985bkPe0GerncByVnG092Sl5ZWA
 kF18sDNX+cXRbnMxfXNYnKLNJbzxIsEsU+mqlxLs=
Date: Sun, 9 Dec 2018 20:43:59 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v3 06/12] arm: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20181209124358.GC22960@dragon>
References: <1544114849-47266-1-git-send-email-andrew.murray@arm.com>
 <1544114849-47266-7-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544114849-47266-7-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_044501_545044_2E1B1C7F 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Matt Turner <mattst88@gmail.com>, suzuki.poulose@arm.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 04:47:23PM +0000, Andrew Murray wrote:
> For drivers that do not support context exclusion let's advertise the
> PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
> prevent us from handling events where any exclusion flags are set.
> Let's also remove the now unnecessary check for exclusion flags.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm/mach-imx/mmdc.c     | 9 ++-------

For imx mmdc changes:

Acked-by: Shawn Guo <shawnguo@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
