Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299DDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D2C2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 00:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bS/081vK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rXfq8FJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D2C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VObKA5K0OAohlFoeWBhtsBX7kU7LGeC8dzIQ7w3yNmY=; b=bS/081vKKX/6we
	J4oqYLTBcYlmSP/HZkN0MIBVBhZcTQgpSfL7j1wCRk1qSA7Vor8u3LAtZ6RdT359QDKEioLgAG07L
	VVwL6hxq9T+XtPZpdIYT84qMABM6TKkp1+i++4/YLBWVrIr8McpruafHxc0jMnLF/1Jdwr4jSVh3P
	7u00X59Iqu9tJLcFBUEjW8dQC+ZL60JwpBfKmaZmEgNwFPS1BQJIBfbqPNHz7L3Z/kjXQx0GdQbDk
	kwlpmIXooPZblvHTaIp9EyqQlc0u3c9nqZIF/kn9gZ4uXxnoYKbrUkH7Sj+1OJvBQVuq875O438H8
	kF+uIMzE8JzPOC+xCiew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVn33-0004OA-Ad; Sun, 09 Dec 2018 00:34:17 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVn2x-0004NC-OG
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 00:34:13 +0000
Received: by mail-it1-x142.google.com with SMTP id i145so12430304ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7JCnuAVpmU+9HYO/EntxxgeLj24G13undlSmpFzSjV8=;
 b=rXfq8FJup/21aQTqyALsbHQk83nCS+qhaR+Upk5ZvcE3XywZySA2YKv5uc5/0zy2kr
 XG5aKlwK13Q2zmW1niDHbYoVXI4UOtFPLi804n5tBwvB4CQh+b0N/S0YTFxdRY2wCoa3
 mrZu2cDcW6snLzHerHFEshpxRptQxcOoZpSeAwTqgpYaJwJly4DAuap0TS6TX+TR/EUW
 IudQJgCPUptHKzMVH4pPMPiTb/nkIzbSCiyYjk/qj9BMv1jaTrnGIHvqCigBEEjtItk/
 yvyjTVakgQ05nBFfpFkMVdK8bG9LdNcR/JlFoHp2XZ2KxfHRxZt/JN8Ckjl1/Wc6nHW9
 d1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7JCnuAVpmU+9HYO/EntxxgeLj24G13undlSmpFzSjV8=;
 b=R31kiKubGKNjZ0CMIy+l8jQGjlAx5pI38jGLLJp4txc3DIBSjPEt5wXTMjhgeWcjyV
 OxnQVtw2j6DmPbVm/A9JUDuLXpE6jmbPG9pw2NbgzCQabn06zTLT6oq9/AM/nYJVN95T
 LQaz8GLePfMgXgrm/x6A6mbKAXfk99lJvLgm9mTor0niC9enKU817ypN1qhK16roxm93
 xhfDshGdYIyDfdDzpCDLlN1xAeSUZJgqrvphEWXBzUCXqajuvvIIYPLjG+DBWpkfH/bC
 xW0oQyf/PHdm1wo2iW4mLI3cT5fej8rqRq7ygPulH7sDxsTZzGYHvrO79rZd0WGnmyxs
 NAGg==
X-Gm-Message-State: AA+aEWb+ZkaufWoHG7QYJzG6YkavjiRMdVE6fpjIZgLsAax0xMWYUsEj
 8dA+pbYurnQBgaUnpTl0fw/ADi4GT/nIvFbaZGHVbQ==
X-Google-Smtp-Source: AFSGD/VhEV03x1++WZFk1bM+bpp9j/d4H12Ln0lm3PtnRX1RdiADw4snoUCcqCJu26KpTpJvqHKX3fyfYVy0ouliXXE=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr5602246itg.136.1544315637464; 
 Sat, 08 Dec 2018 16:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
From: Olof Johansson <olof@lixom.net>
Date: Sat, 8 Dec 2018 16:33:46 -0800
Message-ID: <CAOesGMgZYheG77L_nuNtTA8xY-PtDpseHOKf8kCjusiYsv5Mmw@mail.gmail.com>
Subject: Re: [PATCH v12 0/7] Introduce on-chip interconnect API
To: Georgi Djakov <georgi.djakov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_163411_792998_80D30799 
X-CRM114-Status: GOOD (  21.32  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, daidavid1@codeaurora.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>,
 Alexandre Bailon <abailon@baylibre.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, evgreen@chromium.org,
 ksitaraman@nvidia.com, DTML <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Georgi,

On Sat, Dec 8, 2018 at 9:02 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
>
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
>
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
>
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.

This patch series description fails to describe why you need a brand
new subsystem for this instead of either using one of the current
ones, or adapting it to fit the needs you have.

Primarily, I'm wondering what's missing from drivers/devfreq to fit your needs?

The series also doesn't seem to provide any kind of indication how
this will be used by end points. You have one driver for one SoC that
just contains large tables that are parsed at probe time, but no
driver hooks anywhere that will actually change any settings depending
on use cases. Also, the bindings as posted don't seem to include any
of this kind of information. So it's hard to get a picture of how this
is going to be used in reality, which makes it hard to judge whether
it is a good solution or not.

Overall, exposing all of this to software is obviously a nightmare
from a complexity point of view, and one in which it will surely be
very very hard to make the system behave properly for generic
workloads beyond benchmark tuning.

Having more information about the above would definitely help tell if
this whole effort is a step in the right direction, or if it is
needless complexity that is better solved in other ways.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
