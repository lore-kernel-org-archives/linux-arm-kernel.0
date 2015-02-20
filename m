From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Feb 2015 18:59:52 +0200
Subject: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
In-Reply-To: <54E73B1D.3050908@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com>
 <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com>
 <54DE1B7E.10505@ti.com> <54E71EA2.3030803@ti.com> <54E72FB0.6000604@ti.com>
 <54E73B1D.3050908@ti.com>
Message-ID: <54E76808.2030405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2015 03:48 PM, Tomi Valkeinen wrote:
> On 20/02/15 14:59, Tero Kristo wrote:
>> On 02/20/2015 01:46 PM, Tomi Valkeinen wrote:
>>> On 13/02/15 17:42, Tero Kristo wrote:
>>>> On 02/13/2015 05:25 PM, Nishanth Menon wrote:
>>>
>>>>> I would probably wait for control module to become syscon and probably
>>>>> model this as syscon clk - I thin we should be seeing a series
>>>>> sometime soon.
>>>>
>>>> Yeah, I will be posting a series in a bit, just running some final tests
>>>> on it.
>>>
>>> I did the above with Tero's series. Adding the DES HDCP clock works ok.
>>>
>>> However, I'm not able to do this in HWMOD framework. To enable the DSS
>>> IP block I need to enable both the DSS func clock and the DES HDCP
>>> clock, but the HWMOD framework only allows one mainclock.
>>>
>>> I added the HDCP clock as an opt clock, but those are not enabled
>>> intially by the HWMOD framework, and the call in omap_hwmod.c:_enable()
>>> to soc_ops.wait_target_ready(oh) calls fails.
>>>
>>> So... Any ideas how to proceed?
>>
>> Add the clock enable at the end of dra7xx_dt_clk_init()?
>>
>> You need to disable the clock at some point though.
>
> Where would I disable it? And if the clock is disabled, doesn't this
> again fail when the dss driver tries to enable the IP block? The driver
> can enable the HDCP opt clock only later, when the IP block should be up
> already.

I guess in the display driver itself.

-Tero
