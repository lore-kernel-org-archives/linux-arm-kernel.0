Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF345C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBF9218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="akSkML1B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6XQ/Dwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBF9218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LEYtM9N/GKbgB5FZXR9XXwLggINOV+voJQErFXa2d1c=; b=akSkML1BuPRLVf
	yZPGStxpW+owKXQybKGAzpBIhS5T5i9rKk9QTO1FvAfRN8vrfPrQkeyaks++ApFdE9Yqv8usuLuOu
	cs1OB6ZvUTT/zSWkJYIAMewy6nlnuhVl3npTWgxc2KsQskws9GrusjhCQRwoIjdRZuB5kimZ+fMbf
	2uwSzi1GFsBJfgAXNcj80HXdLvNQTqam11/mi0Xi/dGW0jt6z7nhhXtJpsgv0ulqhW7GY+KSetK4k
	5IqT8RdIoGhFmb1BUnipEpDmNkreQZkVpzLoJgZdDFwETSNG2YEWt+wSxcdo/dFaOLCiMH2SOA0zb
	XvVOyuyRyAkvDm7qzkxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmaHe-0005ZG-Da; Thu, 24 Jan 2019 08:22:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmaAu-00021O-Aw
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 08:16:06 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C60B8218A2;
 Thu, 24 Jan 2019 08:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548317747;
 bh=ack29QH4xqRdXg+FVs9les4gl/Bcp4LrSb/D2S89Qf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G6XQ/DwkiqVqjaAYRHADEzoPJ6HbUR1abxElBsQltof83rQv4Q4/18R4jju1F+x1L
 o9I0TtSQSwSbge6XiVim1GoQhkJTeTuwDzUQg7rXFIz8mJFwy0vGKZoChJu62bjLFp
 6oPp0YdpsUbxQUma27u4x06Ysf4A4uj1vyLmycVo=
Date: Thu, 24 Jan 2019 09:15:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vijay Khemka <vijaykhemka@fb.com>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Message-ID: <20190124081544.GA1649@kroah.com>
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190123230634.1815021-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_001549_266713_0D35B67E 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 03:06:34PM -0800, Vijay Khemka wrote:
> Corrected some of return values with appropriate meanings.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index 332210e06e98..97ae341109d5 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> -	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;
> @@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  
>  		/* If memory-region is not described in device tree */
>  		if (!lpc_ctrl->mem_size) {
> -			dev_err(dev, "Didn't find reserved memory\n");
> -			return -EINVAL;
> +			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");

Why did you change from dev_err() to pr_err()?  You just lost a lot of
information that the user previously was getting from dev_err() :(



> +			return -ENXIO;
>  		}
>  
>  		map.size = lpc_ctrl->mem_size;
> @@ -134,16 +133,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
>  			if (!lpc_ctrl->pnor_size) {
> -				dev_err(dev, "Didn't find host pnor flash\n");
> -				return -EINVAL;
> +				pr_err("aspeed_lpc_ctrl: ioctl: Didn't find host pnor flash\n");

Again, don't do that :(

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
