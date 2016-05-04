From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Wed, 4 May 2016 09:52:19 +0200
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <5608365.uloflbeuqO@wuerfel>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <6161197.8XCk69TI60@wuerfel>
 <20160426111532.GA5457@griffinp-ThinkPad-X1-Carbon-2nd>
 <5608365.uloflbeuqO@wuerfel>
Message-ID: <5729AA33.6020305@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello Arnd, peter,

On 04/26/2016 01:44 PM, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 12:15:32 Peter Griffin wrote:
>>>
>>>> If not what would you recommend instead? 
>>>
>>> It's still not clear to me what that bit in the syscfg register
>>> is for. Given the error message about "sti-audio-clk-glue",
>>> I suspect that this is actually a clock controller and that
>>> it should be using the clock binding with a separate driver
>>> instead of manipulating the regmap directly from the audio driver.
>>
>> Luckily I do have the datasheet for the audio-glue sysconf register.
>>
>> It says: -
>>
>> [11:8] PCM_CLK_SEL: Selects the frequency synthesizer clock or the external
>> PCM clock for each channel.
>>
>> The driver only ever sets this to 1 which selects the frequency synthesizer
>> clock. So the bitfield of the register which the driver is using (PCM_CLK_SEL)
>> is a clock mux.
> 
> Ok, that sounds like it could be either a really simple clock driver
> with just a few lines, or integrated into an existing clock driver
> if you already have one for this syscon node.
> 
> 	Arnd
> 
FYI, Name of this glue is related to the register name. But it does not
concern only clock...
 This glue register is used to :
- select clock source ( clock framework or external clock from GPIO)
=> one bit field per IP instance (player->clk_sel)
- select uniperiph player IP instance for PCM out.
(http://www.spinics.net/lists/alsa-devel/msg49034.html)

Regards
Arnaud
