From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Aug 2013 10:27:27 +0200
Subject: [GIT PULL] at91: soc update for 3.12 #1
In-Reply-To: <521E9F42.6090604@atmel.com>
References: <1377532543-349-1-git-send-email-nicolas.ferre@atmel.com>
 <20130828235855.GM8607@quad.lixom.net> <521E9F42.6090604@atmel.com>
Message-ID: <521F05EF.3060804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/2013 03:09, Bo Shen :
> Hi Olof,
>
> On 08/29/2013 07:58 AM, Olof Johansson wrote:
>> On Mon, Aug 26, 2013 at 05:55:43PM +0200, Nicolas Ferre wrote:
>>> Arnd, Olof, Kevin,
>>>
>>> Here is AT91 SoC updates for 3.12 kernel. It is the first pull-request for
>>> this topic and it is based on 3.11-rc5 like your next/soc branch.
>>>
>>> Thanks, best regards,
>>>
>>> The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>>>
>>>     Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>     git://github.com/at91linux/linux-at91.git tags/at91-soc
>>>
>>> for you to fetch changes up to 99eb3b40ec42e7fce1fc58429bf9b26c17973c12:
>>>
>>>     ARM: at91: at91_dt_defconfig: enable rm9200 support (2013-08-26 09:58:29 +0200)
>>>
>>> ----------------------------------------------------------------
>>> AT91 SoC update for 3.12 take 1
>>> - enable kernel uncompress information output for
>>>     SoC where it was missing: at91sam9n12 and sama5d3
>>> - addition of at91rm9200 to the generic at91_dt_defconfig
>>>
>>> ----------------------------------------------------------------
>>> Jean-Christophe PLAGNIOL-VILLARD (1):
>>>         ARM: at91: at91_dt_defconfig: enable rm9200 support
>>>
>>> voice (4):
>>>         ARM: at91: sama5d3: add definition for usart base address
>>>         ARM: at91: include sama5d3.h into hardware.h
>>>         ARM: at91: sama5: enable kernel uncompress info output
>>>         ARM: at91: sam9n12: enable kernel uncompress info output
>>
>> That doesn't look right. Author should probably be "Bo Shen
>> <voice.shen@atmel.com>" instead. Can you fixup and respin, please?
>
> I don't know why on the patchwork it show my name as voice.
> So, if get patch from patchwork and apply it will show my name as voice.
> So, would it be possible to show the name as Bo Shen on patchwork?

I to not know if patchwork has modified something but it seems a matter 
of $GIT_AUTHOR_NAME that is not well positioned.

For the record, here is the line for correcting this:

git filter-branch -f --env-filter '
	if test "$GIT_AUTHOR_NAME" = "voice"; then
		GIT_AUTHOR_NAME="Bo Shen"
		export GIT_AUTHOR_NAME
	fi
' v3.11-rc5..HEAD

But I advice you to define correctly all git environment variables.

Bye,
-- 
Nicolas Ferre
