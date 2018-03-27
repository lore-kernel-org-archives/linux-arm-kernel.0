From: joel@jms.id.au (Joel Stanley)
Date: Tue, 27 Mar 2018 14:07:46 +1030
Subject: [PATCH] ARM: dts: aspeed: Add default memory node
In-Reply-To: <CAK8P3a3XTqFHw4SQMt9zq3QLEhGM6944xQ_n3myOK08YZCbkAA@mail.gmail.com>
References: <20180314071312.17492-1-joel@jms.id.au>
 <CAK8P3a3XTqFHw4SQMt9zq3QLEhGM6944xQ_n3myOK08YZCbkAA@mail.gmail.com>
Message-ID: <CACPK8Xe-5EFsHBUnfbf8vT-fPxnQnf-muAMmLFWD4=t16YR9uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2018 at 19:33, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Mar 14, 2018 at 8:13 AM, Joel Stanley <joel@jms.id.au> wrote:
>> When we removed the inclusion of skeleton.dtsi from the device trees, we
>> broke booting for systems with bootloaders that aren't device tre aware.
>> This can be seen, for example, when appending the device tree blob to
>> the kernel image.
>>
>> The reason booting broke was that the kernel lacked the device_type
>> label in the memory node. Add in a default memory node wth the
>> device_type. It can contain the memory address as the location is fixed
>> for each SoC generation, but the size needs to be added by the
>> bootloader or the board specific dts.
>>
>> Fixes: 73102d6fdc32 ("ARM: dts: aspeed: Remove skeleton.dtsi")
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>> Arnd, can you please merge this as a fix for 4.16?
>
> Sure, applied to fixes branch now.

Thanks!

Has this been sent to Linus?
