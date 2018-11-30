Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5CC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE6620660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jam/qWuW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="blcHFeX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE6620660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/i1Y7B54MC4LxOV/hWZHs+i6jDF1yznakhTQqyScFlE=; b=Jam/qWuWApRUxp
	aBE1+kHk/258U6ZUn6Vccu9Sdkywn5rNFwER6a+/jg9TIf2EMNkWgFThNsrqOA+O7W4gFaWV+SP86
	uhFWrAOZ+zg40rGSAtMaTRNaWg8hUQthesVM+dTXHCGnpjNqudgkdYnyyS92zGRS2AKu/USuXSSiF
	coDpmyphORaTenWiwFLN/vvXbG4lKwdJg3H4D4FY49dOzRdchWzNbdfd1xcAt+tSOc0xtAgLzcWKk
	igCqlnQvKg2lCF8VGDllm7CfqDKZuP24XTIsmDFEoJsKKl46mrxMV9KUHh+rO9b/QGESKVRF/kQvk
	tHB/EeomxfoMGhZDoFEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsev-0002Tv-Kf; Fri, 30 Nov 2018 23:57:21 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSseU-00023U-2g
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:00 +0000
Received: by mail-lf1-x142.google.com with SMTP id e26so5349316lfc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dAYI4KyhnvqXkFgdjqiJWThf+63O6HKZ7I4pZknoanw=;
 b=blcHFeX6tDzo9oQyU4LqLvDuir87okX1xMdBlyvQAbXip7BsCW21YOeGbf4XGLfcTU
 /HkgszVtCgNIErV2KkyNkDECRbddhAIIi/zwFKeNbBogZAqdrr7YjxQrgL/HJU9QGQSv
 ZzzBYaAHLWyh4GSKfs/ZMcv2aqFGmqruMn9h4BXrDe7CXtJckFxHt2Lg/14ppn4/GloP
 S79lsunX2UrNJUa5ZE7QZkwIMelPX2s7fNRwy5gYH6r+OarWoPV9yAnp6NiNi7dCZ7nX
 Iiw50ApdBwof8miXbjxC6wU9DeWlJQdQoyHmsSlToJqc2Smj8fOa/JCT63tHxOg6hJWq
 N/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dAYI4KyhnvqXkFgdjqiJWThf+63O6HKZ7I4pZknoanw=;
 b=TQz/FIiqSgp0k6UOR1g7sTU8mgZQ0a0FOGieJiV6FFoqc6GBEF6pfORGjwOwrfujfi
 NwGbrSjguBlvHVnOcdEiYzeiFjuIM7qx/Gw5SwqAOMR9JDtQIu6PsQhLu43wS4Syjf1a
 hn4ssrkCd8pO9WNhnyOBBOzCfSv465eY1sHZNaqXXmYgTr4OPb6Awr+HjTuStPM0f45r
 UdeKpqkkbNHbrMjmnITvEfLGOeHXqoJv9vYHpxC5bd/1bN35Ps4roet1bHBJB5w8BEmA
 M5SsEZG5xTSHG0quL2NLF7d4/4WyQve2/BQLt4llK30WjzvBIk8WfC4+4LIreipsJWQc
 T7Cw==
X-Gm-Message-State: AA+aEWaMz588EoaKg3I6gc0u4NEXsNo9fMhLR08AllMj0nCnmSqUYgzE
 ZZBQo3BHC2tNG/Isce1gdB7GYw==
X-Google-Smtp-Source: AFSGD/WH+OjoytO9KcJ63eLT8sHh4MKcJp7zEnjugBCgorCcM9zbEEVflhIiahcw+MSnmAH4mGkZ4w==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr4571981lfe.127.1543622211049; 
 Fri, 30 Nov 2018 15:56:51 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id g4-v6sm1045747lji.17.2018.11.30.15.56.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:49 -0800 (PST)
Date: Fri, 30 Nov 2018 15:10:45 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 01/20] dt-bindings: mrvl,mmp-timer: add clock
Message-ID: <20181130231045.alnf4amcvog6zxfg@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-2-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155654_164520_AC4811AF 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:05PM +0100, Lubomir Rintel wrote:
> The timer needs the timer clock to be enabled, otherwise it stops
> ticking.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - Made the clock optional, to keep compatibility with DTs without it

Applied, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
