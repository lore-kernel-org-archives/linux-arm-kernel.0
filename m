Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93481C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7FB2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K81II9MM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsLnOp1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7FB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x3IIz9vs/1bZDGLwjr/NBBqniHV9auliAIcth7ieyF4=; b=K81II9MMoIN0pr
	n3RzALTqZiGkey3I+IG6XU+nym3l22YRRJhXPj7BIc983C1GmjSXLpxXWU96kHaCSAUR+n7llzilW
	69/G7xQ6C7WZHFsRZRGE5c3L6gJenj1oUsGdQeneYnIvQURddqXBE2ynw8Fu7UsvJ4amHUwEC3NJq
	9Jp/k8YN/WLjJOylvUi3bbNDdCG8ng95Ik4upiVZrEuVTyhtP2C/ju74pr6AJ/TyQr4VNzCqJql6Y
	PPptDewcUtAsRnRrHzEnqiqpoDvrcmyzmpgd+cNgwxC0iI0ZrH4lGAMu2ywlixRU69y2F4FKTV95H
	R0AJRddiW7nc4uKXCyEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5yD-000406-GK; Tue, 04 Dec 2018 08:22:17 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5y9-0003xz-8M
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:22:14 +0000
Received: by mail-pl1-x643.google.com with SMTP id g9so7926682plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 00:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OpYTHvNyAWqgy7nsKPr+g6ey5sLKAIj6db+wtP/ieJ4=;
 b=LsLnOp1ucxff8wAVDb9EtqHTkoXGmp0WzHM2kMqaSq4KOFwj/mlXAX+PbDtlPnmEs+
 fYp1bichE0VrF9NMiuzQQ5SFDOqZmECkGW3SVDVITLgu/TlCCk9NdxglY736HeELlZkZ
 hoNt/lspVniUxWZqNMKZkenZf8wIQHNYto0vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OpYTHvNyAWqgy7nsKPr+g6ey5sLKAIj6db+wtP/ieJ4=;
 b=uUuuz2vNewOkuoVOGCM9R3TbYDPA32+x2qGgZitwrGMv49md2dtA8tefS3CoL2rtZW
 U46kpYNL/iJWgdDTdOnF3ffN3U9gS6uc8kkJOAyYVWnar/oFvnW7R2eFO30itPnpUqBO
 irdzjdkjieIxSYx7W8CejKj1q1n7I0xR+k6yDu4bPy/h1D3P+KSgKTXoJguzXU6T12UY
 Q6JMSjp/WAv4XRRz4S0IrNJy0NfTIFQL5kMTmVdAGGN+Y5UmXR17GMty8YysqxMmN303
 ukwwraE+o5LQdh/xgmF0YG0enqJFOneGUP9RcTA5LId/sm4ksEeqTdhg1FJbRg6IqTfJ
 RS5g==
X-Gm-Message-State: AA+aEWaVE556R3LTJgj0x8xlX0XFeKImGyKrzs9u6FOfr3v8lKf4LTv8
 5ptBrObxzNgm6VKmtIq27XXd+g==
X-Google-Smtp-Source: AFSGD/UXAiosgP5OpebGlX7nvRpwhLvm8bzeVjEH3mzav/exyJh1lHrdZUE1KZawLazKp4e+Os/ZIQ==
X-Received: by 2002:a17:902:708b:: with SMTP id
 z11mr19041715plk.203.1543911722133; 
 Tue, 04 Dec 2018 00:22:02 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id i123sm32555829pfg.164.2018.12.04.00.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 00:22:01 -0800 (PST)
Date: Tue, 4 Dec 2018 13:51:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nick Fan <Nick.Fan@mediatek.com>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
Message-ID: <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_002213_293627_BDD41653 
X-CRM114-Status: GOOD (  17.61  )
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

On 04-12-18, 14:59, Nick Fan wrote:
> Add API to get voltage for multiple supplies from opp table

And who needs to use this new API ? It would be better to add the user in the
same series to make sure this really gets used.

> Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> ---
>  drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c2df4e..ee73546 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>  
>  /**
> + * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
> + * with index
> + * @opp:        opp for which voltage has to be returned for
> + * @index:      index to specify the returned supplies
> + *
> + * Return: voltage in micro volt corresponding to the opp with index, else
> + * return 0
> + *
> + * This is useful for devices with multiple power supplies.
> + */
> +unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
> +					    unsigned int index)

How will the users of this API get the index ?

> +{
> +	if (IS_ERR_OR_NULL(opp)) {
> +		pr_err("%s: Invalid parameters\n", __func__);
> +		return 0;
> +	}
> +
> +	if (index >= opp->opp_table->regulator_count) {
> +		pr_err("%s: Invalid supply index: %u\n", __func__, index);
> +		return 0;
> +	}
> +
> +	return opp->supplies[index].u_volt;

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
