Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C75C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152A42086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TKUBHvBI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQ/8yQFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152A42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uh6vPeXrK7vdWU8lCp7pX9nYrCsR1aJzjZy1EbMpCug=; b=TKUBHvBIurmdRN
	WrQAvTOYMv+5B7d/1zlM26YQLAp6tDd5BsQ80et5Wg/78EUT55gDthHs/pt9TqaKD9wri8mQjurS1
	W/xZww55MuNKbXaNboPUwCAe4SRPFu9sAOf+Agip94FG8ohtQqzUtt9e1cT9t2/Ue/6DeKAzJFFSz
	R+vK+eU5KNh8b7tzq4zT05Gk3UQLmuMHGhL4nvHFBNgpLtHq3ODUM1KPCK96rfp4ki9xQhMjTFqQ6
	3nYflRDUcEo3irbivgAp8K20PWLzKz8qktpRCW50FuduM+UzSbQlw1rjtfOl2YoyLpGoK8K2LAnUc
	KHL4ayq/uvXw6jQboOlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWM0G-00032K-Ib; Mon, 10 Dec 2018 13:53:44 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWM02-0002l4-Hr
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:53:33 +0000
Received: by mail-pf1-x441.google.com with SMTP id b7so5433316pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xYkuV0k8aBBeyyBaATPTKd/YixCx26NfJlDybN3AfPU=;
 b=DQ/8yQFFgOLJajz3T9XE/oiQ5JAzwHBGCRgvnrhldOwbhDkGb/+V19hy3dCELu6zcp
 xa369bg+/uuE2bZj69zZwyd068dtpuRk4i8z1z4LXuan2SqgjkMWPTbEVHNY2oOMds0C
 1y0xzyjiTQPWbn8Gzg2adQ2zjMMjENeFyPvRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xYkuV0k8aBBeyyBaATPTKd/YixCx26NfJlDybN3AfPU=;
 b=JOYIGxgaKRBu9iG6uNtaNMPXn2allL49RVPJS3oUELlFjyQYF3/s5W8SdI5e763KmL
 mVYKza/9Xr24uQkAYxfUpeRN7HGTy+YHjtxJKfUpelhPwhH1xZhvPe3EeqYk0BoF/2FX
 4T7FC6NE3ZyhkjlO5VzU+en988QybN9CCy3IvxX68IZ9KXJIWnXi/9ZHGL2edvUk5BG8
 7oUcMLEUPcbuS9/MX0vNHVG1fa4KnZmJMhuAWvIhyhNbrnQ3rkGKo2X5MrWv7nkl6VAH
 MlYbTo3IFSFAOyuKcimkjbubmCuhRXGsLp7xJ2Wmf3/Tb1gBri2ZFp1dDlN1TSCuvuWh
 tKcQ==
X-Gm-Message-State: AA+aEWaJcazRi0uDbWkPa+rCFje+gZaK7h6ZJNTBFTchjW0VSN1AfU5a
 Vgn0qiqL8GCFUWK5dbk+IpSj
X-Google-Smtp-Source: AFSGD/Wt9gRb0DhY+iLQ1M7UOj8U44kU8/3yaK9jSLAB9nMUjtht8RCP/ez0PhQucquiIZ5nClEquA==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr10872025pgo.221.1544449999806; 
 Mon, 10 Dec 2018 05:53:19 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id l3sm20824651pga.92.2018.12.10.05.53.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 05:53:19 -0800 (PST)
Date: Mon, 10 Dec 2018 19:23:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v2 2/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Message-ID: <20181210135309.GD25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-3-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-3-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_055330_851051_99ACEF8F 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 wsa@the-dreams.de, linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
 robh+dt@kernel.org, linux-i2c@vger.kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 07:58:19PM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
> 
> Add Actions Semiconductor Owl family S900 I2C driver.

S700 ;-)

> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

With the change in subject,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Cheers,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 96b4572e6d9c..b6b5a495118b 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id owl_i2c_of_match[] = {
> +	{ .compatible = "actions,s700-i2c" },
>  	{ .compatible = "actions,s900-i2c" },
>  	{ /* sentinel */ }
>  };
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
