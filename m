Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D14DC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:36:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575FA21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OLzdD2UJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2rYUEe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575FA21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5kwcNvpSFFH7aIdIBfJ5chGDA8wnut/9uZgPszKWLVU=; b=OLzdD2UJhz4oI0
	9j6CrD9RbM6fs3imo+32wLiRCeV1PmoR1sFkWEobKw9AgryB2NWybORSm/SDBZb6NVamCXdSWiS9y
	fuGnH+qf2pbYgCE9abu9xqYIlr5u1cvrY6yq4+OeMp1NeKldnf1Ju9Kv3/k9cn8G5RhXDZ08fb/sd
	nVYcmoCJNfByhToIXyNj1cGXLVFoPvxgNMnwTbsTJBbcovz4xlLqfM3XrJRz+3JreJUdb75NeVpdy
	m6j0WZTiyjClPfCSfFhqX07hHaVK7O4kLImRieF7yavS+MCG6YMD1yqQMSGCJmzFdy/wqXlYqNk6l
	GK23RtLSZs8IeCYILXTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmS4P-0003OD-Bt; Wed, 23 Jan 2019 23:36:33 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmS4L-0003Nf-4H
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 23:36:30 +0000
Received: by mail-ot1-x342.google.com with SMTP id v23so3592867otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 15:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QgTSh/+JhjfhoRAVqlJpbLvU8QVS+PcVDsomILGRKcM=;
 b=S2rYUEe5Gg36HKoxxQpFOyq4GGXWgwHD8V9Ce+qrikAh39Q6d81H4YGe53YU8dr/u2
 P77Nxq9BO9bin3GpLlu9Q8+foXiYkcGMDZ7Vea8Xp0pH37r5ZykAWVUICM4dupYZNikc
 A4GDWqvb25H/7eVRoDPcrsMmhNTIrJIUm0Kng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QgTSh/+JhjfhoRAVqlJpbLvU8QVS+PcVDsomILGRKcM=;
 b=kr+iRmc0SZlO/x2SmMwieuqd3F6RBA4NTGs8Wi9hgO5lbv/M1e1oZ63IIhJBNTlL1A
 Be9IKNGcnU2rSL4iSSDzlZJRL2NlFPJ6vAGChf6P63lSUqB4xLlCly2VWmwwvem6D3za
 Q2ICJGELm/4MySsZtyih48GjSbH4DS+ZTXuH9ci+965i2gJPIFmZt/FJ81a/swS1/ot7
 Zl6QnyFkQ09GG6OKAmZL52FQVsUyklQ1YJvrd/vBPqHpRZIA8AbmCoiu96NGrMghCnYa
 9D0hT1QZKEgH3ZAE8u4h+4Xpogt6Dv1gNQ5jOUzlrjasPXILTnEX1NJzhUKb7lUlYW/C
 yQpA==
X-Gm-Message-State: AJcUukdTl7Xb/aYeMKOqADoqvegFxHtR365KMOXk+AZk6bDj2ayc97c0
 UF7H8YLyUFa3FD/7/3FMPwR0/ZZKXVRyxA==
X-Google-Smtp-Source: ALg8bN661jvI7A05kBajrkbBlCmj46PLxlAJ0SiJrVet9moMhv9yMdpONwJ5AWpPYwy63C9TjQpENA==
X-Received: by 2002:a9d:22a:: with SMTP id 39mr2900152otb.354.1548286586617;
 Wed, 23 Jan 2019 15:36:26 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1118-108.members.linode.com.
 [45.79.19.108])
 by smtp.gmail.com with ESMTPSA id s17sm9124333otp.36.2019.01.23.15.36.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 15:36:25 -0800 (PST)
Date: Thu, 24 Jan 2019 07:36:19 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 8/8] perf cs-etm: Set sample flags for exception
 return packet
Message-ID: <20190123233619.GA3268@leoy-ThinkPad-X240s>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-9-leo.yan@linaro.org>
 <20190123215114.GH620@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190123215114.GH620@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_153629_183900_3A18B513 
