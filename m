Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E987C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:13:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA4920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YxTnG7Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA4920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6iqcSNRvtARIetjZwYraTrsnQWYbIJ13AyABijw19oQ=; b=YxTnG7FmN6Km5Z
	8hNUmbjQ43NagGh2zFODr7ZadyjiUIwT2I7q6l99HxEHhIDQfYOM4SDUQgm5B1+yM39F0ynvN4lKu
	HzwibbL1rJ0lost0yoLHxA6jlDB3HpShS2DFtHcQTtD9qoOnGoDzZr1NNw+Ag9IVYC1A/v5jUfigd
	tpUtzZoGi/emeN2syU58f2WejtZkgCBCYmZ07LwnPIatDwmyyNZxbZQ1iFkeYEXmcNy3oXDEEpWL2
	dkkeLi3K2tVccG83wsXPodGnzvw9IKMibOlkY0MJTZt7AZkIqbWiZioYxjUimIUaj6qORrf1WZUcZ
	Kh2kFIqg5ap+leHOGbvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmxXx-0002KP-ST; Fri, 25 Jan 2019 09:13:09 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmxXs-0002Ia-5i; Fri, 25 Jan 2019 09:13:05 +0000
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so7770632ljk.3;
 Fri, 25 Jan 2019 01:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LQ44fZmqYtGeW5F/n2jrFDteHxp9GGkSJWCW+fdudJ8=;
 b=FcTYdKxU5c8Lrxt2ArryDxPgrGChgwcYWJqtGUYIc4BjJRI0ltkuQ+EpV4Xn/6/5u2
 5RYvH9XIE91qF9k1IyBFW2mkP80QrQHvpwTEJsKwpvx0XiDt04X5/3wNchuytt8/Pwk4
 XdSLJzYRoLht7Kuhbf2l4+K6vn9E/bH7VizuOprfJC/xy6lxcqbkmoF2p6MLRGAkSKa2
 FtIR3yMRGVYHEVG0LL/mrQcZXR7Son+PWYgASilbxPMPXr62O66JcCy5bS7FjrMfqdRr
 1/oIKrdPV2SwXs3hsAYeR7MY1S2V1leR4GP2nqP0ssEQY+SesV6DxuRgzRXVuHR6G4DL
 aMQA==
X-Gm-Message-State: AJcUukfy1ZfjMqVeZKhqhrj3GQ1nAt+bxpG8h/vruIjEOWD5FgXauCHT
 slfjxyJsBQKsX1BIZtwDDuw=
X-Google-Smtp-Source: ALg8bN46wgzeffg+A48b2CVK6j+VylLkMph4ohZEx0Aa+pDQARjUIwYBp6sKuFbjkO5jI7xSVa4csg==
X-Received: by 2002:a2e:2d11:: with SMTP id
 t17-v6mr8401264ljt.159.1548407582221; 
 Fri, 25 Jan 2019 01:13:02 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se.
 [85.230.190.116])
 by smtp.gmail.com with ESMTPSA id 11-v6sm1379976ljv.1.2019.01.25.01.13.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 01:13:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gmxXk-00087N-V0; Fri, 25 Jan 2019 10:12:57 +0100
Date: Fri, 25 Jan 2019 10:12:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v2 3/4] gnss: add mtk receiver type support
Message-ID: <20190125091256.GC3691@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-4-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547744074-28308-4-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_011304_211787_2F003222 
X-CRM114-Status: GOOD (  13.54  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 05:54:33PM +0100, Loys Ollivier wrote:
> Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.
> 
> Note that MTK receivers support a subset of NMEA 0183 with vendor
> extensions (e.g. to allow switching to the vendor protocol).

Copy paste error? AFAICT there is no Mediatek vendor protocol, only the
extensions to NMEA.

> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2: renamed from GTOP to MTK.
> 
>  include/linux/gnss.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/gnss.h b/include/linux/gnss.h
> index 43546977098c..36968a0f33e8 100644
> --- a/include/linux/gnss.h
> +++ b/include/linux/gnss.h
> @@ -22,6 +22,7 @@ enum gnss_type {
>  	GNSS_TYPE_NMEA = 0,
>  	GNSS_TYPE_SIRF,
>  	GNSS_TYPE_UBX,
> +	GNSS_TYPE_MTK,
>  
>  	GNSS_TYPE_COUNT
>  };

Add the gnss_type_names string in this patch along with the define.

Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
