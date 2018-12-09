Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88381C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:53:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F522081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="elznrleM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0TO/TPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F522081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ke+xypRbOWg9b5wqCBpcNw4pnnxL8yqDKWX0x5TOI+g=; b=elznrleMdHv1pU
	f/eCIqaUTKmyn3G+xaJs0ltgx6sL8GKaJ0/+HwmDHBuuKcS4grE+JEybR37Kc8OS67mzSnfZJN+sr
	9ufnNtTf+OyXTwWCX0XR0PL/XOJlnVmnHJFROwFffRzIXCytqB1Lb60Emb2ptYStDZhX7oPX1oZV4
	wIEf2JNyRlDvWNqJnNxkdq1wXhSTNNZqGYiGHgAe21JdME28dSYz/o8UlFWQ4rTwFYKTgCfVRbY7s
	c+KrLClDVMaRcjhiBykv+WOyNtlfpQ1xKT6lRg+8PIMj+HPZldi+KGysDA/Di6vQmhGl9qx2+Of+t
	MBgfwJfboq/sNXvTQxSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVr5P-0006LK-OQ; Sun, 09 Dec 2018 04:52:59 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVr5M-0006IF-FQ
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 04:52:57 +0000
Received: by mail-pl1-x641.google.com with SMTP id a14so3654575plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 20:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=46qUYpbbNitWjlB0ZH4fmYZsgzUezmQ9lWgsvWDqpLE=;
 b=J0TO/TPv7gezqLnenEJgcidkKwGmdUYVHpJqbJVGrYkF8ZHH/RNS/is17B3qIBl9ja
 9TFX0x+JMzgJdYJ2Uo0MmfXy93xHMMt/oZmi6r4vbLqrrcg91WkPuItG7IKVP3GwXsNR
 MiDowiNKWOxQk8ye6rZDIlX0Cdg2fEADdQk9bjuo3uLPude38l3TxzDufE7qWxuJvN/B
 21cnpR++TuXpnVcnAUrfGGfd3QJOQUmydAfzU2h9eKjfADpF2WBfaupfwhqy0afW6r8L
 sYdvNevx3VxukHbM2ay/Ftr2ol+RJIWU+mKlREsByDILUVtOoOYhNg6mIJchwJ5q61CE
 Pz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=46qUYpbbNitWjlB0ZH4fmYZsgzUezmQ9lWgsvWDqpLE=;
 b=UqSKiQvexE3LvzIrfZLxHkJJbpfeaR3CjuUiKPfssXPOLXKG0yeCwuGEB4GtRHt7/g
 anjdZi7Ge7Ntvybzwo2Sa1Q56ZlXupY25k1ehpUjXGoJdtG6mzZE/7gnuYnbfjIjYJza
 +FE1ZG6dSdaTONoG6s03gmQ1ZCJm5TpjCs7BIFmnbS84kcusb+omFYA0JBrb84n96kPG
 Vnkr26XnOJuFeUT2iho7IT4AODf3a8dwnpAUWQQnD8YhpfKvNlvHRbYK/SIpwCXoQDz7
 3WGnO/l0ysY32VDvk59qPvpriK0GO9y2TsAkGuZXtPJ1GvUX4j2jf7rMtPsuq40SX7oA
 vtQg==
X-Gm-Message-State: AA+aEWY3Q1kpXJ6XejUHXr+aOcvLEdj/UOYdQZmj36OZD0qG8dlp1JI3
 JDwheTqh/XmlKNrZnhgXQ5GiZU0S
X-Google-Smtp-Source: AFSGD/Wbmf/fsfcSG5CToTJYj2IVPfLTHGmXKhLiCHAHGgVliv5H76YApMljqqtC7hdBo/HsxtmzDA==
X-Received: by 2002:a17:902:3281:: with SMTP id
 z1mr7842185plb.296.1544331165288; 
 Sat, 08 Dec 2018 20:52:45 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id 79sm8947886pge.66.2018.12.08.20.52.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 08 Dec 2018 20:52:44 -0800 (PST)
Date: Sat, 8 Dec 2018 20:52:41 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Message-ID: <20181209045241.GF211094@dtor-ws>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181128091532.GU4272@dell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128091532.GU4272@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_205256_520208_3A5E4BBE 
X-CRM114-Status: GOOD (  14.83  )
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 linux-stm32@st-md-mailman.stormreply.com,
 Philippe Schenker <philippe.schenker@toradex.com>,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>, linux-input@vger.kernel.org,
 Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 09:15:32AM +0000, Lee Jones wrote:
> On Fri, 23 Nov 2018, Philippe Schenker wrote:
> 
> > Move defines that are ADC related to the header of the overlying mfd,
> > so they can be used from multiple sub-devices.
> > 
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > ---
> > 
> > Changes in v3:
> >  - None
> > 
> > Changes in v2:
> >  - This is a new added commit. Separate commit for moving the defines out of
> >    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
> >  - Pre-fix defines with STMPE_
> > 
> >  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
> >  include/linux/mfd/stmpe.h            | 11 +++++++++
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

The series seem to be heading towards MFD or IIO, so I assume this patch
will be merged through one of these trees.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
