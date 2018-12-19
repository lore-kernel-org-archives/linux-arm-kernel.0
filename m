Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EEDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:47:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7E520811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SZmyagsj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTAS3N+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7E520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jMNs8b/J9HAp6OhyzjOEICXahwED3aLdZc7AhMIwnbM=; b=SZmyagsjHBEONB
	YNGSShqLH13p/M+eoiKy82T3mQRo2sA/ZYaYlabS8JVkZIyZg02gCpyB7rCYp8HAf5HyaQPwnONdh
	ZNDbqm99RSNiWoiOS6u/GdxGu6WDZ01uiJXi+WXbE0g3BapnaDbY/4mUcz0b6EGIMvduMPtmGomEQ
	zQHRWB9OJFe31hdIxUto+wq1zfACTnVTRnKxOqlE0stWVVy06ss12fZf0VPp/d5ab6vfLdgoTfmg4
	S5FVXEUMFj3V2oJKQpJYd/wG0sjuOiExaAreLVVSXsXGWhDEyERtZF8lj5b2OdmpcmiD1LBSTf6Wx
	Fa0jGbX94it87+4IZ/fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZlZ9-0005lP-Fp; Wed, 19 Dec 2018 23:47:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZlZ7-0005kn-0k
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 23:47:50 +0000
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BD86B214C6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545263257;
 bh=SXSiVekyAbUJOIbafdqXVI9rqoo7zxRSFUUbmtF18iU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XTAS3N+ixbZBr9dsRVPPy8Y3nCKdc8yD1f4Ohor0hvdTBCYRyfqpG3KYJXHYI6C4T
 vytDZR+Jn7cWgLOuawYVbPsBO2TvjlSlzUU7CUjBSIDIFEHWAA9+6+5zrEVatxRd0W
 Mw5bi9afDwCAK8LCB7TwaRCnHc7XoDqEwqLWSA60=
Received: by mail-qt1-f179.google.com with SMTP id n21so24298735qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 15:47:37 -0800 (PST)
X-Gm-Message-State: AA+aEWY4sKFlBHTnio5cIgqaISDpdQLJmbbJTTJuGeVnUrHzkCGWsTsu
 WpRlaTp0FISxRciPTDC3LP9JFTqVS3YAEOU/5g==
X-Google-Smtp-Source: AFSGD/UaV/UBV+znJCs1q+BCVuKkYxiDTrU6s3NNo0sZOl0JoSbqpshPvuKm3vIE/iYOdfujoM0E17d5hOC7Mxeiq/M=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr23165023qtd.257.1545263256913; 
 Wed, 19 Dec 2018 15:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181212211848.26768-3-jcrouse@codeaurora.org>
 <20181214044057.wybv6wqg75qdnmic@vireshk-i7>
 <CAD=FV=VQEtQtnPJyo6vLm7ndPjowZ35FY-cibJyN_imZMoVU3w@mail.gmail.com>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
In-Reply-To: <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Dec 2018 17:47:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
Message-ID: <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Doug Anderson <dianders@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_154749_094804_BFE3249F 
X-CRM114-Status: GOOD (  20.79  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 19, 2018 at 4:40 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Dec 19, 2018 at 12:40 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Dec 19, 2018 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 10:49 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 18-12-18, 11:05, Doug Anderson wrote:
> > > > > OK, it's fine with me to have the fallback, but if we do we should be
> > > > > consistent about it and make sure it's in all the bindings and device
> > > > > tree files...
> > > >
> > > > Sure.
> > > >
> > > > I am not sure what's the right way to do it is, i.e. should we keep the
> > > > "operating-points-v2" string or not.
> > >
> > > Does having it buy you anything? Given the QCom one doesn't have any
> > > frequency or voltage, I don't see how it would be useful to have it.
> >
> > ...but it does have a frequency, doesn't it?
> >
> > +   compatible = "operating-points-v2-qcom-level";
> > +
> > +   opp-710000000 {
> > +     opp-hz = /bits/ 64 <710000000>;
> > +     qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> > +   };
>
> Ah, I perhaps see the confusion.  So Rajendra's usage of
> "operating-points-v2-qcom-level" [1] doesn't have a frequency but
> Jordan's do.  So I guess it makes sense that Jordan's have the
> fallback compatible but Rajendra's don't?

Is having it useful to s/w that doesn't understand
"operating-points-v2-qcom-level"? If so, then add
"operating-points-v2". If not, then don't.

I don't really care either way. Just don't do both ways and document
which way is correct.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
