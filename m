Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:39:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBAE2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZJT/hRJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuqTKsB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBAE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x4eORREhug4PtJu8QJw/zKHXqelDeMy6pPouhxpD3QA=; b=KZJT/hRJ3D7bWG
	zZauBnzxmt92iGoU6IycBCXavNC6ah6sh1B+qqGChdfxwTosThkeeKs/P6kA/+P/8Pq+M0pTij3lM
	8UUVcxWHQWI2yoVXFrzKaSyESItAtRInBFs9Coi/nmGT++PG7kYk2WFcnzHAjqKclE39SNqXLYsc7
	LaLLQpimV/OYI/CdzhC3/mV3It+VFEMJjSHwI9Kq+Akeu62i7UaiFKDqIgtxvtHsVpqFrwJya+vkL
	C5kLOuoN8ipMRB4HK199JvnvMLMiNs9l593sknUeMnulZcT8n+rRUM3KDr4V9bjGQWubi3QW6XqP/
	RSKnKgxw8GbVCdoJsjHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWW5W-00020e-9s; Tue, 11 Dec 2018 00:39:50 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWW5T-0001zl-5e
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:39:48 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so12322129wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 16:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fKIR4P7y/Lu6Yb8WVUlkSDD3877cMUmbBO+/z1d0K18=;
 b=CuqTKsB2uVD1U/jhVZfzTEgut76Yy1Mpz6QRhDIhtzadIX3y7g79MxsZX0dFi4h7JO
 wWtztnE3kkcI3OD6Zd2QqXL9/iUAs6XCdoLsJAONzNXkHtULVRpzdPh/PmaW7dxbUq6B
 SrE2kVMwtF7vTcSFnDgcTx+qWz/m0yvYmJbJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fKIR4P7y/Lu6Yb8WVUlkSDD3877cMUmbBO+/z1d0K18=;
 b=eVRw9M05nFo34lScaCwi6nLbODe2IrqRDUr0lGhl+t70xJeC3QTl35RES8sjFbwH7z
 7L0JTCAV7y9SfTbla33fNTCWoRqGJ9fLRsvSjaCazIADpwmPhufsZ4iHcJ6Lchu6UyoF
 ZdeI0rrxEhU9LootJlHLksO52RmgyLCv0mC7KxRNReWJefYfowkfsNZj9V131Z41NGk7
 FsZm5SAM2oIveJ6jZ+ojSmL69ZbAOjpq7bxyqCTaeQnwXNZ8SsGJHp9uoYnTH0GqKhoP
 A0L9NwEJHCzkxH+AM1vFCvIXTu8codV/wkq6TS8cT2tubyiPPMyE242Bx1hmtXIvsaPS
 16Mg==
X-Gm-Message-State: AA+aEWYuZj7zSPg18lU1+NrqMJ6yQ+GMS4oTWMPdzog24g838AOrHRyD
 i2xpSND1ByI+B0TRcQGVUPflqg==
X-Google-Smtp-Source: AFSGD/Vv53aD3t+pRR7wWDZGhm9sfdbIqhUexenG//DhDlO4aMb5OXnGwPkmmoUWtw/vi/RN+GZi+A==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr11942983wrn.276.1544488774546; 
 Mon, 10 Dec 2018 16:39:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id q12sm11584257wrx.31.2018.12.10.16.39.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 16:39:33 -0800 (PST)
Date: Tue, 11 Dec 2018 08:39:05 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 5/6] perf cs-etm: Treat EO_TRACE element as trace
 discontinuity
Message-ID: <20181211003905.GA21018@leoy-ThinkPad-X240s>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
 <20181210230445.GD12152@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210230445.GD12152@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_163947_216020_36934743 
X-CRM114-Status: GOOD (  22.06  )
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

Hi Mathieu,

On Mon, Dec 10, 2018 at 04:04:45PM -0700, Mathieu Poirier wrote:
> On Mon, Dec 10, 2018 at 04:53:00PM +0800, Leo Yan wrote:
> > If decoder outputs EO_TRACE element, it means the end of the trace
> > buffer; this is a discontinuity and in this case the end of trace data
> > needs to be saved.
> > 
> > This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
> > hereby flushing the end of trace data in cs-etm.c.
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Robert Walker <robert.walker@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 46b67f1..bcb5c98 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -411,6 +411,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > +	case OCSD_GEN_TRC_ELEM_EO_TRACE:
> >  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> >  							    trace_chan_id);
> 
> If you were to get rid of decoder::trace_on at the beginning of this set you
> could put NO_SYNC, EO_TRACE and TRACE_ON together and call
> cs_etm_decoder__buffer_discontinuity() only once.  I wouldn't mention it if you did
> not have to respin but since you do, might as well just do it.  But that's
> entirely up to you considering, at least in my opinion, that you have addressed
> all of Mike and Rob' comments.

Thanks for suggestion, this makes sense.  Will spin new patch series to
address this and also follow up other suggestions for this series.

Thanks,
Leo Yan

> If you do not want to deal with decoder::trace_on as part of this set:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> >  		decoder->trace_on = false;
> > @@ -431,7 +432,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >  		decoder->packet_buffer[decoder->tail].exc_ret = true;
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> > -	case OCSD_GEN_TRC_ELEM_EO_TRACE:
> >  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> >  	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
> >  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> > -- 
> > 2.7.4
> > 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
