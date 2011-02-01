From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 1 Feb 2011 13:39:30 +0100
Subject: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
In-Reply-To: <30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com>
	<30bccb5d133f92cdbf1a4aa75ba54e7b@mail.gmail.com>
Message-ID: <4D47FF02.9090709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2011 7:29 AM, Santosh Shilimkar wrote:
>> From: Paul Walmsley [mailto:paul at pwsan.com]
>> Sent: Tuesday, February 01, 2011 4:44 AM
>>
>> Hello Santosh,
>>
>> On Fri, 28 Jan 2011, Santosh Shilimkar wrote:
>>
>>> On OMAP4, one can explicitly program INACTIVE as the power state
>> of
>>> the logic area inside the power domain. Techincally PD state
>> programmed
>>> to ON and if all the clock domains within the PD are idled, is
>> equivalent
>>> tp PD programmed to INACTIVE and all the clock domains within the
>> PD are
>>> idled. There won't be any power difference in above two.
>>>
>>> Since the CPUIDLE C-states explicitly make use of INACTIVE as a PD
>>> targeted state and also there is some additional latancy involved
>>> with PD INACTIVE vs PD ON, it's better to support it as an explcit
>>> PD state.
>>>
>>> This patch adds the support to allow explicit PD INACTIVE
>>> programming if supported.
>>
>> What does the hardware do when the powerdomain is programmed to
>> INACTIVE?
>> Does it actually force the clockdomains idle?
>>
> No. It doesn't force it. The power domain to hit INACTIVE, the
> clockdomain within the power domain needs to idle and it is
> still a prerequisite. With INACTIVE being programmed, we could
> issue a sleep transition.
>
> PD_ON:
> No power transition, only clocks are gated. Power domain stays ON.
>
> PD_INA:
> Power domain transitions to INACTIVE state. All logic and
> memory stay powered. This state allows for a voltage
> sleep transition.

Just a small note on the latest point:
The voltage sleep transition can occur only if all power domains inside 
a voltage domain are INACTIVE, RET or OFF.

Regards,
Benoit
