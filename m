Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90221C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:45:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503A5206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FI5FuirP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503A5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wJc+0WwKrilzHsHYuuapr59CSn9CKzS55iKIpRMKeU8=; b=FI5FuirPQH/bHl
	0XMdvqtkIU7RiwXpQUETPdD9pQmFgqrDSU04tPy+WohRtwF3P6dsesCWVT9ijUOiemXMxk7QN1xGC
	uR5+0/L4dIYZ2oNT4dD2WkEMMl9LyPu+pT9TTQ1eAPOqgl9yqpWWk/1L9nS3dvu9YumZj5Sy1PtdD
	zPXZ/r/y1g8d3ltoqc932x9rHuVjjp81qZFrbEpeHlsbiUE1eP4vHUdT3phv8oloVaWaBP3u2WFs2
	8V+e/I+ebF8QBYC+YrcMjaTGNFsXMMKzV3O74lAZiAqiQeldQICJgpOR51LWzDT/nrnpuy8UL6hcy
	rEWYvfpztYuY9j4iL2YA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxLR8-0001JZ-92; Sat, 23 Feb 2019 00:45:02 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxLR4-0001Io-9I
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 00:44:59 +0000
Received: by mail-oi1-f194.google.com with SMTP id z14so3206253oid.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 16:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5yCkJsFM9EH0Kw6t4rfJCwN2CCCyMGusGK5MqBJDYhU=;
 b=B2q6DdN5ziv/fjjlc0X0UZvA5DKaJ6/kkYoObo6kj3+Ps9KBzbQrMef4DrEzcYmyrA
 sTBAV9YJuid2xsc4Gf+gTwHsHZAiJpWF9xVN6qLYJc6M3UfZUPQnnGyLA/1MXpd5GbT/
 zKCPCp6DjovLkKf6OxFPR5kqcEvH3411j5QlwHUG6yS2K03DwTeXI6A2UKmZe6BOouAr
 IFrxD/aXZpEin3shbTu5kHP2LY+f2S6xujLw0oxxbiMosnhN1pNL/Wh/tPvqTvmeP5xG
 gior22SXzMUB5mkHMkKQalyZbeU3bE6hD1pS3J6pyJZ7TKGZBZhVG/PGbeJgkEVhQ1ep
 IsXw==
X-Gm-Message-State: AHQUAuYND14YMFPFgsSF8PZPQzgxEofVSeDuMz3QuijtAkfq9wpC7/5V
 x6uN3DpF5+3VR919Y5tckQ==
X-Google-Smtp-Source: AHgI3IYAbqAlIYIwOyD6Z5qaxoa8MeMQMajoUev2NiXSsYOoGwVMZUSLbPY/Doz8uFWijhqOIQs56Q==
X-Received: by 2002:aca:b354:: with SMTP id c81mr4325957oif.26.1550882697314; 
 Fri, 22 Feb 2019 16:44:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d11sm1194861otp.18.2019.02.22.16.44.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 16:44:56 -0800 (PST)
Date: Fri, 22 Feb 2019 18:44:55 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: qcom_spmi: Document pms405 support
Message-ID: <20190223004455.GA8453@bogus>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548675904-18324-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_164458_321552_F5D8ECEE 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, vinod.koul@linaro.org,
 linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org,
 niklas.cassel@linaro.org, jorge.ramirez-ortiz@linaro.org,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 12:45:02 +0100, Jorge Ramirez-Ortiz wrote:
> The PMS405 supports 5 SMPS and 13 LDO regulators.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
