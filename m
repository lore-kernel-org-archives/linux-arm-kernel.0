From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 6 Jun 2013 16:26:03 +0900
Subject: [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
In-Reply-To: <9933530.s16G7h846I@wuerfel>
References: <20130605070616.13311.69049.sendpatchset@w520>
 <20130605070625.13311.17016.sendpatchset@w520>
 <9933530.s16G7h846I@wuerfel>
Message-ID: <CANqRtoTHLvZ8mTGRFb88y8G3DS=d9Sw9Um6gg_66UiwSvmorZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jun 5, 2013 at 5:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 June 2013 16:06:25 Magnus Damm wrote:
>>
>> +__ZRELADDR     := $(shell /bin/bash -c \
>> +                    'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
>> +
>
> It's not important, but I think this can be written much simpler using
> makefile syntax as
>
> __ZRELADDR      := $(sort $(loadaddr-y))

Yes, correct. Just double checked by comparing the output. Your
proposal is much cleaner, will follow that if/when I send a V2.

Thanks,

/ magnus
