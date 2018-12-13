Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F00C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:32:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15FB20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BPWRdBJy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bsyhEeRc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp6jCjzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15FB20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Or98BZubOk6qwS5jPNJFMAXvAVHJSdsvxW40RTbntQ=; b=BPWRdBJy/4fMvl
	xe6tTCxX2BLjKJ4f+vNBR/VL1N57xrumCIUjeowJ0Ucrk6wDP1T02jYaxmk1vaR2odjx+Cq7DV2Y6
	BKFmUJiu/NQ99Wt2HjeLnjttCxaZ9eCxNJei0h4lK1u9kibfkiFAHV3n5DOohGYiLXebcGNhRVljq
	f96Fs3jty4SR7R46SsywJx84LH9oIa6dxhOnxmXaggqPq0nXplYgJOXDYnthFxDm5rqWA3ztILeQU
	rDT2weKADBfNuruY0uxHHiM2VHY0JWtql52KiAV8lmvRuMCX6M05p99fb3MkXK54K6hQDVSiFBLmm
	kaPFD1faDR2OOpzwV24A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLTY-0001n9-I2; Thu, 13 Dec 2018 07:32:04 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLT8-00014S-Rd
 for linux-arm-kernel@bombadil.infradead.org; Thu, 13 Dec 2018 07:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y2kHRCe58c9v46VIIcMa9fm4dQXvC8hNN00ujy31Qaw=; b=bsyhEeRcd9hWITy+UW/19LPwM
 AKCcyPea5a9gaMqfeRiF6MiuvQh0zTtit1w2x4shyhV8gMKGN3d4oZwTY4/F1pmOwrJjczIwY6Fia
 //nA9vHrgcElgKC6Lymt2d6g6s39sFJ7A9lFCsIBHe+qhpy0GZPQQ6F7vyWrXLi8bFlx5wNZtat8+
 5AffMBwHWNhngFF31FTorjr5nb7Na74AQ5oK2FK5IEX46if1Yovumx00jYlBvULDXcbIb/s5IXc27
 1lSzzQtCGLOSt6MEhgKUO56pHYtHXP8NpZXx46pTTTS8gYbhYFWcN/aJVC4ggsnTZcol9W24NZFFe
 YX+4dSk2Q==;
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKeK-00011A-94
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:39:09 +0000
Received: by mail-pg1-x542.google.com with SMTP id z11so582974pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=y2kHRCe58c9v46VIIcMa9fm4dQXvC8hNN00ujy31Qaw=;
 b=Pp6jCjzSOVArDoqkbLaWwwgOxbGhlp4LFZpghBSlTWS1qwpEZl3GiARupGL20HK4y6
 aSlS3p0+z6jSzVlQ82f9m8BaqX3UUo7vvIjd56dk5efmTzJdIfqHtU4t5F2TsLi9BiRg
 w565YsTqR9Z8Ozx0GL4yVG1vNwo1y/oCRcHg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=y2kHRCe58c9v46VIIcMa9fm4dQXvC8hNN00ujy31Qaw=;
 b=NJcIxhwpRVIXod7YYGfMftUANH9XGmkIxczamU9IzVneNdVyZ6A+rv1xWEcj49AqNY
 ZBrc8r30l7jM5/9WAJOqJ5jiY7FXJo8dHLeEoy93v3bm+H9zG+P/LHUfvWy6kYzRM9XS
 c7VfPzkcLeu4HnuVmoJqe9HajqcAkYxhinC9DAqTQXZucp9zOJh+bFbykG8xxasRXHO1
 CrC+WH0/OK8VvLQBtuI91Yeu0vkI2kt0h0qYSthKYfA8XSHgF6ES53Kts59vA6INvWee
 F07RxmvqphNDenwbKPbPq+bkQJSYnI36BaoIzMJlTDSUAtFmiDm5EGaGjPWrVBWU/rAM
 05hQ==
X-Gm-Message-State: AA+aEWa73bW+x0Mk8lwB19ygzPuTPb8Sy5RzZEnWsmOzSPkczskCZng0
 69udbKKrKByWrQ00IzbvGkyuwQ==
X-Google-Smtp-Source: AFSGD/XOQuL/1A9Y4B3GFM15NdVwmsJ6P6av5X7hZyZH4lCR7UALhXSTine+KSFQh0rLj+I60Xz9wQ==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr20522058pgi.8.1544683133055; 
 Wed, 12 Dec 2018 22:38:53 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id w185sm1188877pfb.135.2018.12.12.22.38.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 22:38:51 -0800 (PST)
Date: Thu, 13 Dec 2018 12:08:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nick Fan <nick.fan@mediatek.com>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Message-ID: <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
 <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
 <1544445372.3502.42.camel@mtksdaap41>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544445372.3502.42.camel@mtksdaap41>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_013908_340870_F2886CEC 
X-CRM114-Status: GOOD (  15.96  )
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
Cc: Nishanth Menon <nm@ti.com>, Chiawen.Lee@mediatek.com,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 erin.lo@mediatek.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10-12-18, 20:36, Nick Fan wrote:
> For the users who only use one supply, they can use
> dev_pm_opp_get_voltage to get the voltage data from an opp.
> But if the users who use more than one supply, they will need this API
> to get their voltage data from OPP.
> The users should know about the supply count while creating opp table by
> using dev_pm_opp_set_regulators function.
> By using this API, the users can get the voltages by using index to
> specify which supplies they want.
> 
> The following is a simple example to get multiple regulators by this
> API.
> for (i = 0; i < regulator_num; i++)
> 	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);

Fair enough. I couldn't find anything wrong with the patch. Will it be
possible to send this patch as part of a series which uses the new API
? So that we are sure of somebody using it eventually.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
