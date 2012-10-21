From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Oct 2012 22:30:46 +0200
Subject: [PATCH 3/5] net/at91_ether: move eth addr quirk into csb337 board
 setup
In-Reply-To: <20121021183418.GC18964@game.jcrosoft.org>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
 <1350829392-3812-4-git-send-email-manabian@gmail.com>
 <20121021183418.GC18964@game.jcrosoft.org>
Message-ID: <CAGhQ9Vw1f18WrQ9N8Pa8hGbJuzh8kYiJLaFxbNkshKH=UosQng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 8:34 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 16:23 Sun 21 Oct     , Joachim Eastwood wrote:
>> Move Ethernet address byte order fix for csb337 into it's board
>> setup.
>>
>> This will allow us to remove the last mach include from at91_ether
>> and also to share the address setup with the macb driver.
> no the current drivers expect mach/board.h, mach/at91rm9200_emac.h, asm/gpio.h
>
> waht you did will not even compile on non at91 platform
>
> Did you even compile it on non at91?

This is the last mach include in the at91_ether driver in net-next.
And, yes, after this patch it complies fine for at least x86_64.

regards
Joachim Eastwood
