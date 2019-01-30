Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5377C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:24:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951392184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzoFu2V5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kxg+Dia/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQcnG5sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951392184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eppv3HcIvoKLZT3vS70RsD66jelaUPhQkpEnlJSgp0Y=; b=MzoFu2V5z0hfcl
	4vppbsDZuoqTZlZGkcy6rSqBPrQn3KjNgyoWs3X9XYXHEX9efQlVppdbN1MGJ/X0qeOeA0/cuuhNR
	iiof6OIzDXzS/WFqT1vKKAN3eXu8QRzKXOYN+WkpZLZHlCATyX8RAsRY1xCxnP7Yzhn3o7VeMjeEt
	zGYbySrkPrHg4yd2gwXyNTAUQCC9r7q1b2H+3MmKd5UHkh5KRF0FHtZzlgN+dFeIz98rQd0XAb9cr
	xgokD/Q88Lx0+scdCgwiSeZOzy1Tzw+FXunGx35SknwdiVNm6rxghdbdVRCQcCqNGDNJcFy0m06oJ
	VWVoD2TNbx5lh2gBZZ2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom6Q-0001h4-3u; Wed, 30 Jan 2019 09:24:14 +0000
Received: from new1-smtp.messagingengine.com ([66.111.4.221])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom6M-0001gg-MG
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:24:12 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id D03DFF6B1;
 Wed, 30 Jan 2019 04:24:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 30 Jan 2019 04:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=vZFFhsDnfHn8VE7CScQ9E9hZjT/
 IcjCbJzVpg383Qw0=; b=kxg+Dia/vPCNhniHjBe25RwJ7prY1XGYrjOJ0Va/vjk
 S5jjjlKkdfjqajHhVekaeYzOxW8RxePWTdLV4NdygO+/pyblYsJmnam/g0arcBin
 2F0sWKyrEwEYDcH0F/DpR5gmp73yw7cxcXXsSg8mUikg3U5xbJtzjzr5s6HtgQAv
 vQAFRdFljSEtbjfEcKz5RCfK3w8iOb5n5O9bvZ9IMihlKlFDA85VjUSXzmYDunyg
 o+814ZnqQ9zvI2FW+xO/skYewUIg+0flWrhPZOIl4rnl8oPUWRWsaBPU2+6jrAka
 WsSsTBuF4A5Upk6osvRTgi29vwKkBgKb6Cii+xd17LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vZFFhs
 DnfHn8VE7CScQ9E9hZjT/IcjCbJzVpg383Qw0=; b=ZQcnG5sZlAGmRpnyEGfkr6
 0r3cAB2PRC0/unAYHC4dpccEAzgPJmS9HJR/3A0IgZutoA/gs0dtoT3Rj92p9ZzA
 WW28KaQceQIoLK7QnFdwqcgeVUMLYeaYQhTGdgdn6hkU8d2GAOFl0BFmyQN14eIm
 J+ZyO7nHl+3BzopzdIh6WrsSd9Gl7eJ+wJWoURBGNXga/lK1xG+5sGvqnyLPX0C+
 QzulvRbZegccMAgWsw3/cBfL0YVRP14Sx/YlJc5B9hY2RXuyrO2Fzk78GtFH9SBk
 PrH61hRMWS3EZKMWLPQhZGilYal1BpLh3/hPRuzaLnddPjm0HTsap2+QYKgzXZdA
 ==
X-ME-Sender: <xms:N21RXECK28__HMG5XEUdbbWI-j1qqpquxgC-PBtLk52spsvUWlJ1pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeeggddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
 tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttd
 dmnecujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhr
 vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekle
 druddtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
 necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:N21RXCXlAMY1jyNUJ6ZhNfXkCRD49QOIMMgz65S-v0cLsXFqtAml6Q>
 <xmx:N21RXNEM40-hQkX7zGbT5ee7z4eHVabe3_H_WXJTyutFpqhSTLXxLw>
 <xmx:N21RXNNW2IWENzgnipBO3u7__qh2K9WnN5e44i_LclpZHI7usyk6Vg>
 <xmx:OG1RXDCZMqSC60bMJIgp06kIYGH4MB9CVD2uiyCt9Bv2an6cqcBLKQ>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 by mail.messagingengine.com (Postfix) with ESMTPA id 37C50E4559;
 Wed, 30 Jan 2019 04:24:07 -0500 (EST)
Date: Wed, 30 Jan 2019 10:24:05 +0100
From: Greg KH <greg@kroah.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 1/2] serial: mps2-uart: move to dynamic port allocation
Message-ID: <20190130092405.GA27385@kroah.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
 <1548425597-38175-2-git-send-email-vladimir.murzin@arm.com>
 <20190130082753.GA24317@kroah.com>
 <0bea8e14-9ade-aed4-c41e-f02ab0b81d24@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0bea8e14-9ade-aed4-c41e-f02ab0b81d24@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_012410_895998_5B918D53 
X-CRM114-Status: GOOD (  15.08  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
 sudeep.holla@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 08:58:53AM +0000, Vladimir Murzin wrote:
> On 1/30/19 8:27 AM, Greg KH wrote:
> > On Fri, Jan 25, 2019 at 02:13:16PM +0000, Vladimir Murzin wrote:
> >> Some designs, like MPS3, expose number of virtual serial ports which
> >> already close or exceeds MPS2_MAX_PORTS. Increasing MPS2_MAX_PORTS
> >> would have negative impact (in terms of memory consumption) on tiny
> >> MPS2 platform which, in fact, has only one physically populated UART.
> >>
> >> Start with converting existent static port array to idr. As a bonus it
> >> make driver not to fail in case when no alias was specified in device
> >> tree.
> >>
> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >> ---
> >>  drivers/tty/serial/mps2-uart.c | 47 ++++++++++++++++++++++++++++--------------
> >>  1 file changed, 31 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> >> index 9f8f637..6da0633 100644
> >> --- a/drivers/tty/serial/mps2-uart.c
> >> +++ b/drivers/tty/serial/mps2-uart.c
> >> @@ -22,6 +22,7 @@
> >>  #include <linux/serial_core.h>
> >>  #include <linux/tty_flip.h>
> >>  #include <linux/types.h>
> >> +#include <linux/idr.h>
> >>  
> >>  #define SERIAL_NAME	"ttyMPS"
> >>  #define DRIVER_NAME	"mps2-uart"
> >> @@ -397,7 +398,7 @@ static const struct uart_ops mps2_uart_pops = {
> >>  	.verify_port = mps2_uart_verify_port,
> >>  };
> >>  
> >> -static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
> >> +static DEFINE_IDR(ports_idr);
> > 
> > You forgot to call idr_destroy() when your code unloads :(
> 
> Hmm, but code doesn't unload since ce87122911f8 ("serial: mps2-uart: make driver explicitly non-modular")
> or I'm missing something?

Ugh, ok, nevermind, I missed that, sorry.

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
