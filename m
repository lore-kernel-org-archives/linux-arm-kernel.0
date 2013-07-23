From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Jul 2013 12:15:54 -0700
Subject: [PATCH] ARM: pxa: propagate errors from regulator_enable() to
 pxamci
In-Reply-To: <8638rt3svt.fsf@void.printf.net>
References: <201307051751.20729.arnd@arndb.de> <8638rt3svt.fsf@void.printf.net>
Message-ID: <CAOesGMiVzH7qyu_tBpKV5PTHBvvwE9E6Q9f39ENfVOO-6wY3+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 5, 2013 at 8:53 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Jul 05 2013, Arnd Bergmann wrote:
>> The em_x270_mci_setpower() and em_x270_usb_hub_init() functions
>> call regulator_enable(), which may return an error that must
>> be checked.
>>
>> This changes the em_x270_usb_hub_init() function to bail out
>> if it fails, and changes the pxamci_platform_data->setpower
>> callback so that the a failed em_x270_mci_setpower call
>> can be propagated by the pxamci driver into the mmc core.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> For pxamci:
>
> Acked-by: Chris Ball <cjb@laptop.org>

Applied with your ack to arm-soc fixes branch for 3.11, after fixing
the set/test ordering pointed out in the thread.

Thanks!

-Olof
