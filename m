Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:06:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B442086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PALV64YZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GzMIrTld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B442086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xc9IwhYUh92b6sT+k3bpuY0FcbYet0PtNkPQoUf3Sc=; b=PALV64YZIiHrHi
	XnYfLrVkq0IQd+4EDQO1gRuctk8U5zXsL4aHiclx8jamoYtMZqTzhxV87JWY0gD/tme3abbOJgKfX
	1+CMCi9uUo9VUNuccPH6A+ssw3WZawCt5tzMubtRa/zlMnE/hz2oCd+ewtUkZtqnTTmY+ZcjKB63S
	Bj9nT3jp9q8X7dG/3iZQ8jJJQ1nnerECOHQMgPJtW9a4QRE7c8Ht8Ai1lNqB4cxMqkzdikAmRht+m
	8823yb+GyqZ4zqspvdAaiKwUUgf9f7ECUZA6XIOjGKvhWRw/kp0BzAFSEQ9fmmO8Q2/pODsa/FzdT
	q4O6bmCeOA+SIanyNVzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giz89-0002AW-Go; Mon, 14 Jan 2019 10:06:05 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giz84-00023H-Tv
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 10:06:02 +0000
Received: by mail-ed1-x541.google.com with SMTP id x30so18189343edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=31n6q9gHjvwQ8HUcLFEyEeRyWzXo+P9WHYJIC1waV1I=;
 b=GzMIrTldTY5X354pq6qiV+EXzAMdM86Sg6lGpmfcDNZVI4880Yj6bX+93vsfPuoIPI
 S4VPGjtU5zju+vsYOsJVm9OBVymSF33Sq0qyid79WYqnsmzG6DxOyjYk38kSRNB4mXo2
 /uFDcvkMbpc8m0gojkYCN0tDMPJSJNmoZM5Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=31n6q9gHjvwQ8HUcLFEyEeRyWzXo+P9WHYJIC1waV1I=;
 b=s8rjmdTtn1m18LQHtHjK4CnNdiSZoxp8HXik2V8N48qf9QU8wHdaIysatTn7iMQEzj
 qH0SWkZAzbrGfRlTv9g5J/lnqluTu/J5v4D8kHzDZVQwOgeGvz5g1fdFBlgGURRgZR8m
 NOkuc/y8UeIyEe6nykVZybu+KbIffSi2T0pcEj/kcG7Oa/1qrc5SXK31CXe0HS2E5BiR
 lMESdyhhxAPZe2VW3fDnCj+9/R11N3S1appKRJUQzWeo0dPzuOit4dWRnZ/syjZYUvTx
 /lREffJbvTwNVhEhulemCWTK8MbfNtE1bcjrAqUdvbrSvSjA/EYlgniW8elFmgW4qAzG
 fH5g==
X-Gm-Message-State: AJcUukdkhiMh3GC9rFRXAyX3C3SuykpC22knNDO/cEwsxQ/vvKmb9vuz
 uA8wirsxbSc6pGl/1MQoQkCI3g==
X-Google-Smtp-Source: ALg8bN4nZrWkCsQEb2QLSbmu7yWl951UtmaS41OrKfjpqVinoMnVAMbr5lU2HQbwuQRUJhm4APVzHA==
X-Received: by 2002:a17:906:340a:: with SMTP id
 c10-v6mr19939655ejb.130.1547460358897; 
 Mon, 14 Jan 2019 02:05:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id s5-v6sm2265009eji.25.2019.01.14.02.05.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 02:05:58 -0800 (PST)
Date: Mon, 14 Jan 2019 11:05:56 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 3/4] drm/rockchip: add missing of_node_put
Message-ID: <20190114100556.GC10517@phenom.ffwll.local>
Mail-Followup-To: Heiko Stuebner <heiko@sntech.de>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Sandy Huang <hjc@rock-chips.com>, kernel-janitors@vger.kernel.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1547369264-24831-4-git-send-email-Julia.Lawall@lip6.fr>
 <3397932.PmTvevuZIG@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3397932.PmTvevuZIG@phil>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_020601_018031_5121E566 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Julia Lawall <Julia.Lawall@lip6.fr>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 13, 2019 at 07:48:49PM +0100, Heiko Stuebner wrote:
> Am Sonntag, 13. Januar 2019, 09:47:43 CET schrieb Julia Lawall:
> > The device node iterators perform an of_node_get on each iteration, so a
> > jump out of the loop requires an of_node_put.
> > 
> > The semantic patch that fixes this problem is as follows
> > (http://coccinelle.lip6.fr):
> > 
> > // <smpl>
> > @@
> > expression root,e;
> > local idexpression child;
> > iterator name for_each_child_of_node;
> > @@
> > 
> >  for_each_child_of_node(root, child) {
> >    ... when != of_node_put(child)
> >        when != e = child
> > +  of_node_put(child);
> > ?  break;
> >    ...
> > }
> > ... when != child
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> I've added a fixes+stable tag and applied it to drm-misc-fixes

All of them or just this one here? These cleanup patches have a high
chance of falling through cracks, so taking them all usually works out
better ...
-Daniel

> 
> Thanks for catching that
> Heiko
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
