Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:21:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8D62086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sRWKPw3g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6Lw3Nve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rbXZMN70N0zT6Q0dwFkgD8DNOlJdCH0t4acZDN59c+I=; b=sRWKPw3gbEu7bs
	HbTpwPSUkpOieAEc6EV3JLSZcKPc6QXLREbmgO9qfvCmusYm64X/hwbCiBZzUuENxD6qxsCy8BFbA
	Ogy1ZWEHWN4SIE1AhtLJ55fhFmtleHuILq6Aj6lhIezPBBqzuWEboKnxLXFmaOTuyQ25NbnGugbmt
	18eHj5LCVSSrzSL5vrlqZsR36fOjw19hK9FpAjyrfcz/r7YsBvDrRpH0QKfFVm8z3Ec4ybCT6p1t/
	8scyIbt/+5O2XRrSwK4d/HXoGQ2S9lVw62fZlBJdXBbC43wCUGTXg94rHFMkZ6sEkC5FJ1B0sCVdo
	J6DviYDeZDWO7j7WHGUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKYb-0006II-Pz; Mon, 10 Dec 2018 12:21:05 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKYY-0006HB-3I
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:21:03 +0000
Received: by mail-wm1-x343.google.com with SMTP id s14so10743545wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 04:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dFpbuq0ulV8OVvLVss/W51LDqN9dtTy0/RMmjeONnFg=;
 b=U6Lw3Nve638F4eL/Fjpf3rErRNpwi+jrV4PJyiUIk1L26zK3TZC02jHYt7EajMjdud
 7BIx+B1BRr2lErZqL32qcrKOWtaudoog1M64bdkQ7ikmGlhA/fqIJ9XwoFEdc5tKKSJJ
 gLVERcWuNVTsJbPHt90lYgv7RAR3M1PQHzv/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dFpbuq0ulV8OVvLVss/W51LDqN9dtTy0/RMmjeONnFg=;
 b=i/6kH2U2C3ifp+Mq/9KNm/rtuJJ6n6bpqloGTmFowfXc4uWJfzzzhPcIkLUVA+wLzI
 HicScdP4MYqlwu7Rgf+lplg1KEoPX33OFoKrCMKueaJpJ4/GryBzdrcpn1YJ+VC1Efrn
 tcakyNDNlwvLNtuI//dbVltLE377hIbcApwt4SOksayYCuTbOS6CAx8GBasG6cgiXpO2
 /h7DaYWQsuvTYxtSpGjo00dUbFM5YhtRA5rIR/ynJ8PVX+tipyjJlStsmdnWEBDAfrlT
 /SK2SUsB+MlEqyk3bejkwIasMEJn78SyjEcoovP5yj30gMdV+bOL1Q3Zi554+ZjhQ1tK
 CMHQ==
X-Gm-Message-State: AA+aEWb2tcmmoQM1mfH4HXo/JDW/RHv/tTlc51ehm+XuR/Fuo8Diwf9l
 Ip/pAxQD+HWLeeEvpM/hmjgAuw==
X-Google-Smtp-Source: AFSGD/WmZvpe/89UmFKCkavxAA1K3KbmB66oX27OJgmSA2VOy/7wbhkQ+xNiaHJWk+KsOPWfHswR9Q==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr9498661wmc.133.1544444450156; 
 Mon, 10 Dec 2018 04:20:50 -0800 (PST)
Received: from [192.168.27.209] (mx2.mm-sol.com. [217.18.243.227])
 by smtp.googlemail.com with ESMTPSA id
 k128sm17022687wmd.37.2018.12.10.04.20.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 04:20:49 -0800 (PST)
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
To: Andy Gross <andy.gross@linaro.org>, arm@kernel.org
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
Date: Mon, 10 Dec 2018 14:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_042102_147169_AD54EF7C 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Olof Johansson <olof@lixom.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andy,

On 12/8/18 7:13 AM, Andy Gross wrote:
> The following changes since commit b601f73130a375c912d9f2ec93c5f3cea5d6a3da:
> 
>   drm: msm: Check cmd_db_read_aux_data() for failure (2018-11-29 17:41:53 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.21-2
> 
> for you to fetch changes up to 92def04bd7b46f5b186f985d5c9d3804858c3c2f:
> 
>   MAINTAINERS: Change Todor Tomov's email address (2018-12-05 16:45:34 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.21 Part 2
> 
> * Fix MAINTAINERS email address for Todor
> * Fix SCM compilation error
> 
> ----------------------------------------------------------------
> Jonathan Marek (1):
>       firmware: qcom: scm: fix compilation error when disabled
> 
> Todor Tomov (1):
>       MAINTAINERS: Change Todor Tomov's email address

I saw this patch is applied also in media_tree.git, not sure that is
problem though.

-- 
regards,
Stan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
