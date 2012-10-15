From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 15 Oct 2012 09:12:39 +0200
Subject: [PATCH 1/5] ARM: AT91: Fix build failure on board-dt
In-Reply-To: <20121015055941.GS12801@game.jcrosoft.org>
References: <1350251199-28065-1-git-send-email-manabian@gmail.com>
 <1350251199-28065-2-git-send-email-manabian@gmail.com>
 <20121015055941.GS12801@game.jcrosoft.org>
Message-ID: <CAGhQ9VymdDZ6KZPARyTWoKjdKUF3nBQ0YnrStVa4=8zCCzuL9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 7:59 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 23:46 Sun 14 Oct     , Joachim Eastwood wrote:
>> We need CONFIG_SOC_AT91SAM9 to get the at91sam926x_timer
>> symbol used in board-dt.
> as I said before you can not do a select you need to do a depends
>
> as you will have no clock as you select no SoC

Yes, the board-dt will not boot without a SoC.

Changing it to depend will hide board-dt until you choose a SoC I
assume this is the behavior we want then.

I'll change both patches to use depend in Kconfig.

regards
Joachim Eastwood


> Best Regards,
> J.
