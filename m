Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51FC282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:28:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8275B2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s3gvKP0Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="McQ1Jr8K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WweZED8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8275B2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zlzn3GRLKcTGHORZtJ/aZtHisEtIfTsBlRGpSHkH2g0=; b=s3gvKP0YF0ruvL
	PqoyRvxC+WtjBGGXXbCYIYNnanZGNFiOS6sqKGoyjnicQWKrODNxVCsgLEUOZ9gamg5Ov62C2NsjS
	28LOKqO5AnO/DIeHlCSEcBYTUt6sgv6lBdMhS/g712B69LIFcgnCjDZ4wSpbzOuKcgIGzMJ4TfixQ
	3I6UPghN8h2zwY6fewQwTiaqXk6tTnikQ4Ko0ODjHnftcb0oE+DgtogXSb3s7d4iXnoN7iLRWFTd3
	5MVtQaLnIFCJ/WwazmKHQkuaua0ehZK1U1YJ/YKVh7O0zbqf96jk3iduhQjsry6xHeYZ9no58i8A6
	/t4WYAfY4lUwRdEhqsdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golE7-0004ov-EC; Wed, 30 Jan 2019 08:28:07 +0000
Received: from new1-smtp.messagingengine.com ([66.111.4.221])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golE3-0004oV-I7
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:28:05 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1E777111CD;
 Wed, 30 Jan 2019 03:27:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Wed, 30 Jan 2019 03:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=nOsIvOqTKsM8xzo/s3irTb5fNnL
 NZyGzY8aLF9fek+w=; b=McQ1Jr8K038V8Vm/0tFnIxw+nG+G3AICL1QZiFj9UBN
 NQga+3IjLc6BVaN3pBlkZOpu2ozxcMbtDXuaRjTpwdSjwQKlgDrIuY4O2sxiJkBr
 WEdg9l5UJaUAxJRu5t4akEqB8g2C1t3c15H1Gg3MrU80rcUM92kv3Q7cFQbWmrEK
 KTMC3hEGsWWRJ+8u2Rn8/kBjxrRtQUM0rkmKSIDHn4rO6RZ6lzuzdmbRlE+jjz0S
 AHfdWPAsQXS85Yor9CrhPAoJ5teb1jJuGwl+2ywkTtziDlZiLtIoq+FzdpgXgY/+
 J1thumvEYnJcTQX3MgELAUfvYm3HMuzIPEbtoElpnmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nOsIvO
 qTKsM8xzo/s3irTb5fNnLNZyGzY8aLF9fek+w=; b=WweZED8aa1wYV+gb+OapNz
 qHfcDIdCjqT9R2b+ulUt285xh9SA6We0LHxzp7xhAQnoBpw5g6Sdo7eimpGWf5Ol
 uwcddFmeuk5o3M9FEm1/1A9abZdBZHOgwRZybTLIgf9Htm3IO5l/SGaFYQ4QTEoU
 KVo9o7AhAHJaWBgxTXETWHohB2G9gkcjeOjB9+PSML8hPU7X+QTlSrgLZG6/Mdk2
 jxRedOmYM4bLmxlM+irpHryVffv2aN+h2o1etY5lhL1SozAG4V2IGoI1yqc77xFn
 zdIe5pI0DbOZrx0wC7VJbOrj5d2z3s0K8mv+oAUuOjyKDbMKQd1RIRiZCvYK41JQ
 ==
X-ME-Sender: <xms:C2BRXKbjC88jN6YWKHOIHacNyqdqn_HT3YDmM4q-R89b317BHvwhOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
 tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftd
 dtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefi
 rhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrke
 elrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
 mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:C2BRXF1sYvDzpfXRPUZFHpePgy0rmPGCFVMvII0GAvr0SNIlPaNaIA>
 <xmx:C2BRXFYh7Tait-fAdFIMt9hcSqdTcp-JKpJINX8pmRtRJY-K22lUBw>
 <xmx:C2BRXNJEqCRbVVZt3oQJ6RycF4A-CI8yJerRF-Mbm59V9YZ__EyXvA>
 <xmx:DGBRXFVNtuLYlolbBYLjGqoMwotXz1nZKeAuCd5SUr56frHiEB69cA>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 by mail.messagingengine.com (Postfix) with ESMTPA id 46971E4651;
 Wed, 30 Jan 2019 03:27:55 -0500 (EST)
Date: Wed, 30 Jan 2019 09:27:53 +0100
From: Greg KH <greg@kroah.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 1/2] serial: mps2-uart: move to dynamic port allocation
Message-ID: <20190130082753.GA24317@kroah.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
 <1548425597-38175-2-git-send-email-vladimir.murzin@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548425597-38175-2-git-send-email-vladimir.murzin@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_002803_912162_94328836 
X-CRM114-Status: GOOD (  13.63  )
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

On Fri, Jan 25, 2019 at 02:13:16PM +0000, Vladimir Murzin wrote:
> Some designs, like MPS3, expose number of virtual serial ports which
> already close or exceeds MPS2_MAX_PORTS. Increasing MPS2_MAX_PORTS
> would have negative impact (in terms of memory consumption) on tiny
> MPS2 platform which, in fact, has only one physically populated UART.
> 
> Start with converting existent static port array to idr. As a bonus it
> make driver not to fail in case when no alias was specified in device
> tree.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/tty/serial/mps2-uart.c | 47 ++++++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 9f8f637..6da0633 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -22,6 +22,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/tty_flip.h>
>  #include <linux/types.h>
> +#include <linux/idr.h>
>  
>  #define SERIAL_NAME	"ttyMPS"
>  #define DRIVER_NAME	"mps2-uart"
> @@ -397,7 +398,7 @@ static const struct uart_ops mps2_uart_pops = {
>  	.verify_port = mps2_uart_verify_port,
>  };
>  
> -static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
> +static DEFINE_IDR(ports_idr);

You forgot to call idr_destroy() when your code unloads :(

Yeah, it's not an obvious design pattern, I think someone will fix it up
someday...

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
