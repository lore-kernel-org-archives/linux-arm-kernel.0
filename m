Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A4C10F05
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:35:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB0A2229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JO9AWBEL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfHmYe6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB0A2229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aVVV/m3m1r9a5d+B1mx70wiWAY+CeKAy62DtZ9Cx7Aw=; b=JO9AWBELEuZwE6
	wMtRS+2IXcYjMz2IbkatIPGtCObsrpWnZ3QHjzKLDn0BC77KHL2VQ4oMHZ1TZNc1AIETTBmwGtu42
	66AfY5Ra4kN9qTIo+1w+MN4W4yiCmH08Lgl8/4u9xCTyDVTxIybXW8+BTenqeQN8siqzEv03Zgo5f
	l1/H+nVaKk+k2snPZBm/btbTg96cydGMeSDDZHeRQc+QeYDBOKIooIzFyiN5bpLtlUB3DdKa7YZ1l
	5VTGM/z3NYwPZIhf6n/IstAevO7L0ptX98Y2wvaHIvd3EOVqr/wTEEvxvkZDpbMcTKpkEc6EcJ9Ud
	CdiUCOiqCy1Rm5AUN8zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEMe-0006mc-Uj; Thu, 14 Feb 2019 10:35:32 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEMb-0006lB-QN
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:35:31 +0000
Received: by mail-pl1-x642.google.com with SMTP id k15so2945188pls.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rwjOfrTEYGkGc5BS4BtBGe4HH8UgLM5DQXjqkIXGaC8=;
 b=VfHmYe6iUsd9GpoVY2XfvgN0dqznFDeJv6VJApeZePmUVi1pITG9xrI40nEFH7iJrw
 pJy+xZblwlFWOwJqCv5XA6hlxJjFHEuy3puUbj0p4jPgutyn9YAkI/TlzrXQ8ZeXP21A
 MWw6+wzqhCnG2oPV40OS9scSi3vZZ+YrQgs8H7AhleZdJ8iAf/++pasoPouiL/rYeQNf
 25ZvF7ky4wVXVbkfa5eK5x0eV+a6A1lyhhydQy8TS/gngqKG3rxHh15jTcX+821ua9kC
 8H91cvPGTwdVWD2K694ZKqI+13x/8P9L8SjCxNN43dRTiXgVB1zuoCifpY8WgpA19G0O
 GISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rwjOfrTEYGkGc5BS4BtBGe4HH8UgLM5DQXjqkIXGaC8=;
 b=qN9BvW2Ut5JxkWDpXV24MT+3imvQSA4ptUTsb3lot/D9kmnvjTVG+O8WasAMubvpYX
 r8Uz2tSEcuzerFgsBeK/eMth5Mg+nsJQMtbHqDjOkKNSj0agNclmlvM2azhdPDDZcSHb
 pVT8BnIkn9jWrC9nOav0mnkazTJ+uK/GT5nOg3KoJjdEG5Ap+AKUGWXFjpZn+6mKpb5l
 v5qbxds3E3M/PUCtFkGysbsOWWSM0FyN2HqwP3bEGh1ZTbuZBVfzLPzOLdj9z9hRV3Jp
 8oStCUvspWQRj5DUgRrido6pjnWnSpm90t88t7i6S+vFq5DF8XnwnCIXskLXxf563Y3l
 vMlg==
X-Gm-Message-State: AHQUAuaKnaFqftszUVAEmVQAklpXY0hJxUlnt1zRTdE1PM04zARqIEZp
 VKLrYeME/BijxCRoZeqjFHU3eA==
X-Google-Smtp-Source: AHgI3Ibbx6ye3ET6qlC8sLFNRn5/zsfuHqaF034/LeC27Trj3RhmkUdJxe4ejFa46jWJTjq8rOLk5g==
X-Received: by 2002:a17:902:8b82:: with SMTP id
 ay2mr3401562plb.64.1550140529213; 
 Thu, 14 Feb 2019 02:35:29 -0800 (PST)
Received: from localhost ([122.172.102.63])
 by smtp.gmail.com with ESMTPSA id d68sm2964620pfa.64.2019.02.14.02.35.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 02:35:28 -0800 (PST)
Date: Thu, 14 Feb 2019 16:05:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V6 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190214103526.ly5gvkgg3s32t33k@vireshk-i7>
References: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_023529_865108_9CB27E8B 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-02-19, 09:55, Anson Huang wrote:
> Add i.MX8QXP CPU opp table to support cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V5:
> 	- add clocks for all secondary CPUs too.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
