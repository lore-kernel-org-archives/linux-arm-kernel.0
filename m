Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10549C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D0720855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VYiYloeF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBEuGwn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D0720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SVGxTLppk8pSyhDVs3AedmMGKw0c0HLhRdga0KLdqdw=; b=VYiYloeFsBqs7t
	8BDk7bAUw9ybWEfh6LLV//2XREKC1OeboBnr65ENCqJQmuVlLpL4HkLKlyr/uJ751ct6ajID963yx
	QrMaiNIl2A2ZVewZfnNlCzEroNszfsLGQB1CmIGr+fi+3jBooEDhTgg1EFnwZNafFVfYmiMfMMsh2
	0V7wfMuqjS5gloeAKHXCL4wkN0QxOg+kwMSeATvv91yyka0ZhYSoipGLlv9pgsqC80k4DXGdLxUG+
	UOoGhQcSF1oP9bRQrk3pOrsCSwT3ylMf51+mblC6fpLhP6idySqNpQ8IrP8/g9nR1eLzqWaKbd4EY
	MgDJzmAUFn8Vkyz0On7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gooyM-0004fL-Ui; Wed, 30 Jan 2019 12:28:06 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gooyJ-0004ej-8c
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:28:04 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so21438846wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p4U/iIJj82u26qLoq46qihY0sTUO30P5OPcQP+2hQt4=;
 b=bBEuGwn1o7o2K8JnDQ6yuznyxfZ8aIkbh6vqE/DBlyhp+6yqEURJYjfHBCAepcN1gY
 KBDN9pSi+/C2hO3RkkPQZoWYUQsT0j/QwFPQiIjWsCYGD3KcATpFnofhfVf0hukoGC5B
 WWeXgPNmRZNzXguHf4Daup0YWcGB6CqwaL3b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p4U/iIJj82u26qLoq46qihY0sTUO30P5OPcQP+2hQt4=;
 b=LFPw1yDjAuVNDYmc7lWyc3OM+4I1VHEbP4TVWlLgO5Yj6b/lfQ8s+zDwzeK4ZmzC/3
 u2ZZaJn3IYbec2XG+Smnr/aWTWiyxkh+YLua7z5/4wtpHS3YfmlsqxtmW6hjjQUWnbmg
 Vpl71ttEtQrqn3gzRtNt6bUxBRC3zdLFQXJdOR9N7ghxQFxwI72JMVQz0AsF3R7nzLqO
 GzRiNkFROn4Q6B3zWEEoeWkcQi5nTSET2DH3G0Cep7UC+GwM2u9jzUogpjtCLOTj2UH6
 T4rbtG88AO7uK2sSjyTH47/Aq2pTpDjgorVWfcm8/XoOBnPPOPWsJpnvFQ6Wa3y8KYlI
 dZCg==
X-Gm-Message-State: AJcUuke0DTMCm0m7/X5dxS9btAYPqOH5ae5/U9EXsQ/Sw3pZ66e6mqDl
 xOnmI9YuS+XcwcA++tyA8GBWtg==
X-Google-Smtp-Source: ALg8bN5HK5CtsRK25o5XOzy94A9USGHN7oWCi0//bbFt7rwvoCn57KBqYeC34t2f0+YEHFUe+uiq8Q==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr24272697wmd.89.1548851281230; 
 Wed, 30 Jan 2019 04:28:01 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net.
 [79.146.83.99])
 by smtp.gmail.com with ESMTPSA id f199sm2273299wmd.25.2019.01.30.04.27.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 04:28:00 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190129202726.GA3036@builder>
 <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Message-ID: <61bdca18-cef9-3f02-45ef-5df4f96b4f2b@linaro.org>
Date: Wed, 30 Jan 2019 13:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_042803_355393_2D65C8BA 
X-CRM114-Status: UNSURE (   9.43  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 vkoul@kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
 kishon@ti.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 10:53, Jorge Ramirez wrote:

>> +	priv->vbus = devm_regulator_get_optional(priv->dev, "vbus");
> get_optional means that if vbus-supply is not found, rather than
> returning a dummy regulator object this will fail with -ENODEV.

on this subject, is it intentional that devm_reset_control_get_optional
behaves differently (ie, it returns a NULL if it cant be found)

IMO all *_get_optional should be semantically as well as functionally
equivalent to avoid confusions like the one I had.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
