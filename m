Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40ADC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:49:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C6A2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dSzzpvyj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="rpJaju1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C6A2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucr.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1EwUErysaaT7DAnuu7vswCQG8wZjEQmgdGYmgNhWWpA=; b=dSzzpvyjkFcMFW
	RDORx82wHxqiu7leBBmBhEz9TgP2uHPFO1SEXfm9l+C50O7hDWV0L/FuNt+t8QQHMjfeuI0c513pY
	9mqslZ7eyW5I0qJaTYSAfPNoFI5wVfk9KflJGJglbSwhW4WxyLpOoo//cfmMyXo6SQc9yi5gnj5/k
	TpNZ/lKh6E/ddQPhGdIAnFeoT2s7E7GQYFzGnp50OzAuP8CzZtb7HLM9gSwZ1OMokgwySNp2poYzg
	pLJ2rmqnY9OVMCoa+VGHtEJRGF0WUTPn1vmSJI+xYvWp2H0APgIpVUqfvBOAfB20Gw/6zSv1TPMbU
	ZK1S2ELZHMS/BGQUk7rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grnnK-0000vI-GF; Thu, 07 Feb 2019 17:49:02 +0000
Received: from mx3.ucr.edu ([138.23.248.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grnnH-0000ur-Az
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 17:49:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1549561740; x=1581097740;
 h=mime-version:references:in-reply-to:from:date:message-id:
 subject:to:cc; bh=wuiY8Nk6o96T4mTY1kEf70rq4e+8LiMSrTquEoIWaeY=;
 b=rpJaju1D9rB6AQ4O957SpC/nztgmmT+3FBrni0GiYKVRJB4W5arhhK3V
 zKFgj4OPTR23Xgyk60UZozWFUBCy1RrbZp/IIgTiDDJtptSMFcFQplFqC
 JnCn0vaxJa2AP45C6fzFep7y8cwfQvb5GPpusQdXHuveBErioaGR6UpMQ
 52GLT4h3f2wh2FhizreP4K27aHtSSbzs7iK6UpNVrfE+UqDgOqhVUip50
 T6+P01av7dQ0t0R25s7F+4FguOxfnMl5Fi6Ie2j5LG1L+86ZYksl7sOYP
 5SKs0ALmDgkib4oXmo/Nu1LhVv447mT+qvyH72+uMKbvEzvNkt9Q87Gy5 g==;
IronPort-PHdr: =?us-ascii?q?9a23=3ACD3sIRLVDK3GVqtjGdmcpTZWNBhigK39O0sv0rFi?=
 =?us-ascii?q?tYgeKf/xwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD4+ou?=
 =?us-ascii?q?JSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgpp?=
 =?us-ascii?q?POT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0AHJonxGe+?=
 =?us-ascii?q?RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L281/szrugLd?=
 =?us-ascii?q?QgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUjq+8ahkVB7oiD?=
 =?us-ascii?q?8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfFjfK3SYMkaSHJOUcZfVSNPAo2y?=
 =?us-ascii?q?YYgSAeQfIelVtJX9q0cUoBeiGQWgGOHixzlVjXH2x6061OEhHBnE0wwhHtMOsG?=
 =?us-ascii?q?nUrNLoP6gRUeC61qjIxijEYvJW2Db96JLHchE9rf2QU799atfRxlU1Fw/fkFqf?=
 =?us-ascii?q?tJHlMiqT2+8QvWab6O9gWviui24hswx+uT+vxsAwionNh4IVzErI+jl+wIYwI9?=
 =?us-ascii?q?CzVU11Yca8HZdOqy2XM5F6T8AiTm1ypio21r4LtYSmcCUOy5kqwQPUZeadfIiS?=
 =?us-ascii?q?+B3jUf6cITJ/hH14Zr2ynw2y8U28yu3kUcm0zUpKojJFktbSsnAN0ATe6s2dRf?=
 =?us-ascii?q?t8+ketwDKP1wLO5u1dL0A4iK7WJp07zr4/kZoTtkvDHivol0nskKCWcUAk9vCp?=
 =?us-ascii?q?6+ThfLrmuoeRO5Fohgz6KKgjmcyyDf4mPgQSXGWX4/mw2bng8EHhRbVFlPw2kq?=
 =?us-ascii?q?3XsJDAIsQbo7a0Ag9U04Yj8Rm/Diuq3MgWkHQcMVJKZAiHg5L3NF7TPfD0Fe2/?=
 =?us-ascii?q?jEi0kDd32/DGOaXsApHMLnjFjbfgcq9x5FRGyAo21Nxf5IxbCqsHIP3tXk/8r9?=
 =?us-ascii?q?jYDh4iMwyo2ObrEtR91oUQWWKVGKCWLb3dvkWV6e41JOmMfoAV637BLK0A7u7v?=
 =?us-ascii?q?iHJxo14FdLOllc8SYWC5G/kgOUSBaGDgqt0GFnsOvwx4R+vv3g6sSzlWMkezTa?=
 =?us-ascii?q?Ih4XkJCIunRdPSVICkgeTZhw+mFYcQa2xbXAPfWUz0fpmJDq9fIBmZJdVsx3ld?=
 =?us-ascii?q?DeCs?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AFAABIb1xcgMbQVdFkGwEBAQEDAQEBB?=
 =?us-ascii?q?wMBAQGBUQYBAQELAYJqgQMnhAOIGotvgg2TAoUPgXsBDBuEUQKDKCI0CQ0BAwE?=
 =?us-ascii?q?BAgEBAgETAQEJDQkIJyUMgjopAYJmAQEBBCMEUhALCwkBAwICHwcCAiISAQUBH?=
 =?us-ascii?q?AYTgyWCAaFZPIsbfDOIWgEHgUYFEnmLOIIWhCOICoJXAoEsAQEBilCFPJFUAQY?=
 =?us-ascii?q?CAYFlhVKLDhmBbYkDh2UtjB6PSQ8hgSWCDjMaJX8GZ4FOglKDOIp0ITCOegEB?=
X-IPAS-Result: =?us-ascii?q?A2AFAABIb1xcgMbQVdFkGwEBAQEDAQEBBwMBAQGBUQYBAQE?=
 =?us-ascii?q?LAYJqgQMnhAOIGotvgg2TAoUPgXsBDBuEUQKDKCI0CQ0BAwEBAgEBAgETAQEJD?=
 =?us-ascii?q?QkIJyUMgjopAYJmAQEBBCMEUhALCwkBAwICHwcCAiISAQUBHAYTgyWCAaFZPIs?=
 =?us-ascii?q?bfDOIWgEHgUYFEnmLOIIWhCOICoJXAoEsAQEBilCFPJFUAQYCAYFlhVKLDhmBb?=
 =?us-ascii?q?YkDh2UtjB6PSQ8hgSWCDjMaJX8GZ4FOglKDOIp0ITCOegEB?=
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; d="scan'208";a="29846860"
Received: from mail-lj1-f198.google.com ([209.85.208.198])
 by smtp3.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 07 Feb 2019 09:48:57 -0800
Received: by mail-lj1-f198.google.com with SMTP id g92-v6so153316ljg.23
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 09:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2h+KsTudxCs800rU2F/cFHz14DOKXOivwjGfmboDlkE=;
 b=nCYrY+CuE179MXY5WBXSiYviHg6yw0llB92g2hJdNigUxV0I9mw1sEF5uo8htJC3jz
 xlmro6UqN4y8PWNXJx9IeVV+h+rcFU7gKzD8jJ8F+M8JFe10OGCPHfTiz+koAOCT0vNi
 Py41NsxKUm01EUFHrYAl0kdxX7qmzmajZFhvqm6m+C8s8QKiifei7odDbcubEIbrzWGL
 kAwxWvdxR47LLLLKgEKg92JeAtGb7rbMme4IP/sP7tXBRHmT1R09bGuRMI1vJFYO66J7
 cXEyaWe9iNdNkv5YetOepvlNk0rDSpT8b735Tf1IHji44o36r/1FKbsgUr/ShGEOEDhh
 xW7g==
X-Gm-Message-State: AHQUAuYIOoRGIPxm3ZPixfnCiCELdPmk/j6lChQKwNNvl39z5YLISLG7
 rTk5wIk0f4R+Jsymci2OjtXP3pJaxZR8B0f3AGNhbDMkWjRJ/DboYlW9dqXkX2wdtOv7p6puVnm
 XWklkyb5Ol4fXlWaRkeLjwO9XUulp25ZLGObX6ntj8XcgjXKIEYvw
X-Received: by 2002:a2e:9001:: with SMTP id h1-v6mr6632009ljg.28.1549561735399; 
 Thu, 07 Feb 2019 09:48:55 -0800 (PST)
X-Google-Smtp-Source: AHgI3IamVMZFGgUaFIvn9Hr4bdJczD7GZBgzjH9AtRDyXSsBe1CW9j8HHFL/FcBnOQkrEsCWUobngCvfjPanXUy/lrg=
X-Received: by 2002:a2e:9001:: with SMTP id h1-v6mr6631981ljg.28.1549561735019; 
 Thu, 07 Feb 2019 09:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20190205221559.17545-1-yzhai003@ucr.edu>
 <20190206.201736.1146228626076916564.davem@davemloft.net>
 <CABvMjLQ6MYtGYeLxwceZsvcyn4oScgMo+BGQMHw7SkZ1uxFmHQ@mail.gmail.com>
 <CABvMjLTymaszPdX5afOHFfFBS1AueVzRVra5_QUr144GahH5gQ@mail.gmail.com>
 <20190207092454.xq5jvnfnuhcp37nm@flea>
In-Reply-To: <20190207092454.xq5jvnfnuhcp37nm@flea>
From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Thu, 7 Feb 2019 09:48:41 -0800
Message-ID: <CABvMjLS2ftUgxeKNxQW2npxKRjM3_=U7qg7oYTw6VrkUWcOocw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_094859_404056_5A01AE8E 
X-CRM114-Status: GOOD (  17.63  )
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
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make sense, I will send the new patch. Thanks for the opinion.

On Thu, Feb 7, 2019 at 1:25 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Feb 06, 2019 at 09:53:16PM -0800, Yizhuo Zhai wrote:
> >
> >
> > On Wed, Feb 6, 2019 at 9:52 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> > >
> > > Thanks, but why initialization matters here? Is performance the main concern?
> > >
> > > On Wed, Feb 6, 2019 at 8:17 PM David Miller <davem@davemloft.net> wrote:
> > >>
> > >> From: Yizhuo <yzhai003@ucr.edu>
> > >> Date: Tue,  5 Feb 2019 14:15:59 -0800
> > >>
> > >> > @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
> > >> >       struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
> > >> >       struct device_node *node = priv->device->of_node;
> > >> >       int ret;
> > >> > -     u32 reg, val;
> > >> > +     u32 reg, val = 0;
> > >> > +
> > >> > +     ret = regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
> > >> > +     if (ret) {
> > >> > +             dev_err(priv->device, "Fail to read SYSCON_EMAC_REG.\n");
> > >> > +             return ret;
> > >> > +     }
> > >>
> > >> I agree with the other reviewer that since you check 'ret' the initialization of
> > >> 'val' is no longer needed.
> >
> > Thanks, but why initialization matters here? Is performance the main
> > concern?
>
> Not really, but if we turn this the other way around, why should we do
> something that doesn't bring anything?
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
