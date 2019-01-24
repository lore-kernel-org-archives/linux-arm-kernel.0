Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40689C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:21:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF5821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jJAlzYP5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VVUaoGeM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iZD/Fa20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF5821872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=INignwdRGCzsl33VG4r3A+qeR+FD0dpVt9inFnzdvMw=; b=jJAlzYP5jY5IVK5QmZ8IXcPHd
	nw9K7wrLwsq3AEmfttsaKkNNnkfjCRp7gEV2hBUt2hv0+Ge2yoM7sRItnkHWobXr4Q3STg5Uf5IwY
	VpWatsAZg89Ot6w74fB1VjUnhHr+gBL6R03VCF9UHdKFwMOKiYGW12zKcr+kaVpyafWeP+APtQ47A
	9HFCygBkWd2+8bZ/UJSbmo+0GqIOpV7xaG6yn76OhCaFL7Ob/XNdhhn4FZPIwUrDbC8R9iUxOkQkT
	uTyX/KSqQfd4HG1XG1vC3ps/DFXlfoDkF4+V65CuZTWt+nlUC28PHZ39P5Z0fn7MA3YCv6wyy4nun
	7Ke8wKktw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjdH-0008Er-1D; Thu, 24 Jan 2019 18:21:43 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjdE-0008EX-2c
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:21:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 6EFF160854; Thu, 24 Jan 2019 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548354099;
 bh=b5YLJe50/fmev2XJ1PYLgvvqRlTFqRtx/AOY0iQvDbs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VVUaoGeMRWLN4VcHM/E4dp3SSMFQKFqOXpa4SHkwSuB/3wMXwh5mYUMtZyS1ynFCo
 0GrIDmicV2pLFXlGr7nKl7UQtduqZaZcE5FmHzZkQBLoQ3D6LCTP+m4GMtJ2xy+uGo
 GsqMhIMzSLho5j14gNt6+lYozxAL4e29TbPpZHwY=
Received: from [192.168.1.101] (unknown [157.45.230.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 76910606FC;
 Thu, 24 Jan 2019 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548354098;
 bh=b5YLJe50/fmev2XJ1PYLgvvqRlTFqRtx/AOY0iQvDbs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=iZD/Fa20u5cFzhQqLWM4kzgBZZJUjLVpF/wDhVwzU2dZ+/DaCbqDc22EpQGk9mk+f
 54Jeihfc1aAJx/4Lx3NfquYR7oHAFac21R2yKzTT9lTBaWKf+saqX2A5X+bS14wxHC
 4TxxUk2o0y0mHol92fM8K1M+mpmti5ivmQ70D/Kc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76910606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, dianders@chromium.org,
 sboyd@kernel.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
 <18b70426-60fe-4871-6388-6e09fd5feb37@arm.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <de6e021a-4f9a-8e2e-dff0-1e7c61ad8b2b@codeaurora.org>
Date: Thu, 24 Jan 2019 23:51:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <18b70426-60fe-4871-6388-6e09fd5feb37@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_102140_155563_7372ACAD 
X-CRM114-Status: GOOD (  13.59  )
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
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, John.Horley@arm.com,
 linux-kernel@vger.kernel.org, sibis@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Suzuki,

On 1/24/2019 4:49 PM, Suzuki K Poulose wrote:
> Hi Sai,
> 
> 
> That looks fine with me. But as Mathieu said, this needs to be a separate
> patch. But before all that please could you provide me the PIDR4 value for
> the Kryo A75 and A55 please ?
> 

Sure.

PIDR4 value is 0x4.

I get it now. So we are looking for JEP106 identification(PIDR1[7:4] and
PIDR2[2:0]) and continuation code(PIDR4[3:0]).

 From ARM Coresight Spec:

DES_0, PIDR1 bits[7:4] JEP106 identification code bits[3:0].
DES_1, PIDR2 bits[2:0] JEP106 identification code bits[6:4].
DES_2, PIDR4 bits[3:0] JEP106 continuation code.

For SDM845(A75 based):

*0xB_B8_03* does indicate that the JEP106 identification
code is 0x3B and continuation code is 0x4 which is of ARM and not
QCOM(JEP106 ID is 0x70) which is expected.

And the other values of PIDR0[0:7] and PIDR1[3:0] are *Implementation
defined part numbers* and can be different from ARM A75/A55.

I think this clears up case for SDM845.

As for MSM8996, it is not based on any ARM derivative and hence the
JEP106 ID is of QCOM(0x70) from the value of pid = *0xF_02_11*
based on PIDR1[7:4] and PIDR2[2:0]. This clears this as well.

Please correct me if I am wrong and also let me know if I can
continue with PID addition to table.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
