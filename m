Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB867C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57952087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RSPV8B2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57952087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xu4ApqoZUgvjEwb+brUDYwTWW8E8rdw8GZbGcxpbK30=; b=RSPV8B2W5D8/jNYBcooKxwQpb
	/hK40cuUKtkbS2z6PDlpYNIR3Yh6bM52PyoF6zyfvBnjE4TrOkOFYdN1vi4HYldiKh9JvSVyJv56f
	m86pOK7utwX4bQz4JkFwfhIZjwXlAi1rHfHRVoo4DdRzqjUg47prJ26lTabB+j26DaXZit2wF4nIR
	bI8g+eqxBTo4UfsdTO3h4i5xVwFgKP1NS/FDwpJC3Q0JCwmpD3fWpW+i72dIpCh+LrzhPTT8wQl5R
	IV8sJ4p2sDOyUzG0vl/cZtP1eGUVe2MuSVCMQpzgX6+K89+d65GI5xsPJHfy4SiOj63qtVkhFudbA
	ngJ7rzZ4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotyk-0003if-ND; Wed, 30 Jan 2019 17:48:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotyc-0003he-RM
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:48:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E0CE80D;
 Wed, 30 Jan 2019 09:48:42 -0800 (PST)
Received: from [10.37.12.221] (unknown [10.37.12.221])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF72C3F557;
 Wed, 30 Jan 2019 09:48:37 -0800 (PST)
Subject: Re: [PATCH v2 4/7] perf pmu: Moving EVENT_SOURCE_DEVICE_PATH to PMU
 header file
To: mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org
References: <20190122181144.26645-1-mathieu.poirier@linaro.org>
 <20190122181144.26645-5-mathieu.poirier@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fe640760-89b8-7ae7-f742-a9f81642d0e4@arm.com>
Date: Wed, 30 Jan 2019 17:50:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190122181144.26645-5-mathieu.poirier@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_094847_279745_97A45BA5 
X-CRM114-Status: GOOD (  17.42  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com,
 ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/22/2019 06:11 PM, Mathieu Poirier wrote:
> Moving definition of EVENT_SOURCE_DEVICE_PATH to pmu.h so that it can be
> used by other files than pmu.c
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   tools/perf/util/pmu.c | 2 --
>   tools/perf/util/pmu.h | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 11a234740632..51d437f55d18 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -29,8 +29,6 @@ struct perf_pmu_format {
>   	struct list_head list;
>   };
>   
> -#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
> -
>   int perf_pmu_parse(struct list_head *list, char *name);
>   extern FILE *perf_pmu_in;
>   
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 76fecec7b3f9..350c54e0bd3d 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -16,6 +16,7 @@ enum {
>   };
>   
>   #define PERF_PMU_FORMAT_BITS 64
> +#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>   
>   struct perf_event_attr;
>   
> 

FWIW:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
