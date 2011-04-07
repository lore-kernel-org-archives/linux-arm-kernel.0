From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 06 Apr 2011 18:27:25 -0700
Subject: [PATCHv5 1/3] ARM: Translate delay.S into (mostly) C
In-Reply-To: <4D9C2910.6020309@stericsson.com>
References: <1302047800-26720-1-git-send-email-sboyd@codeaurora.org>	<1302047800-26720-2-git-send-email-sboyd@codeaurora.org>
	<4D9C2910.6020309@stericsson.com>
Message-ID: <4D9D12FD.6060608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 01:49 AM, Mattias Wallin wrote:
> On 04/06/2011 01:56 AM, Stephen Boyd wrote:
>> +void __udelay(unsigned long usecs)
>> +{
>> + __const_udelay(usecs * ((2199023*HZ)>>11));
> This will overflow if HZ=1000.
> If I remember correct I fixed it like this:
> __const_udelay(usecs * ((2199023UL*HZ)>>11));
>
> /Mattias Wallin
>

Mattias,

Isn't this a big in the existing code too? I would prefer not combining 
that with this patch series. That bug should be fixed before/after this 
patch series. Not as part of it.

I would vote for after this patch series since this patch series has 
been trying to get in for quite a while now.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
