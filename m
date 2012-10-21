From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Oct 2012 22:39:48 +0200
Subject: [PATCH 3/5] net/at91_ether: move eth addr quirk into csb337 board
 setup
In-Reply-To: <20121021182551.GH12801@game.jcrosoft.org>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
 <1350829392-3812-4-git-send-email-manabian@gmail.com>
 <20121021182551.GH12801@game.jcrosoft.org>
Message-ID: <CAGhQ9VzHAy3vy5-rz5E1UeRx8nrwYtkjWFEBJBt+uL=QL1FUUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 8:25 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 16:23 Sun 21 Oct     , Joachim Eastwood wrote:
>> Move Ethernet address byte order fix for csb337 into it's board
>> setup.
>>
>> This will allow us to remove the last mach include from at91_ether
>> and also to share the address setup with the macb driver.
> no the at91rm9200 move to DT this is not compatible with it
>
> you need to pass ths in info via platform_data
>
> and do not touch driver code related stuff in boards

I know the board code is a bit nasty.
If it's unacceptable I'll cook up a flag and pass it by platform_data,
something like "reverse_eth_addr". Still it will only ever be used on
the csb337 board.

regards
Joachim Eastwood
