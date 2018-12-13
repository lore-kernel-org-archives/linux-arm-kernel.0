Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFCC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:32:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B633F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Haw8u8yu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZOwCjhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B633F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eTtn+mcxZ2GtHxHFZs3mMTaMSreTQTuQij72ELQ2bQs=; b=Haw8u8yuBEUERM
	h16SSo7R2JnbmHAN2HhHmvr9h/00mq4Qey3qdIoigOSbmaaAwKWmTC4RJ5r3aLoIqP7/fl9EOAUSm
	O61dP4KU7UjxBrinKl6/5ZBg+BotOFPiQVChT21v0aMHhzmR6fx3LUqnop1vgiW4POCZdNu6VmHCr
	WwPLwP0sgrkhnNvQWGFQWh3SbbyeaSFlAtCkVTCJkvj/ioXSl/v1wHzsZTDpJgFwNgWqwLw3Bchj8
	twPefnS+W0ClUnYMKysBH/jnLZlhycAxy+7tcWYe4/UTMuOEsbtLU30ajcBRrWkjAj++xffQ+WTB/
	SqEfjWxsIlJ/3dkex8qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXR5q-0005hX-6w; Thu, 13 Dec 2018 13:31:58 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXR5m-0005g7-7t
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:31:56 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so2016968wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 05:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HkEUVoqr9/FZA6SfGZutf6vi5PAgBI/VuaNwhT/f7sY=;
 b=NZOwCjhV9My9FWWRDmY0b2weYUFopS0LMFQxJyjW5vEjblPc5RrmWW0jtdXy5l4VGp
 YMU/SBFKArm+hMcL0G+v6zwOtx2Rln9kuxN9ziObfhi7JywX0EyZGAeAzGbg1DAS+Ubj
 PKhtRRX+SPW8y/5QnJOi+PS5PaiiuovmMsX9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HkEUVoqr9/FZA6SfGZutf6vi5PAgBI/VuaNwhT/f7sY=;
 b=mkNa8ID7okownnE0L9uqDQ4PKvrR4j8Lhij+TUJdogaBlCw29l1F+teAFmFcbrUhnX
 Bh9DrGbCub198Bb39sLQSSpHP+0KrLCl/IWbI5kdSiWcqBCYMpRdrz1ZXa2jGTZ41vFu
 wu/lS+WYPqzBQ/dzAucpFmqXyLfuc2urUs1rtFElxWbfv1yL7LWz5FtJ34/mql0ucERV
 jQuaX0VZaaCJj/BhaYlJl6nQekK/19dUmWf+V6nfk6bpPWbYLDua92VFXpRte49Xg/rv
 oFH22qeL18ENFIrFJmHewwrJ7WPTK5vAS2+h4Z/XdSNplpHbXfSXfio370w4AqL7eqN8
 uuSw==
X-Gm-Message-State: AA+aEWaLVRUy832V1ImcafdNO5y9S+vNXcDkpGCPzao24MrBEY/cEYlq
 fnJ7S8utsQSz1yz4ZXz0Cliy3w==
X-Google-Smtp-Source: AFSGD/UDy24vnLJwoqdlHBmlGpu/oU3hXgYXuqlb39wQMaVgnXU8FmvHiyGsgPGBs3XMFVTkIsKmpw==
X-Received: by 2002:adf:8122:: with SMTP id 31mr21646316wrm.48.1544707902217; 
 Thu, 13 Dec 2018 05:31:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id k128sm2456292wmd.37.2018.12.13.05.31.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 05:31:41 -0800 (PST)
Date: Thu, 13 Dec 2018 21:31:31 +0800
From: leo.yan@linaro.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213133131.GD17663@leoy-ThinkPad-X240s>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
 <20181213130949.GB17663@leoy-ThinkPad-X240s>
 <20181213132126.GI21027@kernel.org>
 <20181213132633.GJ21027@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213132633.GJ21027@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_053154_277446_4E05EDA4 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Coresight ML <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 10:26:33AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 13, 2018 at 10:21:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Dec 13, 2018 at 09:09:49PM +0800, leo.yan@linaro.org escreveu:
> > > Thanks a lot for helping.  If you prefer me to resend the patch set,
> > > also let me know.
> > 
> > I can fix it, here.
> 
> Can I take a look at the result:
> 
> https://git.kernel.org/acme/c/222b0bead7e4

Yeah, looks good to me :)

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
