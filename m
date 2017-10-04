From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Wed, 04 Oct 2017 09:05:49 +0200
Subject: [PATCHv2 0/2] dwc3 on XU3
In-Reply-To: <b9aad201-78b9-f04b-238d-5297e6096ee7@ti.com>
References: <ba580a0c-36c3-b227-61ee-97637532823e@ti.com>
 <CGME20171003125944eucas1p1fad23e6171786fda69ccd9419354911b@eucas1p1.samsung.com>
 <1507035578-24945-1-git-send-email-andrzej.p@samsung.com>
 <b9aad201-78b9-f04b-238d-5297e6096ee7@ti.com>
Message-ID: <6935498c-9788-14e6-844f-f9e8288026dc@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

W dniu 04.10.2017 o?06:22, Kishon Vijay Abraham I pisze:
> Hi,
> 

<snip>

>>
>> @Kishon:
>>
>> As far as I understand what you suggest is to move phy_init() and
>> phy_power_on() invocations from dwc3/core.c to xhci-plat, but,
>> to the best of my knowledge, they are needed in device mode, too.
> 
> What I meant is perform phy initializations for host mode in xhci and keep only
> device mode phy initialization in dwc3.
> 

Ah, I should have been more explicit.
Unfortunately, without phy initialization dwc3 registers are unavailable,
so it looks like it is really needed at the point it is done now.

Andrzej
