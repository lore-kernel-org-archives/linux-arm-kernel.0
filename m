Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1F1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:15:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72C72145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="agQ5XdS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72C72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ICHs8y+NcpcruCooXZHJWibkEc5N5rzWt0qqRJVWJQk=; b=agQ5XdS1imXHD0
	mMbuFrx6qpOaYxYaasTLKOmP4bMZ5jFnH6oo3j7c0atuAky9ThARuaD24WvKiBAjpBsz5oGau+f2n
	5j0Kv627qgXqhRvMXYoPR+B7grnl4/QIeFf8q13pkvQuNEjNlTpaHbM4F8q0QpYlzfZE0Tfdl+bZx
	bphe/gdLv7W0USpfluTLJvTMMn8ZiBimjA3n2/ZTPr9u2E22AnVR6mQm8IjWeAH+5kA38Ib2uQxGC
	ND+CRApk16yBeLuiyuXqIF2xHknL5GHA7jvv2GlFbRwsb179YVHoFHuoQLBPO2vAyUEu/7f7pT1Dx
	Ji1xaGSOTrwCn3oWv21g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaxs-0007Oo-Gc; Sun, 02 Dec 2018 23:15:52 +0000
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2
 (Red Hat Linux)) id 1gTaxq-0007OP-ET; Sun, 02 Dec 2018 23:15:50 +0000
Date: Sun, 2 Dec 2018 15:15:49 -0800
From: Darren Hart <dvhart@infradead.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 07/17] Platform: OLPC: Avoid a warning if the EC
 didn't register yet
Message-ID: <20181202231549.GC23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-8-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>,
 James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>, platform-driver-x86@vger.kernel.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 05:23:53PM +0100, Lubomir Rintel wrote:
> Just return ENODEV, so that whoever attempted to use the EC call can

I think you meant EPROBE_DEFER here, but the language in the commit
message is a bit ambiguous here...

> defer their work.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - EPROBE_DEFER instead of ENODEV
> 
>  drivers/platform/olpc/olpc-ec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 35a21c66cd0d..9ee993d5d54b 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
>  	struct olpc_ec_priv *ec = ec_priv;
>  	struct ec_cmd_desc desc;
>  
> -	/* Ensure a driver and ec hook have been registered */
> -	if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
> +	/* Driver not yet registered. */
> +	if (!ec_driver)
> +		return -EPROBE_DEFER;
> +
> +	if (WARN_ON(!ec_driver->ec_cmd))
>  		return -ENODEV;
>  
>  	if (!ec)
> -- 
> 2.19.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
