Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA60C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0225621927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwytjtz3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jntpyoWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0225621927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:In-Reply-To:
	From:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LbF5J20HY2KnTEkGIaq3Ox6pVGsXIHQabHMIUdazRsY=; b=bwytjtz3YaCzA6
	S7hADpuehJS/FZsWYELJWhw02VrYJ0gCCCB0owoigVFW4dVzr9wQWciiPD8DE6kO8jpNDbbXhafwg
	nZnJP4pnVZ1KtNkhgmwyrPCSIH1N6VA4ytti73EGU405oRNHl1rCSW580MMsOfyRnwvyFF7eRITHH
	oFegRODfyFs8kgYsk3OJklH6CVLnHHDfrYQhkfw0M2gqPHf7B1M8GC6myWVWee+/zxfkV/JshiAyk
	4CY19z0woSkYN0DFKO8EShC5LV89dXIPPvaN9MUbUc/D6zqUTis7V9FwZDVWNCPrbxnZ4RLe+XpA9
	rRObV37XBJgLXpykqyNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaShn-0005MG-9U; Fri, 21 Dec 2018 21:51:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaShj-0005Kv-US
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 21:51:37 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 59CFA21927;
 Fri, 21 Dec 2018 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545429085;
 bh=SjHlVTvrZg8PN3rMMMnqKhe/vbtxJDTRrZatwEU/qaE=;
 h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
 b=jntpyoWLZm9jD+4De/drzSbnqakk+eDtFIb52DqaOI19a2OlBXfQ1IxIg1yliyxrk
 fg6pmj9sIhQWK/L3xiuMAmD2Mn8NpW5Jh66fLXVzZ32bdpxPmhOP/cRRRMM4f5egw5
 GqTvaUe0E+m0Sfh31xmqKNu4zku8zOytC4E7hVL4=
MIME-Version: 1.0
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <914bd56c-4470-4f78-75ac-f7bedd83d7c0@linaro.org>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
 <20181221192823.GA9704@minitux>
 <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
 <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
 <914bd56c-4470-4f78-75ac-f7bedd83d7c0@linaro.org>
Message-ID: <154542908449.13075.11379256415955338261@swboyd.mtv.corp.google.com>
Date: Fri, 21 Dec 2018 13:51:24 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_135136_003789_D0473C6A 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: mark.rutland@arm.com, jassisinghbrar@gmail.com, heiko@sntech.de,
 mturquette@baylibre.com, will.deacon@arm.com, david.brown@linaro.org,
 linux-clk@vger.kernel.org, olof@lixom.net, jagan@amarulasolutions.com,
 andy.gross@linaro.org, sibis@codeaurora.org, devicetree@vger.kernel.org,
 arnd@arndb.de, niklas.cassel@linaro.org, robh+dt@kernel.org,
 horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, vkoul@kernel.org,
 enric.balletbo@collabora.com, georgi.djakov@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez (2018-12-21 13:45:41)
> On 12/21/18 22:40, Stephen Boyd wrote:
> > Quoting Jorge Ramirez (2018-12-21 11:45:28)
> >> On 12/21/18 20:28, Bjorn Andersson wrote:
> >>> Perhaps there's a better way to define that this particular clock
> >>> hardware can change rate, but in this implementation it must not?
> >> the initialization for this particular PLL on this particular platform
> >> is wrong
> >> as the interface does not apply to the platform needs even though it is an
> >> alpha_pll
> >>
> >> if the VCO is not an option -even though it reflects the platform
> >> constrains-
> >> I would suggest nullifying the alpha_pll_ops that do not apply to this
> >> platform:
> >> ie: set_rate, round_rate set to null in the probe.
> >>
> >> allowing the interface calls (ops) to go through to later on make them fail
> >> based on some setting would be fundamentally wrong IMO
> >>
> > We have clk_alpha_pll_postdiv_ro_ops so maybe just add another set of
> > those for the alpha_pll itself?
> >
> >
> 
> something like 
> clk_alpha_pll_fixed_ops?

Either way works. We're not consistent in naming now that we have
clk_alpha_pll_fixed_fabia_ops.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
