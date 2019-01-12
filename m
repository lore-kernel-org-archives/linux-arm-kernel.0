Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:51:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF202086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G1rrW138";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="efBTxDQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ti5QamKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF202086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z3Winsq2zj4OT17DsO1BPieSOsu67CVqIApjQALoLyU=; b=G1rrW138iZyIQck4myQn8m4FC
	J8E45sDWJ2+emOr6dAOZRtAtLM3f1YTdy6crk2k0Fg+KA2hjjj14TpEdiJg0F9+lJIpd1aFb3TVKP
	iQVVPYzfJwz3ynWWcwYoNbu2aNDtJrzufHEgtjWQ3zOygWuVvYCYFcXosZiLy4npQ3N9czy2XukjN
	0b1FOxLRZ8YLd0B+enjTQgMho9hdMwsmQjKgmbr94L8fgEY/roFPSN/74E/5aHWtvZGkJw9faGEF9
	JJ77qfJ5ihg8pqiHe8KY0RAtpEWPgcSYMJPL4B1+76mgBdu/nzQIiikBT9j2cDexyWzjSHcK9CWvr
	Le9fKmQLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIkk-0001p9-67; Sat, 12 Jan 2019 12:51:06 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIkf-0001om-Tf
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 12:51:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 86BA76087F; Sat, 12 Jan 2019 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547297461;
 bh=vc95Z/tMlWNdjowrwCwRgmlvYWxkp4Ha9JVSJUZtmRw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=efBTxDQrAUC6i3csoz7boD3nLvf3rJvOQk+L9BmwSRurQcswXvLaCU9ABEojoc6cu
 /TTk3HzC4nZmNHTTaEZ0YZC2vW2HpgWDiJqO/xedrNi9UxRoxCsfA8cAliU80/1syv
 kzcuBdngmV6a+1Nfn/8NQfK410f7zr/A7uOMgoCk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 by smtp.codeaurora.org (Postfix) with ESMTP id CF28B6087F;
 Sat, 12 Jan 2019 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547297460;
 bh=vc95Z/tMlWNdjowrwCwRgmlvYWxkp4Ha9JVSJUZtmRw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ti5QamKzeZ1n7mzWuR9OIUfBx8DLh82A/ne0E++ehrYuFCH79PMffGcpZ3jWdkNVP
 RZ5V/Gy4WInJZVuHnYZfC7K2PbR+Z0Rb4SBdWbS8LaU3wNViMzbhO+d5OUW0cuCDId
 7ZPAn+2WOJ5j/vUdQLrt9UEsH9BCa8QHk474Sk4A=
MIME-Version: 1.0
Date: Sat, 12 Jan 2019 18:21:00 +0530
From: saiprakash.ranjan@codeaurora.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
In-Reply-To: <20190111184643.GA22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111184643.GA22691@xps15>
Message-ID: <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_045102_007432_708C0D8C 
X-CRM114-Status: UNSURE (   8.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-msm-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

>> +
>> +	etm@7040000 {
>> +		compatible = "arm,coresight-etm4x", "arm,primecell";
>> +		arm,primecell-periphid = <0x000bb95d>;
> 
> I'm a little curious as to why you need to bypass the normal AMBA bus 
> discovery
> method by forcing the peripheral ID.  Tracers don't show up the way 
> other
> coresight devices do at boot time?
> 

Yes on some Qcom SoC's like SDM845 and also on some previous ones, for 
ETM(only) amba bus discovery method fails because of wrong pid read from 
the registers. So we have to force this primecell peripheral ids to 
probe etm.

- Sai

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
