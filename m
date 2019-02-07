Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140C0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D584A21902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9Rjudy1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="ke9wHLrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D584A21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jVVE5VmS34fh3qoXnL7og7Nlm4exV738KoLqLk/pgXA=; b=F9Rjudy1QC+2oW
	1b3Nj8aw0wLoCqyCoc2rN4DnU7IzMWaKYx4Wd497N19wlIZtekDMytZijZ/t7Ib+rXFskUB1yorG1
	qGHCiuDsUhAC6kubUytyOSM9bGbre50qObocy5XpIohJXXvjGMCw5UWoWVBJpL+8UmGLGGyMSaS6x
	aBFwTZByqMJ4JJWjjhyvEmgQ/csL4eqo5wJf4gLguB+MaIHFyzzHf76+y43Ls2qXsyK2R6+RNsb4I
	kRj5J+IG+61FLzpPkTIWI9zgZ0Vw4x54MX02MEpJz0FyKAamtlbj9cN50jdZYQDEcSDNr1cqGOZub
	DV9PzqCLHLU71kzAwfsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grccv-0003NT-Ve; Thu, 07 Feb 2019 05:53:33 +0000
Received: from mx5.ucr.edu ([138.23.62.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grccs-0003N7-H2
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 05:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549518810; x=1581054810;
 h=mime-version:references:in-reply-to:from:date:message-id:
 subject:to:cc; bh=VcVhiERyGKHily5ypTgS5H29A4FBtKsk1pDYCwypsi4=;
 b=ke9wHLrkLTtCzbi6WoqGYtfykbuvg2wajTjzJuGR/PiGE1iLh4LN1Dx2
 gXqzQZsZOpK4YPOcUynNTWPwfONIwhZXWykUfB3JEuM7CgnkjC/901Fb+
 Ed4znq/UHlQCFlVmoywZj0Z5j6fzrkonwhp1o0E7o2hJ/jC3BK5DlLoD2
 akSR66luoQgQiIj561kTBf2Y7hzoEahtTVa1CnXYUm1FLOkLQtB8aaj2s
 ad2lqEi97U8vabvugz+gn6vNVIkOrncOBNzeS1j1Q1avfLpYJqwNpFKMQ
 MjXRAMGOHy5wMwAmYwYe8SMi6wYJ72M/aWoUc+eqP1BEQKpoMo2fA3j70 g==;
IronPort-PHdr: =?us-ascii?q?9a23=3A8VFfYBNLBHQxhGDd4fgl6mtUPXoX/o7sNwtQ0KIM?=
 =?us-ascii?q?zox0LfT7rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHzQksu?=
 =?us-ascii?q?4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1?=
 =?us-ascii?q?Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xAHTontPde?=
 =?us-ascii?q?RWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKHw65NfqtRbY?=
 =?us-ascii?q?UwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz+s87lkRwPpiC?=
 =?us-ascii?q?cfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvd1Y6HTcs4ARWdZUclRWS5ODIOy?=
 =?us-ascii?q?YYUMEuQPI/pXopLhp1cStxayGRWgCP/txzJOm3T43bc60+MkEQze3gMgHtMPsH?=
 =?us-ascii?q?TJrNXyKawdUuC1w7PJzT7eaP5X2Tb86IjSfRAgvf2AQbx9fNHMyUYzDQPJlEuf?=
 =?us-ascii?q?ppH4Pz6M0OkGrmuV7/J4WO6xl2Iqrxt9rzuvy8s2l4XEh4AYxkrG+Clnxos+OM?=
 =?us-ascii?q?e2R1RhYdG+FZtdrySaN4xrTcw8W2xooyM6yqEeuZ68YSgK1Iwrxx7BZPyDdIiF?=
 =?us-ascii?q?+hfjW/yQITd8nX5lfLy/iwur/UiuyODwSNO40FlNripCndnMsm4C2wbP5ciAT/?=
 =?us-ascii?q?tx5kah2TCR2ADP8uxIP1w4mK7BJ5MiwrM8jIcfvEXBEyPsmkj6kreadkA+9eip?=
 =?us-ascii?q?7+TnbK/mppiZN4JsigD/M6Qulda+AegkLgQDUXOW+fmg273550H2XqhFjuAunq?=
 =?us-ascii?q?nDrJ/aPdgbprK+AwJN1oYj6hC/Dyqp0dgBh3YHNldFdAuEj4f3IVHOJu73DfOk?=
 =?us-ascii?q?jlSokTdr3OzGPqb7DpXMKHjDnq3hcqxg5EFC0gU80MpT55VOCrEOc7rPXRrdvc?=
 =?us-ascii?q?LZAlccMgiwzvyvXNl0yI4bcW6GHKKcNKTcrRmO6/55cMeWY4pAiTfvK+Uir8zu?=
 =?us-ascii?q?hH5xzU4PfaCohcNMQG2zBLJrL1jPMimkucsIDWpf5ll2d+ftklDXFGcLP3s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AfAACMx1tcgEinVdFkHQEBBQEHBQGBU?=
 =?us-ascii?q?gcBCwGDOjMnhAOUCIINkwKFD4F7AQyEbAKDGiI1CA0BAwEBAgEBAgETAQEJDQk?=
 =?us-ascii?q?IJzGCOikBgmYBAQEEIwRSEAsLAwYBAwICHwcCAiISAQUBHAYTCIUeBaB5PIsbf?=
 =?us-ascii?q?DOIWQEHgUsSeYs4ghaEI4gKglcCgSwBAQGKUIU7kU8BBgIBgWWQYBmBbIkCh2E?=
 =?us-ascii?q?tm2MPIYEnA4IJMxolfwZngU6CUo4sITCOegEB?=
X-IPAS-Result: =?us-ascii?q?A2AfAACMx1tcgEinVdFkHQEBBQEHBQGBUgcBCwGDOjMnhAO?=
 =?us-ascii?q?UCIINkwKFD4F7AQyEbAKDGiI1CA0BAwEBAgEBAgETAQEJDQkIJzGCOikBgmYBA?=
 =?us-ascii?q?QEEIwRSEAsLAwYBAwICHwcCAiISAQUBHAYTCIUeBaB5PIsbfDOIWQEHgUsSeYs?=
 =?us-ascii?q?4ghaEI4gKglcCgSwBAQGKUIU7kU8BBgIBgWWQYBmBbIkCh2Etm2MPIYEnA4IJM?=
 =?us-ascii?q?xolfwZngU6CUo4sITCOegEB?=
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; d="scan'208";a="27242915"
Received: from mail-lf1-f72.google.com ([209.85.167.72])
 by smtpmx5.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 06 Feb 2019 21:53:28 -0800
Received: by mail-lf1-f72.google.com with SMTP id m10so1368117lfk.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 21:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OuxZLL8UNbVQzWmaxCNdMvTP4WXTa93NPRnjzawF7/s=;
 b=RxwHPoSVLgyphul0ZYptisl7Xd0QWCF+sv/lzo3N9kCSQm2UPR6gRMX2RLZZpbO4Ii
 Y1HcSfTO6Buf0ViOKR3E0cbKJbQquAj+iKgKDgxtxavCHXfdBQl4Y0BBJwmBJpF0lJYi
 YDB8C9eCuSbs3TlkuYqJ+4dOs6qVv6oEEqQTFWOyUKl74m+AgPI+RTJzjCLgEFVWGYyA
 DhjS2fe8NnEFbFGy2q47AHGLz5RcdvGjn7R6nEDleXT7vlWLLxFTzPj02MEMZ1yb5L7+
 jOJfea97AbxyZekbEalJDEnr/ss2b8ulYuGdBwf/uPs83wsXAPaDmmX/WgUpnNXAB97t
 ZIJA==
X-Gm-Message-State: AHQUAuY2E4sJxfWbR32V9L3sJW4cXit11GHxRTsR+LihC8r9X0VqwXCp
 KCtwyPqyBuPy3zEXA6IjOW/WLXSa2SDrVW12pnqfH7vPBiDjbQ6aGuZ6u6aoRF4Nc82Mr9A/p+j
 KND9evvCP5sQkxEK2gG17MmwOc6hw02dCTyxiM9uk7Lgk4lCRJ3Hv
X-Received: by 2002:ac2:5230:: with SMTP id i16mr9363075lfl.54.1549518807246; 
 Wed, 06 Feb 2019 21:53:27 -0800 (PST)
X-Google-Smtp-Source: AHgI3IadxvbDND8MVfG27lQv3DRXo1BjCd90b9Zx/Nd0gufYIjmXU1K/Fcm5NdhEj+YyxeekYEbWramdvbOF7CR0gnQ=
X-Received: by 2002:ac2:5230:: with SMTP id i16mr9363057lfl.54.1549518806961; 
 Wed, 06 Feb 2019 21:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20190205221559.17545-1-yzhai003@ucr.edu>
 <20190206.201736.1146228626076916564.davem@davemloft.net>
 <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
In-Reply-To: <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Wed, 6 Feb 2019 21:53:16 -0800
Message-ID: <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
To: David Miller <davem@davemloft.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_215330_609060_34C78DCE 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Chengyu Song <csong@cs.ucr.edu>, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks, but why initialization matters here? Is performance the main concern?


On Wed, Feb 6, 2019 at 9:52 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
>
> Thanks, but why initialization matters here? Is performance the main concern?
>
> On Wed, Feb 6, 2019 at 8:17 PM David Miller <davem@davemloft.net> wrote:
>>
>> From: Yizhuo <yzhai003@ucr.edu>
>> Date: Tue,  5 Feb 2019 14:15:59 -0800
>>
>> > @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
>> >       struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
>> >       struct device_node *node = priv->device->of_node;
>> >       int ret;
>> > -     u32 reg, val;
>> > +     u32 reg, val = 0;
>> > +
>> > +     ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
>> > +     if (ret) {
>> > +             dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
>> > +             return ret;
>> > +     }
>>
>> I agree with the other reviewer that since you check 'ret' the initialization of
>> 'val' is no longer needed.
>
>
>
> --
> Kind Regards,
>
> Yizhuo Zhai
>
> Computer Science, Graduate Student
> University of California, Riverside



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
