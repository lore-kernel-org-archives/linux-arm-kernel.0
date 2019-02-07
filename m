Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02336C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:08:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C252084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rELUJxJJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCsh2wOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C252084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=42REiBqF/orP9qBtUwvj27TOgN2WM+g8BhaYL+pCOLo=; b=rELUJxJJZvwkqA
	jfQ26ssX7t6VmsQUOIxSBKWs8iTgU7vuzbeG6YP9Kc1SWJ2rQ97pNumJRfGCi/pDQa1op9Ie2M/2P
	16J1SgUMiP3oy1f0GTGop3Xly0B0rh5hcc4+4NJ7GMIKczMSfw19DGHNnrphKcF5aBRZI15IHrCVG
	nU3+m+6+0BUqijc1+0r+tYG+tgBs8zXh1+yyFOrJp1RwQVvsAZ/nv9X6gXJDSfmbstYz5ebHoD2Ub
	uVYpm3FJv4nADPRNdkEo2jDznfdXf1qMQ0n1rFzAe8IvjUZIfSG06QgKoOI3gIRFqdp+lr7v5XYZ2
	+gtwNJDcGwyQ980HrMlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grayx-00007m-Uj; Thu, 07 Feb 2019 04:08:11 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grayu-000076-Q9
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 04:08:10 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so4169739plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 20:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Oe6CHy5kVVxLnzuV/JO6wOHCV2blRstih5wPBxrJ8o0=;
 b=kCsh2wOs8jp8h+ZOJhfvTVfG07C8yWJrNOBx3ZTwwptp6bmL8VoxgOkovzTJEKu6k/
 /8wjVei/dMPiXtEzT8DddaQUKWAhP/jMgaPfIeeTLvdJ73XXJkuNIqjOMlUl0uiu6L+O
 R0TM7RmSD5XzDb9YPpRMm0PDJ0PGv3ksbOeoopBG5dzzAZduzm48O8s+cBdUK2i3fxO1
 L84HQUWc4CExz77UH4M+TtjWJdQuftp6zdNGMNeph0lELyGruDwLifDL0KmTTwcEgzjE
 PmaowDpLpp/v2L6GVEEZPTE+fGDhXo0sd4p75RlVAi8whyGYjMxEKTlsrRsAokNkyb8n
 cPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Oe6CHy5kVVxLnzuV/JO6wOHCV2blRstih5wPBxrJ8o0=;
 b=HOQdy/2AfLtjNjTQweb6VycYoweGV/M2hl//w1j+AxgQ+X9dmX3e0ZpVAzhlU7cnEU
 8QYWtowWLIdhk8Phehu6UgRQoTnyIFWkmTnUroiI+ayj3gUcR7jJR6xUUvz2sMC/zHq/
 24ZLvznbjwf98WqHePqynbKiWI4ctQmP4UI7F0NIQn+n8KdPT9LCFq5qbH5HVl89S4v8
 98VDwFbdaMd23L84a/vps31PYLAhBrtIPYJQV57Rqh/0hknWwy5zafWfoYZM1A5euTyh
 73WYsEsP0Pn8W1OlpNtXdL8YH2kA4AAEfxJ3JF0K+gev/6DbTxk9bHz5FGADut8w6YbS
 CVBg==
X-Gm-Message-State: AHQUAuapd+5BRkFLhFaNWTze0+bPJymLJ/uDOSmM1MHGuHQgGcsZSFC8
 wtWo+2MjrgTBUAlVYZsNYnhw4Q==
X-Google-Smtp-Source: AHgI3IYBrG4YfPCSVfMNpwUv4aEIummWC8IQbiiR9AFRu4hbiwXG3SfHj8Iv4v/j5MwpXnpOr4xZxQ==
X-Received: by 2002:a17:902:9a04:: with SMTP id
 v4mr14668526plp.34.1549512487925; 
 Wed, 06 Feb 2019 20:08:07 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id 125sm10293184pfg.39.2019.02.06.20.08.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 20:08:07 -0800 (PST)
Date: Thu, 7 Feb 2019 09:38:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Register an Energy Model
Message-ID: <20190207040805.og4t2s5ycuy6hqab@vireshk-i7>
References: <20190205175225.25923-1-mka@chromium.org>
 <20190205175225.25923-2-mka@chromium.org>
 <20190206101316.fr7z4ffr4ck4l4aj@queper01-lin>
 <20190206181659.GI117604@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206181659.GI117604@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_200808_880367_9F442F05 
X-CRM114-Status: GOOD (  11.82  )
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
Cc: Taniya Das <tdas@codeaurora.org>, Nicolas Boichat <drinkcat@chromium.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Quentin Perret <quentin.perret@arm.com>, CK Hu <ck.hu@mediatek.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 06-02-19, 10:16, Matthias Kaehlcke wrote:
> You are prefectly right, I missed the obvious and didn't get my hands
> on hardware yet for testing.
> 
> So much for screwing up a one-liner ... I'll send a fix.
> 
> I thought Viresh already applied the patch, however in opp/linux-next
> I currently only see the other one of this series for qcom-hw, so it
> seems sending a new version rather than a fix-up patch is the way to
> go.

Yeah, I dropped it after Quentin reported the issue.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
