Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70869C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9D521B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lYwqWAxY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn2XQv/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9D521B69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dkp2OYvX3+G3s+P1e/flgVOmcyMzW+7V3xw1e2W2SSQ=; b=lYwqWAxYH7k+bU
	/R15lzzvJylg9V5L96G5XMpKbIPneX0Iubbs+Ib5kKGBgiRuIuVIB1iRo3CKp1CnF/gc9qW+ZNba4
	7esu/XctKGnfPoN3widmoa6Ais8JZSZn/jGceY+YCZI+F2bZkPcQOokmNpVNcuCcZ+p4juhhI0bHy
	rhnFAZ7/IPk7BBKlT4KEW+cPlV/68zUm+z67yLm7RpaRoxA0RDATEAbqWr0PcwAFJPQFYaQDZtDyR
	1B4Eh/KAFManzJo2TYFfTbwmgJYgGolmKV9fwvsGi46/L3bVF79k8Elm9iVM2h6a7EUxUmLHZ2mOT
	K1B1l3OvM9ZhjEBU6yug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvEyR-0002Px-82; Sun, 17 Feb 2019 05:26:43 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvEyN-0002Pe-JI
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 05:26:41 +0000
Received: by mail-pg1-x544.google.com with SMTP id h11so4466245pgl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 21:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xfnRCat7M1mkzZzhlFs9ZZ5CDTR9Y8VW/uLrQG/qHF0=;
 b=gn2XQv/erYDPT1dJbK+jMKWSDHSRapRGVGF2ZW8pEnKT6Bb0XwABc9i5/jh0HniZmQ
 Y7jsaY6FYDOPPwxHdDViKkwkJnCFV1z2JGw0Asb9jTNXbfqKnmL1S+1LrXDxcO0Emz77
 iehBcbIFxrD+xbpHUGjRabxMkdh5uEGaFavVXAyFlHaX+BmAiX+A1dQyEOoINQzLXshj
 YGVZRRnQjY/ZisLdgV3VZoPemul/qeIGTGC0DD6pBS9grbDC0EZFXm/FQcKrLQx8VJNY
 1yHVRHfHvd/ixtvDm1464s5oWsJWWNVaVJZ1uKWV4jT4SCNzzSeNUlsJD3y82U3A1oe0
 A/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xfnRCat7M1mkzZzhlFs9ZZ5CDTR9Y8VW/uLrQG/qHF0=;
 b=PVhao7VReBunhzfJIcjIeo/Nb+vl35hqVmrv+VoVsd5dpouiGmvZ1i/472cy2NXvN5
 Xyog515e+wgf9JR8W5lT6LhFxSt9oNkp4J51gvA+qtZflsfs0krhiIufH8v1+s1wrnXu
 ziED+M34p4Sb7NGHnMHT1pvezcG9ob44og4v/4Z0vQ1a3w1D5i24jO/OTxKSXll6srsO
 V2HOjBpjo92FvNOZpXh9zOKP+Zu6pYS50+c+GZyf1BCJWY9y2GSnnR4bLJEOLzKdIVUV
 zuC6aMxTlsETvztdYyIfonunA7jh5hgnlsKT31+mx4EPWXmnJrHxyA/eGEelt2moauO8
 8Q9A==
X-Gm-Message-State: AHQUAubBs2wEhVI5Fw6UzWdRuD+Chj0dfwWL1zzfJv30MD4nsrUqcMsy
 F6hzrIjn4GHr0YW3tWN2b+w=
X-Google-Smtp-Source: AHgI3IYrlQY7K+I6VV8/JJGX/+sRRVxvoRhDe6awPZP0A4Ra4rgzOrdWJpRgeeMqc/ZBWbfB5ywzHw==
X-Received: by 2002:a62:2bc4:: with SMTP id r187mr17845355pfr.25.1550381196891; 
 Sat, 16 Feb 2019 21:26:36 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id p6sm9162926pgd.69.2019.02.16.21.26.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 21:26:36 -0800 (PST)
Date: Sat, 16 Feb 2019 21:26:34 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: gabriel.fernandez@st.com
Subject: Re: [PATCH v1] Input: st-keyscan - fix potential zalloc NULL
 dereference
Message-ID: <20190217052634.GA107793@dtor-ws>
References: <20190212153055.3925-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212153055.3925-1-gabriel.fernandez@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_212639_662792_1D79786D 
X-CRM114-Status: GOOD (  15.80  )
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
Cc: Nate Drude <nate.drude@ohmlinxelectronics.com>,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 giuseppe.condorelli@st.com, linux-input@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 04:30:55PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch fixes the following static checker warning:
> 
> drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
> error: potential zalloc NULL dereference: 'keypad_data->input_dev'
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/st-keyscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> index babcfb165e4f..3b85631fde91 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -153,6 +153,8 @@ static int keyscan_probe(struct platform_device *pdev)
>  
>  	input_dev->id.bustype = BUS_HOST;
>  
> +	keypad_data->input_dev = input_dev;
> +
>  	error = keypad_matrix_key_parse_dt(keypad_data);
>  	if (error)
>  		return error;
> @@ -168,8 +170,6 @@ static int keyscan_probe(struct platform_device *pdev)
>  
>  	input_set_drvdata(input_dev, keypad_data);
>  
> -	keypad_data->input_dev = input_dev;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(keypad_data->base))
> -- 
> 2.17.0
> 

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
