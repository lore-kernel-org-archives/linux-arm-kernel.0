From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 11 Oct 2017 13:36:51 +0200
Subject: [PATCHv2 0/7] Add support for USB OTG on STM32F7
In-Reply-To: <878tgim24i.fsf@linux.intel.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
 <878tgim24i.fsf@linux.intel.com>
Message-ID: <04a49088-b615-d7b8-0387-e7bfa32ee19f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felip

On 10/11/2017 12:04 PM, Felipe Balbi wrote:
> 
> Hi,
> 
> Amelie Delaunay <amelie.delaunay@st.com> writes:
>> The STM32F7 MCU family embeds two DWC2 USB OTG cores. One core is USB
>> OTG FS and the other is USB OTG HS. The USB FS core only works with its
>> internal phy whilst the USB HS core can work in HS with external ULPI phy
>> or in FS/LS with the on-chip FS phy.
>>
>> Amelie Delaunay (7):
>>    dt-bindings: usb: Document the STM32F7 DWC2 USB OTG HS core binding
>>    usb: dwc2: add support for STM32F7 USB OTG HS
>>    ARM: dts: stm32: Add USB HS support for STM32F746 MCU
> 
> I have applied these three patches. Should I take the rest? They seems
> like they could go upstream through the ARM maintainers.
> 

I will take other DT patches in my PR.

Concerning "ARM: dts: stm32: Add USB HS support for STM32F746 MCU" patch 
I prefer also to take it. This patch adds some pinctrl groups but stm32 
pinctrl bindings will change in my next PR (we will use a macro to 
define pins instead of using defined values). So if you push the DT 
patch through your pull request there will be a merge issue.
It is possible that I take also this one ?

Regards
Alex
