Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11407C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AB62084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D5OjTsM9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JJWeXQsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ny57mMKsdMylNfihfvbnXWrQ5TF5uahXxJ1P7R7w+gE=; b=D5OjTsM9qoZtBsU7dYVpHk8dG
	F4KEvnkvGJ6AwmSuPARRQDK7AN1W4Mmdzh71ofnKtc1jV2pKFLHWRk5NY2bD/oO5ynwImIZtK88GS
	qgohdrItNr0JV0BQTqoGdWBtH/cyzJzIbpKWOG4+vpmjsMoWaSIpAk59RooEe608sLL6KAnJj9ENd
	d9+SkZInV7wLEzH5yoiJJdl6H/0pEcVfiPr3slmqsfVTqj9PpLvbZffO65rI9ki3nH8p+0jFcEUQb
	sylvRAF3rBkV5VAXPzEyfIp6A5m3uRrlFLeytzEGmAAa4ZMtrI2XkABqIaCTrTMSfh9Jlb+Qzgapu
	5yms49FMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gms5R-0006ed-KG; Fri, 25 Jan 2019 03:23:21 +0000
Received: from hqemgate15.nvidia.com ([216.228.121.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gms5O-0006dP-0g
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:23:19 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c4a810a0018>; Thu, 24 Jan 2019 19:22:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 24 Jan 2019 19:23:15 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 19:23:15 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 03:23:13 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
 <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
Date: Fri, 25 Jan 2019 11:23:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548386570; bh=Vf5raOr5Nltjpm3Hj7ObWfFqyEkrUq7A+aU6p8IhhSw=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=JJWeXQsJZvBtgdeg0lEZYjrUZfoLupOTw+CSme5n4wQ1ilgtNeLTxtahC5PaS0FXt
 vYu+UV4vgc874NHCR54sgBuxYHX5WtH1a9fCxvUFMtSEGytIEAaax0MdaIkMASBemH
 iEWIfD2WlgrJn5mVP9Vm3d5B/apbgR9MikHyZBwxo7jzd1VrF6JpQvSpztV0Zr+VJl
 WBNQlAfEPlrgX/70ICRtUYtYkzU5j7MXJlg1qjb/1qOCgH+oylsJKzjY5r4a1duXHF
 m40+9C7pWDca/dYaYtBa4cmxduVeXs096siOqPKslstig7VlNWA0FZeiZjarH1zkis
 ehmylk8fCgb3g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_192318_069501_A240A9B4 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jon,

Thanks for reviewing.

On 1/24/19 6:30 PM, Jon Hunter wrote:
> 
> On 07/01/2019 03:28, Joseph Lo wrote:
>> The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
>> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
>> from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
>> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
>> or watchdog interrupts.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   .../bindings/timer/nvidia,tegra210-timer.txt  | 25 +++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>> new file mode 100644
>> index 000000000000..ba511220a669
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>> @@ -0,0 +1,25 @@
>> +NVIDIA Tegra210 timer
>> +
>> +The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
>> +timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
>> +from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
>> +(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
>> +or watchdog interrupts.
>> +
>> +Required properties:
>> +- compatible : "nvidia,tegra210-timer".
>> +- reg : Specifies base physical address and size of the registers.
>> +- interrupts : A list of 4 interrupts; one per each of TMR10 through TMR13.
> 
> Why do we only add the interrupts for TMR10 - TMR13? What about the others?
> 

The others (TMR0-TMR9) are occupied for other usages. TMR5 is occupied 
for the watchdog timer in the upstream kernel. And others (still in 
TMR0-TMR9) are occupied for different usages in our downstream kernel.

And notice that only TMR10-TMR13 are running at the oscillator clock 
(clk_m). With the Tegra210 timer driver, we introduce in this series, 
which only replace the clock event device function that was originally 
owned by the arch timer (armv8 timer) and it also running at the 
oscillator clock. The sched_timer still owns by the arch timer. So the 
timer resolution will be the same. That's why we choose TMR10-TMR13 as 
the timer for Tegra210.

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