X-CRM114-Status: GOOD (  30.60  )
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On Wed, Jan 23, 2019 at 02:51:14PM -0700, Mathieu Poirier wrote:
> On Sat, Jan 19, 2019 at 09:43:47AM +0800, Leo Yan wrote:
> > When return from exception, we need to distinguish if it's system call
> > return or for other type exceptions for setting sample flags.  Due to
> > the exception return packet doesn't contain exception number, so we
> > cannot decide sample flags based on exception number.
> > 
> > On the other hand, the exception return packet is followed by an
> > instruction range packet; this range packet deliveries the start address
> > after exception handling, we can check if it is a SVC instruction just
> > before the start address.  If there has one SVC instruction is found
> > ahead the return address, this means it's an exception return for system
> > call; otherwise it is an normal return for other exceptions.
> > 
> > This patch is to set sample flags for exception return packet, firstly
> > it simply set sample flags as PERF_IP_FLAG_INTERRUPT for all exception
> > returns since at this point it doesn't know what's exactly the exception
> > type.  We will defer to decide if it's an exception return for system
> > call when the next instruction range packet comes, it checks if there
> > has one SVC instruction prior to the start address and if so we will
> > change sample flags to PERF_IP_FLAG_SYSCALLRET for system call
> > return.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 052805de6513..7547a7178f46 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1372,6 +1372,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
> >  		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
> >  			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> >  					      PERF_IP_FLAG_TRACE_BEGIN;
> > +
> > +		/*
> > +		 * If the previous packet is an exception return packet
> > +		 * and the return address just follows SVC instuction,
> > +		 * it needs to calibrate the previous packet sample flags
> > +		 * as PERF_IP_FLAG_SYSCALLRET.
> > +		 */
> > +		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
> > +					   PERF_IP_FLAG_RETURN |
> > +					   PERF_IP_FLAG_INTERRUPT) &&
> 
> Would it make more sense to just look for prev-packet->sample_type ==
> CS_ETM_EXCEPTION_RET ?

We cannot check 'prev-packet->sample_type == CS_ETM_EXCEPTION_RET',
since CS_ETM_EXCEPTION_RET is associated to its previous instruction
range packet but not a standalone instruction range packet, we don't
swap for exception and exception return packets, 'prev_packet' is
pointed to the previous instruction range packet at here.

This is why we need to use 'prev_packet->flags' but not
'prev_packet->sample_type' as checking condition.

Thanks,
Leo Yan

> > +		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
> > +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > +					     PERF_IP_FLAG_RETURN |
> > +					     PERF_IP_FLAG_SYSCALLRET;
> >  		break;
> >  	case CS_ETM_DISCONTINUITY:
> >  		/*
> > @@ -1422,6 +1436,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
> >  			prev_packet->flags = packet->flags;
> >  		break;
> >  	case CS_ETM_EXCEPTION_RET:
> > +		/*
> > +		 * When the exception return packet is inserted, since
> > +		 * exception return packet is not used standalone for
> > +		 * generating samples and it's affiliation to the previous
> > +		 * instruction range packet; so set previous range packet
> > +		 * flags to tell perf it is an exception return branch.
> > +		 *
> > +		 * The exception return can be for either system call or
> > +		 * other exception types; unfortunately the packet doesn't
> > +		 * contain exception type related info so we cannot decide
> > +		 * the exception type purely based on exception return packet.
> > +		 * If we record the exception number from exception packet and
> > +		 * reuse it for excpetion return packet, this is not reliable
> > +		 * due the trace can be discontinuity or the interrupt can
> > +		 * be nested, thus the recorded exception number cannot be
> > +		 * used for exception return packet for these two cases.
> > +		 *
> > +		 * For exception return packet, we only need to distinguish the
> > +		 * packet is for system call or for other types.  Thus the
> > +		 * decision can be deferred when receive the next packet which
> > +		 * contains the return address, based on the return address we
> > +		 * can read out the previous instruction and check if it's a
> > +		 * system call instruction and then calibrate the sample flag
> > +		 * as needed.
> > +		 */
> > +		if (prev_packet->sample_type == CS_ETM_RANGE)
> > +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > +					     PERF_IP_FLAG_RETURN |
> > +					     PERF_IP_FLAG_INTERRUPT;
> > +		break;
> >  	case CS_ETM_EMPTY:
> >  	default:
> >  		break;
> > -- 
> > 2.17.1
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
