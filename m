Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CA5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C782321019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UWfMgfcF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwQLCWkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C782321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:From:Subject:References
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U35eoTtOQLXLbvW3IpaxTe6ALa73/9jcaFx0e0Ne8jI=; b=UWfMgfcFIcbtp4
	bH3AMcHgfZm0R9e6YN3ORLoB+ZrntEph+J5VPH7VotDR9+dc7pd7pZ6huWzryu/4tM68W3/OXvOLD
	jMvms79A/o5S13H/heL9tGSC11hlaS1Xx2BqvLkYfnmYosaRC8gh1LGGnTCE1iYsM9rEx7Ezq3jBK
	NQPR9juu/TWtqSyNCjokj15ybrutHDutLdN7+WdCI3/LpUn6VlC69qV3PqPQscBRx8pu1aMuNx6zK
	6WfK8OCiE11qAGmdirXLtp6ojS65zeGJlD5SMWDg+a6YIDAhr1ZPFDgz7TvMNMuvGq9rm5f587OZB
	H8f4B/W2w4sdPN342k8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm153-00077Q-53; Tue, 22 Jan 2019 18:47:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm14z-000774-Kl
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 18:47:22 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B35921019;
 Tue, 22 Jan 2019 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548182840;
 bh=B0qFCitpNOkldy2prRrLmaRakaVyE82MIc/M0eFZCzQ=;
 h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
 b=FwQLCWkwXzubKhS4PZNrR9G+gxv+hmKTkZFPL9xxfnwn83x67JDOVbyRrTmZZTmI3
 tlZ5x5xomXdNDndus56H9qwDnbBaSZWmf/xvf9mKE+7bsWzMiTN1Ferur04x1hVAxJ
 9FldOyjbNgZfXWXCc+lUaCyLaoDYaggOsHOz2x7U=
MIME-Version: 1.0
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
In-Reply-To: <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190117063312.GE25498@builder>
 <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org>
 <20190117100807.pmew5iqisdcc63eq@vireshk-i7>
 <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818283956.20280.2895221927807522124@swboyd.mtv.corp.google.com>
Date: Tue, 22 Jan 2019 10:47:19 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_104721_697115_8547DD4E 
X-CRM114-Status: GOOD (  19.25  )
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
 mturquette@baylibre.com, will.deacon@arm.com,
 Bjorn Andersson <bjorn.andersson@linaro.org>, david.brown@linaro.org,
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

Quoting Jorge Ramirez (2019-01-17 02:46:21)
> On 1/17/19 11:08, Viresh Kumar wrote:
> > On 17-01-19, 09:38, Jorge Ramirez wrote:
> >> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
> >> to disable the clocks that were enabled by the firwmare and not by the
> >> drivers.
> >>
> >> the cpufreq driver does not enable the cpu clock.
> >>
> >> so when clk_change_rate is called, the enable_count counter is not
> >> incremented and therefore it just remains null since this was enabled by
> >> the firmware.
> >>
> >> I tried doing:
> >>
> >> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> >> index e58bfcb..5a9f83e 100644
> >> --- a/drivers/cpufreq/cpufreq-dt.c
> >> +++ b/drivers/cpufreq/cpufreq-dt.c
> >> @@ -124,6 +124,10 @@ static int resources_available(void)
> >>                 return ret;
> >>         }
> >>
> >> + ret = clk_prepare_enable(cpu_clk);
> >> + if (ret)
> >> +         return ret;
> >> +
> >>         clk_put(cpu_clk);
> >>
> >>         name = find_supply_name(cpu_dev);
> >>
> >>
> >> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
> >> the system wide consequences of that change to cpufreq.
> > 
> > If the cpufreq driver enables it then it should disable it on exit as
> > well, right ? And in that case if you unload your driver's module, you
> > will hang the system as the clock will get disabled :)
> 
> ah, of course, sorry was over-thinking this thing :)
> 
> > 
> > Every other platform must either be marking it with CLK_IGNORE_UNUSED
> > or they must be doing clk_enable from somewhere, maybe the CPU online
> > path, not sure though.
> > 
> 
> since this clock is enabled by the firmware, it seems to me that using
> CLK_IGNORE_UNUSED remains the best option.
> 

What do you do about CPUs being offlined? Presumably when the CPU is
gone the system doesn't need to keep the clk enabled anymore.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
