Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA39C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 12:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CD121A4D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 12:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKj2S32a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CD121A4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=co+E0jz4ZeoebH62mm7NV+e+haWb84AykCHDgfOj/6Q=; b=lKj2S32a63WBhb
	h/p2tDkM4EFQaOOyn2qV6HrTVek49mW9wrUytp89/jhBWCksaD+TXQvsKVeM4ReSm34vIcjiEswzp
	kCXktuwu7j8aLB2pBcUuZdxEd9NaIP78k4G/WsqMfbhXH76mntc6EKuHSj73VJh5A6whyO13PfNVj
	1sihIZ1LZz3x4nU7xb8C7ikXCqU3xehUMhQGXkAN32Nek7fvoS2w5SLfYgK3ZiBCYpvHKpdmH7eYu
	rrNKf1gM7kjp8OjATSdTMUznnulUwc+A0/H05Ff+p6f2v/ZG4WpLq74fUGxDoNDG2bxBRNJ4JAiIe
	no94f3tgouXadu34XsZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gagG8-0002O0-9O; Sat, 22 Dec 2018 12:20:00 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gagG4-0002NO-Mn; Sat, 22 Dec 2018 12:19:58 +0000
Received: from oxbsltgw67.schlund.de ([212.227.220.205]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M730b-1gSiQg2QiV-008XDz; Sat, 22 Dec 2018 13:19:37 +0100
Date: Sat, 22 Dec 2018 13:19:36 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Message-ID: <1941132339.131316.1545481176339@email.ionos.de>
In-Reply-To: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:/SDxGrIlfO2kzF/9ruzF2NeN+DYef9XUmTuHb/adAT3+o5h5d7Z
 LYkX+PSUTYFMn/2HBo9hm0PGaCIcTzvAP/OdSIwXVUxYGTg5avFljhwGKGsOwGnIgx9R69z
 tINcSlGsg0gTbkzRHyi2M+/hJ9wjW3lIbw64llk8xvm/LXDJkQWXFgmgI8X+lNDoye8of4Q
 wkACQP3QgYJzjNFNd3Rzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3nxzI8bB4fE=:SJ/K2kK9TS7d/LWk1jNs1r
 XtXEBfZJOaNL5CgzMCtZXM1juPd1s+gbDvdArsNa4uX6Xg23N38yp7DO0tgsT6iYf12DNZSwm
 Es610yd9zzIFdXZgfssENN6/oqyxM1n7nulAUbCp4c7OxinebTX+uBvbpQmKbtBaerOU1vYHI
 IuhslS3X0/1o8rTyXdCRX8VVXBa3slLxc4VkZ+thN/6l1V6cnfRPbTni+7eskIKVXRBB8YoJx
 ghzXUt3sFxxrFUJca+pwJ5a8A/Y5YmmvoyRD4YOamNTJPyazDQ2v8NxbZ3ar5EvDXcKN/jYkx
 e1biS8rqDcsPStP4Ucv5qQlrIKtc+6H+fjlEnjusW6rptj0QxEqjJfkfPK8/a3+FQs7BCnlcM
 0Zb3q0r6EbGc93/pWn1Q4hBPYttFlC2D3N69m9InKUbt2+q21aBoQFwOMohB65dvSSNTJXcqr
 N9sTMEjhpFHxXxJK4X0T/DEW2KBTs1t6LKxUQOAe002674GE4y9WqxVebpaGuNkMr/WOsdNug
 ZUtl2FMN0NIP2KkXeWvGd79IQIapet+3zZ0LEqq3bh2D8NJ73iXy2e/eMYDtBmV9B0ANhumub
 HXnnlYaTse32gg5nhsE1JZlUH/pvmJdE5Rei/kxI7Ttz4yTg8Nd4u+JSiSSXf+7aI92GXXWj3
 d6i0PPwSmfHCQ7F5hlVr16neUS/nUMpV/tKhiwF+Awn86q0h+ac74dDLMLbwKrovuDQO1cF1W
 33lnPXKNUr1vRfOn6+SB1xQRyF8Ng5YsmmlveQv/a7fblpE7Vkdsbsb851A=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_041957_048702_F657C632 
X-CRM114-Status: GOOD (  23.00  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Paul,

> Paul Kocialkowski <paul.kocialkowski@bootlin.com> hat am 21. Dezember 2018 um 13:11 geschrieben:
> 
> 
> The driver's interrupt handler checks whether a message is currently
> being handled with the curr_msg pointer. When it is NULL, the interrupt
> is considered to be unexpected. Similarly, the i2c_start_transfer
> routine checks for the remaining number of messages to handle in
> num_msgs.
> 
> However, these values are never cleared and always keep the message and
> number relevant to the latest transfer (which might be done already and
> the underlying message memory might have been freed).
> 
> When an unexpected interrupt hits with the DONE bit set, the isr will
> then try to access the flags field of the curr_msg structure, leading
> to a fatal page fault.
> 
> Fix the issue by systematically clearing curr_msg and num_msgs in the
> driver-wide device structure when a transfer is considered complete.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 44deae78913e..5486252f5f2f 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>  		return -ETIMEDOUT;
>  	}
>  
> +	i2c_dev->curr_msg = NULL;
> +	i2c_dev->num_msgs = 0;

AFAIU this would reduce the chance of a use-after-free dramatically but not completely.

Btw: Why did you leave of the i2c transfer timeout case?

Thanks
Stefan

> +
>  	if (!i2c_dev->msg_err)
>  		return num;
>  
> -- 
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
