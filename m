Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E3EC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12F920B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mtrjo86e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QxwTQ6S+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aKrQjLIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12F920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pPzXP/UGihaP21INBdsY/HqYUfzskSfkFDLPbG99V8k=; b=mtrjo86e2vwUlm6AUjtbfewSO
	dY2nnsKSfsN49qfKbJeFi93LxadgEHNvFRMohK7f5lOZuXQ/L3iqCjgr8Sotk1ClDTGGSoCI+a9rr
	XIAIQuDcQ+S8DXMAFwl+EadoXCdtrkCXBJo/ahkMEYix1sLVUsDVOsgSfjF9hdH+fJh5KxOChbD+6
	wnvg9p+GnvOGqOqvAKpAZ3I7WmaTSF4hFoc5IKQWVKDulxB2OB3iIn1/CO8KsdEgQvHw+8p8e/f3b
	4NzhBchL3zEGy4mcHonXZCZMTtuiyZg0M67giHkGR0DDnc8yA7EB5Fz8Ig03bO2VLJmXE/fVb+683
	iU9havQmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpMyB-0002gB-Jg; Fri, 01 Feb 2019 00:46:11 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpMy8-0002fq-9i
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 00:46:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 50F486043F; Fri,  1 Feb 2019 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548981967;
 bh=miBLSlMaBLtGMpZR1O7WbW8mvC2/v3vOdB5emXj1j8M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QxwTQ6S+g80cSPsuKHDVhoXM8XZ7yzF2ErsNR7UUbO8ht4gf1XsptZVeFOR740yws
 Nz0S/SbDmm/MUe1jpCnyrvt/qi06Hjx/BYRQkvVyCVS5S4QavO1bGhS2w9MkBfTyxn
 sMvqTk6NU1TBhIQ2rOUrZPSzMHWL3wfYY9qHQXjg=
Received: from [192.168.43.47] (unknown [223.186.125.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 81533601D1;
 Fri,  1 Feb 2019 00:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548981966;
 bh=miBLSlMaBLtGMpZR1O7WbW8mvC2/v3vOdB5emXj1j8M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=aKrQjLImDchC6nEqmy2bqdGZGjfDqY3d4029niKCn8BvN12aLPi3fy26Z29hyoGR0
 3ZEFhQgoQ2Bc831nId6BDpVmAJNk4nZJLFmatE4ORN+2drWxkh6IA/oduo84Rxx9Cu
 iXH9ET8z5Wd+TQrMDBK7NsvhE8iFSKGojW9nkUjc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81533601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
To: Stephen Boyd <sboyd@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Doug Anderson <dianders@chromium.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, devicetree@vger.kernel.org
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <154895230081.169292.7994428901781990604@swboyd.mtv.corp.google.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <0edc38bd-44ac-4100-8042-3538e3eb74e8@codeaurora.org>
Date: Fri, 1 Feb 2019 06:15:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154895230081.169292.7994428901781990604@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_164608_390312_5802894A 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Tingwei Zhang <tingwei@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/2019 10:01 PM, Stephen Boyd wrote:
> Quoting Sai Prakash Ranjan (2019-01-31 06:22:24)
>> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> index e8819d750938..915d86a39cee 100644
>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>>          return 0;
>>   }
>>   
>> +static struct amba_cs_uci_id uci_id_debug[] = {
> 
> Can this be const?
> 
>> +       {
>> +               /*  CPU Debug UCI data */
>> +               .devarch        = 0x47706a15,
>> +               .devarch_mask   = 0xfff0ffff,
>> +               .devtype        = 0x00000015,
>> +       }
>> +};

Yes and done in next version, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
