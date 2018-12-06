Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B70C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:33:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F09C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpdnuNSh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I34AoiPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F09C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aj9lkIUTf93JLkdEUciKzBmqZdK/NMoWHlQut2nPt44=; b=LpdnuNShhLgRiP
	zNzMgYCozh8KwpwbiSaQo6vqgu5Lan6esYaCeR9fqlmd1BP8ICN9Qb8TGcP34ZpGfg1jyvV19EGt5
	ys2YFfu9GrtHPCJk7gpzOSykIyzlaeZwEUf1kWuUDl7ubgj+vEPISNrPBg7ROqWKde1XAqdloBp53
	zfarIZh3htasAkjMGE8JImm5dwnx5aSfDhZaNxe47Eqzgzdvods7wyTVHdH/+S31MnQJqIV+FWouc
	UohA+KTBo/oDvAJwbCE00QlMc1b8E/MipZbyVaTt2kpl/wbWKGZzzmMhjlDTrb3m0L4UxTtCdIXsX
	ITJqjmV/cQRpQ+ukMx+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUmHz-0007HJ-Gr; Thu, 06 Dec 2018 05:33:31 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUmHu-0007Db-2X
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 05:33:29 +0000
Received: by mail-wm1-x342.google.com with SMTP id m22so15161613wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 21:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=K/0v5WsEOS95YHMihmb1ceT2OejWWg9+cldLrWV4ZHU=;
 b=I34AoiPZd47vges221fbfioEoynXNeS9nxQwaLH6gvIl51B+SDrBrD9yHIhnTQJrG1
 kobyw78oQS4V66Otur0YRMnZxV81wySUV5iIQ8nJ4R3W39S1an+mY+P35FiFR3L2in8V
 gjJmxBOESxrK2FVLhKjhCeC5OTBqMYVdKJWTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K/0v5WsEOS95YHMihmb1ceT2OejWWg9+cldLrWV4ZHU=;
 b=qCvuszHVdLTUBkLTKPfqe+qov2ygPeBEkiJg55sZueRNXGpG5c1jtu+rPLeXartdJ0
 MgyRlkYnC1VaLRQgPLxJcjno5dwjLu43LP5jOjkNRMmJOqLua4PK3gLGPUpKozq1qrde
 mXmLqj6Xa5Wlfo5NhNAO8wQ0PyG22gwb892mtdA61MFMSrAmROenO5mSAevqboewn//U
 toH6Aw0uT3BwBNHnT68YTITmbNuO/nbnHW1fPPHMNIaw84JLRB4P3erBzYVM2Y9HDnoS
 G+nMlUe0x9DGHljgQCq04Z+KZLhQOG8lQ8K2NzDn87AVzxwUuQmg2kfkOc1nXxFAKUQR
 mvTw==
X-Gm-Message-State: AA+aEWZug7BvryIztcbEqGioHjJ1d5KsUv2o1Blt8MXkRXE3dCE7Azx9
 qHDBMalzElvJla2qK3LE3mSNEw==
X-Google-Smtp-Source: AFSGD/X0xieekHvJaABdiU0HaCJvLwu4fO8IyDgjePpY+LjFxr0Z5WnuhSWys1DyfdIKku9Ge4tuNA==
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr11818176wmf.27.1544074391720; 
 Wed, 05 Dec 2018 21:33:11 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id j202sm20927950wmf.15.2018.12.05.21.33.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 21:33:10 -0800 (PST)
Date: Thu, 6 Dec 2018 13:33:03 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 1/2] perf cs-etm: Set branch instruction flags in packet
Message-ID: <20181206053303.GA4244@leoy-ThinkPad-X240s>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-2-git-send-email-leo.yan@linaro.org>
 <20181119222617.GA5628@xps15>
 <20181205062550.GC15964@leoy-ThinkPad-X240s>
 <CANLsYkzTJdKtXBwMMLStgjoUEKz8nsvOpKYcoULh7kHejGAGsg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkzTJdKtXBwMMLStgjoUEKz8nsvOpKYcoULh7kHejGAGsg@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_213326_117592_B30A9284 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: Al Grant <Al.Grant@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <andi@firstfloor.org>,
 Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>,
 Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 10:40:07AM -0700, Mathieu Poirier wrote:

[...]

> > > >  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > > >                             const void *context,
> > > >                             const ocsd_trc_index_t indx __maybe_unused,
> > > > @@ -484,6 +650,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > > >             break;
> > > >     }
> > > >
> > > > +   cs_etm_decoder__set_sample_flags(context, elem);
> > > > +
> > >
> > > I was toying with the idea of setting the flags in each of the case statement
> > > found in cs_etm_decoder__gen_trace_elem_printer().  But that would move more
> > > code around and the end result would be the same so let's keep it that way until
> > > we have a good reason to split it.
> >
> > Do you sugguest to keep current implementation rather than to
> > split flags setting in each of the case statement in
> > cs_etm_decoder__gen_trace_elem_printer()?
> >
> > I am not 100% sure if I understand correctly for "split it" (split flags
> > setting vs split functions).  So please correct me if I misunderstand
> > this.
> 
> I find function cs_etm_decoder__set_sample_flags() overly long.  Since
> the case statements in it are the same as the ones in
> cs_etm_decoder__gen_trace_elem_printer() a different way to proceed
> would be to do flag setting there rather than all in
> cs_etm_decoder__set_sample_flags().  But that would introduce more
> code modification and tighter coupling.  Since I don't have another
> alternative I am suggesting to keep the current implementation.

Thanks for clarification.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
