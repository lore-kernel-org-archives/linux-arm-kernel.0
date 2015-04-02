From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 02 Apr 2015 19:25:35 -0300
Subject: [PATCH 1/6] ARM: lpc18xx: add basic support for NXP LPC18xx/43xx
 SoCs
In-Reply-To: <CAGhQ9VxK1ytLCNWY+6dKwWUkU_BuEV8vrhVfBDgfnovffLbfpg@mail.gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>	<1427923243-26296-2-git-send-email-manabian@gmail.com>	<2687696.KedyLfyrHp@wuerfel>
 <CAGhQ9VxK1ytLCNWY+6dKwWUkU_BuEV8vrhVfBDgfnovffLbfpg@mail.gmail.com>
Message-ID: <551DC1DF.5030105@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/02/2015 01:48 PM, Joachim Eastwood wrote:
> On 2 April 2015 at 16:21, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 01 April 2015 23:20:38 Joachim Eastwood wrote:
>>> +static const char *const lpc18xx_43xx_compat[] __initconst = {
>>> +       "ea,lpc4357-developers-kit",
>>> +       NULL
>>>
>>
>> I don't see 'ea' in Documentation/devicetree/bindings/vendor-prefixes.txt,
>> can you add a patch for that?
> 
> Sure. I'll add it to the next version.
> 
>> It's probably better to make the string we match against the most
>> generic one here, so we don't have to update the list for every
>> new dts file that gets added.
> 
> Okey.
> 
> Could I just use a SoC string here (like "nxp.lpc1850")?
> 

Yeah, that should work. Or maybe you can use "nxp,lpc18xx" and use that
compatible as a generic compatible for all LPC18xx/LPC43xx MCUs.

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
