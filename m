Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC6BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:00:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAFA218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckampLnJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a+3wYfTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAFA218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OrN5j6x1xenb0hFCzAPyLCW1gGcx92+B+oOD9RuZ3tA=; b=ckampLnJvkTLEa
	EvglqfgXNrhXVGeOCmdDjGJodiDeXqr1MTV85p6iw49WCF0rQKJgRaaIRtD87FksTKDCKnm3M6BIb
	Fn7u5nnH93oeTcm92AWdhCxxCwEdJGK+ZUVFD6TdLqugOC1VgIFNcNcXqNNV0hL6zdufh5csHjfqz
	/FZ+M2G5eTanlnBpDK9gC0ZJpvz8Ec38YgnPr/x8RFSVvjmEaShxdn8Oex8IgMklcW3oOj54UX+gq
	f4lJwFZODY3EshBuiiJQDvrmRKlbywbYUa7FXXCskCeh/IpFMtWkYMnQAEwiOlHwZYQGDXi/GPYir
	swWQrj5tBgYeH6X9ldow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmWC6-00044y-QG; Thu, 24 Jan 2019 04:00:46 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmWC2-00044Z-Or
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 04:00:44 +0000
Received: by mail-ot1-x342.google.com with SMTP id 32so4030775ota.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 20:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ucXfS2mSR3iIep7t/+LXhj0pgV0/EUWs4edPa/8THE0=;
 b=a+3wYfTQEmwx7ia7aP23/YO77+S5m9nixp9ZpZ//FWpVmEQ1Gn1qWzeyTRtRaidhkn
 5aZdk0o3QjDcwcNLpWkCzKo2PqjOMtRdJ8x5b5iLgBR0h9okavGUA6Y5CE+qazWKSuee
 ALJmfUIA/MKxPjVLdfcbG3R+WWU+ZvegCGKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ucXfS2mSR3iIep7t/+LXhj0pgV0/EUWs4edPa/8THE0=;
 b=PGCn8ojbRR5+fJ/9OnU5Q6yNKkUp+2XDuJzgG9uuZ/U3mEffF3XrW3DSJ4MGdUkfbI
 5XDbQ0f72NdyAgpXmSC+3GicrkZKsW/y4IwySqBp8ZlFJibAdYSaD9UdNq5t6x7cqZ0g
 qK11nZNyqdoybia1szJQJgXC8ZUmwebrMIdT9zz5tac3hzP3dVaal1My2t5zmz1ufP0r
 0z/N02ijtF7zS9X/EULTrqQknF5pP/3Q+9GaV5QXpGJMb2QvK5NzyWSbxiziPz7Ya1nA
 0+9N3oq+rYmy3kGz/aSCnlyBmEz1l8fmVFnCyt/NI2UvVPpfS4zYPdMOTaoQM2lUflTn
 9YuA==
X-Gm-Message-State: AJcUukfzOJ7dHhVuxtOYYD/NCgEX8bfyzV4v5K9hdk4E4mwPccLJlFUe
 Xi0mpaIhPW80RK73Bi+43nA02A==
X-Google-Smtp-Source: ALg8bN67+11/9I2/T9NjiMLwfN77ulo4XCcpLlkebEGgpME7hLEbIxGl4n7BdK0ZRTzg36S+w5gacw==
X-Received: by 2002:a9d:177:: with SMTP id 110mr3406744otu.26.1548302441097;
 Wed, 23 Jan 2019 20:00:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1103-53.members.linode.com. [45.79.4.53])
 by smtp.gmail.com with ESMTPSA id r11sm10321994oib.45.2019.01.23.20.00.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 20:00:39 -0800 (PST)
Date: Thu, 24 Jan 2019 12:00:33 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 0/8] perf cs-etm: Add support for sample flags
Message-ID: <20190124040033.GD3268@leoy-ThinkPad-X240s>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <CANLsYkwj0jU+GAXXCNY7h-8C40oouF8dx_fzUVRTbV=buS4M2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkwj0jU+GAXXCNY7h-8C40oouF8dx_fzUVRTbV=buS4M2g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_200042_817196_5A461C6D 
X-CRM114-Status: GOOD (  10.94  )
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
 Coresight ML <coresight@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 05:22:03PM -0700, Mathieu Poirier wrote:
> On Fri, 18 Jan 2019 at 18:44, Leo Yan <leo.yan@linaro.org> wrote:

[...]

> > After applying this patch series, we can verify sample flags with below
> > command:
> >
> >   # perf script -F,-time,+flags,+ip,+sym,+dso,+addr,+symoff -k vmlinux
> 
> Since you are going for another iteration please add a "before" and
> "after" example.

Sure, will add it.

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
