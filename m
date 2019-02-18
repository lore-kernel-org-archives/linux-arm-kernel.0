Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:45:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C150C217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MR262V8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C150C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lGGUluwdiIhPQUFkZV66+JyyAQfIwuLWQw/JFB3bY/0=; b=MR262V8Lk2BdR9
	M+48kY695HsdNjLYbFEvNF8vGkIpth2upgtedBdSPfqjT/20B6EOddx1ZhQoo7GaWirDB6HNWFniw
	uivK+C5E7CZTnoJsAh9MjmsbihhgFrl/ndkC1DKTIhVyvEFF5LLqydOtbSHIaMqPsrBdUL9lRqIaj
	hel5q4yCZRIOdjPN3ShVkmzQpbfKjgcbse2tK6P5dntOUs23nBXMAqxXyBkxfCTVUEulmrnsreOPC
	156QgMZxpvnqbxJSoYpEPKUYTWZKssjFKr8sUCe3UyKy/0CRrhjWE92ro6w21q+0oCdMy0RjoQwsr
	G3G9CyCWWxKVxryQvg1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvm2u-0004sw-UU; Mon, 18 Feb 2019 16:45:32 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvm2r-0004sB-6U
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 16:45:30 +0000
Received: by mail-ot1-f66.google.com with SMTP id z19so29376870otm.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 08:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r0RbpQNLkeIuoLTSc4LRdbNTPI4NVxo5sXSpkaEhmfo=;
 b=mtkH9IVjAlYvV/4gIDzq1nWK/SJR1oeIPjspkbClk/bGqYycqMVs9MGow03eufJHQX
 3nHG3/H4kM7/HCDlDuP3/DH0seMee9LGvLdF7DdWhLb/MnboLYvC7wRfmLe4VMI+82tz
 xdefKXKtKPxTKNvYOwsDTVVfH55URohyOJjKW8lisZDLk8tVpD14DD7Wvc4Pv01Tlr5j
 Fi+wBBsDWuAcGcwEUim5pXyNMQ9Ic7atm/FVtM8zFALH6bVaWRuMv0sLh3KBjrVdFEme
 HN3GPi84xUZsiqJASdSt8lXWUyeqgEEWVysyBfCvtj15qAqn4PcQs02HbP4nu8T3HF1C
 vC4g==
X-Gm-Message-State: AHQUAubnzrSBqrqa5ujd0z0zIJRM6RBW/PPPWCZ7jf5+mfeFkslAty+i
 7114CgmMLXavovFB/jBFjA==
X-Google-Smtp-Source: AHgI3Ibjk9v+IXxtpjzUiTo5cIz56v9rTtezW1IWrRk6lF1SmJ445J9Bi7ysFijvEBHGn4VUVe7f3A==
X-Received: by 2002:aca:cd93:: with SMTP id
 d141mr14949521oig.163.1550508327699; 
 Mon, 18 Feb 2019 08:45:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p129sm6228294oif.17.2019.02.18.08.45.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 08:45:27 -0800 (PST)
Date: Mon, 18 Feb 2019 10:45:26 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm-stm32-lp: document pinctrl sleep
 state
Message-ID: <20190218164526.GA1356@bogus>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550139951-25788-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_084529_239619_773A2C9E 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com,
 tduszyns@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 thierry.reding@gmail.com, linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com,
 u.kleine-koenig@pengutronix.de, fabrice.gasnier@st.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 11:25:49 +0100, Fabrice Gasnier wrote:
> Add documentation for pinctrl sleep state on STM32 LPTimer PWM.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
