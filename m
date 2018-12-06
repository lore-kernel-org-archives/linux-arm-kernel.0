Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D85C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162E02146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5WijBNU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVLVzAlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162E02146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zuzE14Y4I6LNGuaopvahQ1z+5WchtSYTuZP4lBwXDaM=; b=m5WijBNUGucBiC
	AYI0KsRKJI6r4CY8Fd68CB5X9zCxkY9V3jaJac7gTHyE7hQ78d4RrWsG9Gm/i96EgfMvsJReVhskg
	7ztCLhrazj1OeoT22h/hQfhSdb4X1He3VYgRtFm4C4Toy5X6kC2wllPlkF7rRc1Lna6mRFydznSgx
	BXrPGjYh2buBpeJ+xn20cCsJgn9hjG5vT9z2VvUCsB18FBbMsIZnKK6Clgr6zPqDqleIEIDTNyJbQ
	0JCGMQJSiXakVzhxVFTQbEFfDR1ndsDKZl7VDsNOIWY5xeW54HAS1AEATlmfvwsM/R9WyPQbPgWn3
	cOBzjXNmjyhUBRPMZ5Rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUmUN-00031H-H7; Thu, 06 Dec 2018 05:46:19 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUmUI-000306-BR
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 05:46:18 +0000
Received: by mail-wr1-x444.google.com with SMTP id j10so21932031wru.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 21:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9edkJWCLt7sQ9fhpxgG40pGGEUkb70TMl96x5JqM0ZM=;
 b=DVLVzAlx4WAet+GkDXPI5Ps5vDzDGT61PsUO2+Z1ojWgf8aAzvk9+nq7pqfIjimruo
 n1uQK4TpHXdUJHOLQosYhMoW6QdzkTa6Wzd/X3/+Zlu8sdLrvi9GXD/wdIqwl/udTnF/
 9V0iGGlWb2yYsW45QPyqyTurZlFbQzNeLtjzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9edkJWCLt7sQ9fhpxgG40pGGEUkb70TMl96x5JqM0ZM=;
 b=FPJhyCbLNN9+8GFo+QQ67BScPwOGTn3CYHMcpqIQbvqE2VcgLqS0P8dX27CuyYnUXq
 +D0IYNKyr0pJYdi1J3GqrDP7zQqgMQsCNC3LGOVmnJiZFZc2Uq2F39xABynyM0wPdeLj
 wPXXDBs3kX96HPjbrd3UfXbPCY8yOyzoYRpz19Xbe2KzvbaJ9S7UFQpMzQ7N3R7Zjccs
 r6nBgoEmHL5L8TMVp3Hj1rfvM3KTTrhTmIYHPbr+Mgusg1alUNY0R3YAEml91d2Z1HWP
 OBRFlGi4A9ZWrBfCxQQAf7U7Pz14IBq0prhyYWnOhqEsUlNJ3zwBn2t7qQ6iEzJ062S2
 3GdQ==
X-Gm-Message-State: AA+aEWbvuEtuqKdTM06vJ5caFhAXKz1ntMeA23tpAVPFmuW4C1+kaMs1
 r3yGgUNvFE9aTOcLXhMWW8w9pw==
X-Google-Smtp-Source: AFSGD/VuEOIcHI/jN4Id4UlWwF4tisVfSHnLXO6O1tGZL5lvC6F7/0zizlv4NHMtABF7jOgTeLn6Dw==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr22847147wrd.20.1544075162336; 
 Wed, 05 Dec 2018 21:46:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id n6sm11468423wmk.9.2018.12.05.21.45.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 21:46:01 -0800 (PST)
Date: Thu, 6 Dec 2018 13:45:53 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v1 3/5] perf cs-etm: Support for NO_SYNC packet
Message-ID: <20181206054553.GB4244@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-4-git-send-email-leo.yan@linaro.org>
 <20181119182759.GA608@xps15>
 <20181205033145.GA15964@leoy-ThinkPad-X240s>
 <CANLsYkyMb58D9JetJN4BdVcaTmurPRqd5BZy99zX=5DA0J9wDA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkyMb58D9JetJN4BdVcaTmurPRqd5BZy99zX=5DA0J9wDA@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_214614_387160_FFC573A0 
X-CRM114-Status: GOOD (  12.94  )
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
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 10:48:45AM -0700, Mathieu Poirier wrote:

[...]

> > So I think there still have some difference between TRACE_ON and
> > NO_SYNC packets, TRACE_ON packet indicates the start of trace and it's
> > also possible caused by tracing discontinuity; NO_SYNC packets usually
> > caused by an unsynchronised state.  But both of them presents
> > discontinuity in perf trace data.
> >
> > I prefer to use two different packet types to present them, this can
> > let the code to be more readable and easier to be maintained later.
> 
> Absolutely.  Make sure to get to the bottom of the story with Mike
> and/or Robert before sending your next patchset.

Sure, will sync with Mike/Rob.

Thanks,
Leo Yan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
