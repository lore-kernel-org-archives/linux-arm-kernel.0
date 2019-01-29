Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C330C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2998820869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OD1pp6mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2998820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ho1P+MSu7uE9dUfeXE1ZZsg65CR2w/jLq9Fn5YSG0nU=; b=OD1pp6mmemNU+E
	AjKiL8R9bR9xk0ZrU5E4EUalqbWvz724rWhpXV3+CyOwYsVOA4s77pQGX3WxyBMsQDAk89gF8hnql
	F0XmClKjGh2alU+T2mL0cLKm/wJHJbudXyZks+yjrKqFJKK4sZvPA361c8vCgwA3J7eKXtPBqbKWj
	yzVZw7PTL0BjgvwE80v2+rp8Lcv0Q39ozxguMNBqlRzExt8yTq4dK0kIJlzSl2wwlXlRlMEMSOsU4
	3wBl1elD6X5dAeH6fSa9B8UN93FtouAE/syH50sDChQJA7s+DSEVSyjnnfXd4xHy7gJA6JGvjJ58+
	Ssh0cqpaJgTkeu/LNoNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQeA-0003bt-8J; Tue, 29 Jan 2019 10:29:38 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQdz-0003Nt-9B
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:29:31 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 754E613F8B5;
 Tue, 29 Jan 2019 11:28:36 +0100 (CET)
Subject: Re: [PATCHv5 0/7] Add coresight support for SDM845, MSM8998 and
 MSM8996
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Doug Anderson <dianders@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, DT <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <6994f4cc-e1fe-d418-1b6d-8b00bf9fc042@free.fr>
Date: Tue, 29 Jan 2019 11:28:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_022928_083685_330046BE 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Tingwei Zhang <tingwei@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 28/01/2019 20:13, Sai Prakash Ranjan wrote:

> This patch series adds support for coresight on SDM845, MSM8998, and MSM8996.
> 
> Patch 2 adds device tree nodes for MSM8998 coresight components.
> 
> Patch 2 depends on MSM8998 rpm clocks and rpmcc nodes:
>  https://lore.kernel.org/lkml/1545099336-5615-1-git-send-email-jhugo@codeaurora.org/
>  https://lore.kernel.org/lkml/8f431bde-0e67-8088-5119-7a951d0ead52@free.fr/
> 
> This patch series has been tested on SDM845 MTP and MSM8996
> based Dragonboard 820c and MSM8998 MTP.
> 
> v5:
>  * Added coresight support for MSM8998.
>  * Added ETM PIDs for SDM845 and MSM8996 as suggested by Suzuki.
>  * Added UCI table for Coresight CPU debug module.

Great! Thanks :-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
