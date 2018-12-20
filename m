Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A1C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB93218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k+UyOBum";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmKJjwcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB93218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:In-Reply-To:
	From:References:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9rvFw8fv6AhFVuz7J2lkgzSRrK8dxZbQZh49wrwQ7m4=; b=k+UyOBum2m2x6Z
	JM2+pqwGLDUxBg61PGMDqalWzk6r+rIoIGhlTbqruZAm7J3jiNo4Js3kKjr2DM3FTvQ+MJam8pMVX
	POyZ1nNR7Bd6pCvuHbZ3GAiwf8A64NVO4/9d+BkjoSwJoxyD2pgW30UKklWokLXiqySIunQEvRr0J
	ivNsHIi1BAUdAXwHYYVN4I2JPUz9LTepLOHVCUKJWOWeHDqTMxHAi4mMcN6JbDKGEEGxnBy5d6IRe
	geGeJX4jAMI0fij6gyBvE7KzMWKq0qQ1nlJvOUZDi9c2tL66dS8nTjfi4mlltwUjH1VdQp7dgJmgp
	PSZr1pfkhfrQ9qjVTqoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5sx-00043o-CM; Thu, 20 Dec 2018 21:29:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5su-00043E-0s
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:29:37 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 67BCB218FD;
 Thu, 20 Dec 2018 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545341365;
 bh=Dl8DOYh/b7CRPtadZsvpEbvdNERh69od+vePd7r9pE4=;
 h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
 b=pmKJjwcjGKnu4RMK46YsrCSLxOsXhlF7MA25PG2zr1MTEfisTUZprv6t4dApAthhT
 bTNTce6knM3a24sEVgML9ojTCehWJ3LvwnEd6pNDOdSQaz1eZiQJH/63N+ezHlcUpp
 S8DguDYp/2kQW4B6J3t5WNF9KQpw1tiXJydemovI=
MIME-Version: 1.0
User-Agent: alot/0.8
To: Doug Anderson <dianders@chromium.org>, Rob Herring <robh@kernel.org>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181217070647.xtvfgsixggua5yod@vireshk-i7>
 <CAD=FV=WKfKyZe6sc4drfa9kLQVbG1b9nCe6qbPmUPQGNEKAh=Q@mail.gmail.com>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
Message-ID: <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
Date: Thu, 20 Dec 2018 13:29:24 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_132936_101722_41220F57 
X-CRM114-Status: GOOD (  14.72  )
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
 Viresh Kumar <viresh.kumar@linaro.org>,
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

Quoting Rob Herring (2018-12-19 15:47:25)
> On Wed, Dec 19, 2018 at 4:40 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, Dec 19, 2018 at 12:40 PM Doug Anderson <dianders@chromium.org> wrote:
> > > On Wed, Dec 19, 2018 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
> > > ...but it does have a frequency, doesn't it?
> > >
> > > +   compatible = "operating-points-v2-qcom-level";
> > > +
> > > +   opp-710000000 {
> > > +     opp-hz = /bits/ 64 <710000000>;
> > > +     qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> > > +   };
> >
> > Ah, I perhaps see the confusion.  So Rajendra's usage of
> > "operating-points-v2-qcom-level" [1] doesn't have a frequency but
> > Jordan's do.  So I guess it makes sense that Jordan's have the
> > fallback compatible but Rajendra's don't?
> 
> Is having it useful to s/w that doesn't understand
> "operating-points-v2-qcom-level"? If so, then add
> "operating-points-v2". If not, then don't.

The only benefit I see in having "operating-points-v2" is that we don't
need to update the of_skipped_node_table[] in drivers/platform/of.c to
have all the variants of operating-points-v2-* when they decide to not
use anything from the "base" binding.

If that fails to work because opp-hz is required for the
"operating-points-v2" binding but sometimes
operating-points-v2-qcom-level doesn't require it I guess we need to
update the skip table or make some generic property like
'this-is-not-a-device' that these various data tables in DT can be
marked with so we don't make platform devices for them.

Regardless of the above, we should update the binding for
operating-points-v2-qcom-level to say that opp-hz isn't always required
when the qcom-level compatible is present. It looks like it just says
that it builds on top of the opp binding so that's not obvious.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
