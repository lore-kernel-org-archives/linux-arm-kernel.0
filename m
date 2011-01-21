From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 20 Jan 2011 19:24:05 -0800
Subject: [PATCH] drivers: mmc: msm: remove clock disable in probe
In-Reply-To: <AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>
References: <1295374473-27872-1-git-send-email-dwalker@codeaurora.org>
	<AANLkTim-=40MM=TeH1XSQ-rio1ctwcZAs4qbf9SaxmdH@mail.gmail.com>
Message-ID: <4D38FC55.2030601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2011 02:50 AM, Vitaly Wool wrote:
> Hi,
>
> On Tue, Jan 18, 2011 at 7:14 PM, Daniel Walker<dwalker@codeaurora.org>  wrote:
>> The probe function adds the MMC host which can start accepting request
>> immediately. There is an assumption here that no requests happen
>> immediatly, but it's not always the case. This assumption can causes
>> a BUG() when the clocks are disabled. The fix is to just remove the
>> clock disable in the probe function.
>>
>> Signed-off-by: Daniel Walker<dwalker@codeaurora.org>
>
> I can add acked-by and/or tested-by if needed.
>
> ~Vitaly

Nack from me. The fix is incorrect. The clocks are alread refcounted in 
the clock driver. There should be no need to "leave it on because 
someone else might access it". Every code that needs the clock should 
have a clk_enable/disable around it and it would all work fine.

-Saravana


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
