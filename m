Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD76FC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:42:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2C720851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mupyP7bp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UppuU56p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2C720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9EmtamG5Z8yf2nk6GuOPj6QaqR5va/jwTqfah1xFEeU=; b=mupyP7bpXWAMHX
	DbsB4BbKpOfNg3Z6aVB42h1a98dXyaDOCTPQS06pPxH/A6MWkHOkyumkA+Yv6rIc4uwtgp8pr7BIm
	dcQU34/LtmRIREeT8wdCdiZwx7MKEkto9o6RUGaNVCdq7vw0cKPsbyJY6OoPgstR5Pq7JPyIRke0R
	GqaMrkGwB/Z1amupb4EhCUfH2iy1Q31iMwHO5q4Ye+8z3nH1cLEsvyNnPCeHvtBK/Zs5aetRl6tMM
	PcPczynkklgFBmGe+auSpwGrFwfIbXxQQVd+Vzivs4XH+9z/L22hJsB5uC3BNzr9mFa+blLSPcrjP
	U72yCOvEIgNbiDQlS/aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9SJ-0004Ya-5v; Wed, 12 Dec 2018 18:41:59 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9SF-0004XK-IL
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 18:41:56 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so9298504pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=efV+QfoYMImiv+O28VK5AtKXQCgSf0+gFBOPIfYpmfc=;
 b=UppuU56prMVuXoaYyGWrtmaIomyrJ9Rvwa1lOcUAiJ2emzlFxhOIcTod2wLW9ZdpoX
 YeTMVDPPLWtJoeF/IqU5941+YOkDA43wk4FwOe+zYkrxhLxhVsDRPA7cXV+Vf70Vn+qV
 Koy7chXleyoNG0h0iSB515sO6rsBaZ5tVmCMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=efV+QfoYMImiv+O28VK5AtKXQCgSf0+gFBOPIfYpmfc=;
 b=qqWoP3QiyRmzMB28QDI8DXnO3KrwR4tbKmyZtrqIEKBpci2rk1G5kgUHdwdBUGYJu3
 Vfc5yoVMpNJRpCws5unq7ss2HwOKUuOdzJFape1QqI8GFnEqUV1la0cTSgw/Gkyq+UAi
 8BgXM4ZsCPfg/RjIRv0bUDvW1iE6YwQ4d4GRdW7CMhuQihCD7vszM57kjDQeu7lhXHS4
 8jc4/V9tQ+0T7HcH4nZthYKqFNM2K/8ROh1qqnPf8pItNCaZMDKLviBJU+neCJ26pCQ4
 g2kUoFrSt+/9KqQu92KAkbc5a8Rj+yITCwkd1MMsUSbB+0RuSDWCsf9twqCClQj9UkV+
 Aa1Q==
X-Gm-Message-State: AA+aEWZaMIi5hc9/0KNBsUA9ir6CQqmN8uzEx7TWSToaajj8LQGMyutp
 8skHiY1yA8UuhNSukYt2OF1sNg==
X-Google-Smtp-Source: AFSGD/Us00OmxZhZYqPcCXCaFK21WwTMuxmQML5yOPVXNj9SG1y9T3G95COi+I0cHJn3FZ+rjynVjQ==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr19034125pge.346.1544640104757; 
 Wed, 12 Dec 2018 10:41:44 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id y71sm43270324pfi.123.2018.12.12.10.41.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 10:41:44 -0800 (PST)
Date: Wed, 12 Dec 2018 11:41:42 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 4/8] perf cs-etm: Refactor enumeration
 cs_etm_sample_type
Message-ID: <20181212184142.GB24556@xps15>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_104155_604987_D6A99DC4 
X-CRM114-Status: GOOD (  17.53  )
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 03:38:24PM +0800, Leo Yan wrote:
> The values in enumeration cs_etm_sample_type are defined with setting
> bit N for each packet type, this is not suggested in the usual case.
> 
> This patch refactor cs_etm_sample_type by converting from bit shifting
> values to continuous numbers.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index b295dd2..3819a04 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -23,9 +23,9 @@ struct cs_etm_buffer {
>  };
>  
>  enum cs_etm_sample_type {
> -	CS_ETM_EMPTY = 0,
> -	CS_ETM_RANGE = 1 << 0,
> -	CS_ETM_TRACE_ON = 1 << 1,
> +	CS_ETM_EMPTY,
> +	CS_ETM_RANGE,
> +	CS_ETM_TRACE_ON,
>  };

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  enum cs_etm_isa {
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
