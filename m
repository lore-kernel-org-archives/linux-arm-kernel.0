Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E1EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB67A21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QF4JLlfV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l8pmlR7C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SrpzHPSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB67A21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NflYiSlvOFnTkmtiE+QhxMF5fqF5xziVV8hhVSmE08Y=; b=QF4JLlfVFaxEAHM8ynxh6QZqW
	GqzVyUVPbdaNc/0s+fk3UiWB2M9EyrjWonc9Ewuc+rWfv9XdVjt8Rb7vMl96CCcp9JLbi55paGWc2
	J3WsMDsdxe2VQOm6ZGOSZXYbVq+LkjWXcub6Zg7RJuAAeszS45pLATptC0zpqfa+9Ow6KGVZ/u86B
	xsSQ7C0XQ5Ga00Q9ijv/GScv1n52jXgtUNeLOIPDyww1Co2+pywzYmwnm2h0ji85vl1FQCiUMjNMf
	2Sog0n5bPr1yC0s4ai9QHSw2a6eL/DJWPY+2Vt8gxSjBV7FhtZFh/S5JAsuQ7jUsbOSzh5bmz9xFX
	eyoYI9Mfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwJJ-00084n-Et; Tue, 22 Jan 2019 13:41:49 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwJG-00084T-Fn
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:41:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0773F6092B; Tue, 22 Jan 2019 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548164506;
 bh=IgSFqLdlqQwQpy0++An3pk22QDbSE/HmoAiwGNuADag=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=l8pmlR7CApU4iTgqxZGSntD9khPxRdvi671gf1Ra5ZXRf0XcjZ0r0UxY11zXzJs3u
 oFqt72nLCad99aVcTm7gvYNfqy73U3S1xBHcBCs3iSlGIhdj7A/p38S6dx3LuB6XXP
 mA37wclLr8A7BOtE4AZt7w6bgfzvSH20AJQyZdqw=
Received: from [192.168.1.100] (unknown [157.49.207.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E368260E7A;
 Tue, 22 Jan 2019 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548164503;
 bh=IgSFqLdlqQwQpy0++An3pk22QDbSE/HmoAiwGNuADag=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=SrpzHPSyUvF5x+nV0ANAcRJPS1iE8tXS8f+TwZwKkfQwVnPZQTDzkRk82ALJxsdGm
 075re9lTu7Qwj9c4HtFp73T3zvcOaYLEoAG47flCWejiBljI9OWcftEl5MCOHOCfDG
 FkkeeM4MlQmyaAQwkbrF/w6kaqWPdCXMTz6cdj+4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E368260E7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv3 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <73bf137fd5d6cb6bddecdf13026156afcf9d473b.1547813804.git.saiprakash.ranjan@codeaurora.org>
 <20190121183731.GA14049@xps15>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <91bcd4cc-9f66-0ca3-43bf-d912c6080b49@codeaurora.org>
Date: Tue, 22 Jan 2019 19:11:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121183731.GA14049@xps15>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054146_555213_F7E9FD50 
X-CRM114-Status: GOOD (  20.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On 1/22/2019 12:07 AM, Mathieu Poirier wrote:
> Hi Sai,
> 
> On Fri, Jan 18, 2019 at 05:52:53PM +0530, Sai Prakash Ranjan wrote:
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> ---
>> This depends on AMBA bus pclk change by Bjorn Andersson [1].
>> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>> and size cells for soc") [2].
>>
>> [1] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
>> [2] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> 
> Thank you for making modifications to this patch - I am happy with how it stands
> now.  I tried to compile it on my side on a 5.0-rc3 kernel and even after
> applying the above two patches you pointed out I get the following error:
> 
> Error: /home/mpoirier/work/coresight/kernel-maint/arch/arm64/boot/dts/qcom/sdm845.dtsi:1356.31-32 syntax error
> FATAL ERROR: Unable to parse input tree
> 
>  From what I see neither aoss_qmp or AOSS_QMP_QDSS_CLK are defined.  Are there
> more patches that need to be applied?
> 

Sorry, I added all the dependent patches in the cover letter, but
forgot to add the main dependent patch here, now added in v4.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
