From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 12 Oct 2012 19:08:34 +0200
Subject: [PATCH 3/4] ARM: AT91: Add AT91RM9200 support to DT board
In-Reply-To: <20121012162706.GI12801@game.jcrosoft.org>
References: <1349993126-9519-1-git-send-email-manabian@gmail.com>
 <1349993126-9519-3-git-send-email-manabian@gmail.com>
 <20121012142251.GC12801@game.jcrosoft.org>
 <50783714.2000702@atmel.com>
 <20121012162706.GI12801@game.jcrosoft.org>
Message-ID: <CAGhQ9VzOQ2V6Cn5tY1REcGzpjjs53Lu6tT7=fNKqJQkBhR8HDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 6:27 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 17:28 Fri 12 Oct     , ludovic.desroches wrote:
>> Le 10/12/2012 04:22 PM, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
>> >On 00:05 Fri 12 Oct     , Joachim Eastwood wrote:
>> >>Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> >>---
>> >>
>> >>Hi,
>> >>
>> >>This patch has some potential issues.
>> >>Before this patch board-dt would fail building when only AT91RM9200 was enabled because at91sam926x_timer symbol would be missing. This patch uses the at91rm9200_timer which
>> >>will fail if AT91RM9200 is not enabled.
>> >this need work with ot wtihout rm9200

btw, to solve the build issue with board-dt in mainline now we need to
add a select CONFIG_SOC_AT91SAM9 to config MACH_AT91SAM_DT.

>> >>
>> >>Any thoughts on solving this? As mention above this bug exists in mainline now.
>> >duplicate the board-dt with one for rm9200 only
>> >as rm9200 ans sam9 are 2 distict familly
>>
>> Why not adding a new machine descriptor for rm9200 in order to
>> prevent file duplication?
> because the soc are different and can only be compile if the timer is enable
> and I do not want to enable the rm9200 timer on sam9 so instead of a ifdef i
> the board-dt create a new board is better as we have a 50 lines file
>
> with different board_compat and different machine descriptor

I am okey with either approach, but I would like to hear what Nicolas
Ferre has to say since he is the on the one that added board-dt. It
would be nice to have everything in one board DT file, but I
understand your concern with the RM9200 timer.

We will also bump into this again on AT91X40 I guess.

regards
Joachim Eastwood
