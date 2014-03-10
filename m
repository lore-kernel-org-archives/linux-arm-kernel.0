From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Mar 2014 10:56:14 +0900
Subject: [PATCH v2] ARM: shmobile: Add temporary include workaround
In-Reply-To: <20140309053508.GC12854@quad.lixom.net>
References: <20140224224446.14786.79602.sendpatchset@w520>
 <20140309053508.GC12854@quad.lixom.net>
Message-ID: <CANqRtoRJ+x8pvc1ZN6OkUTcVn=-ThSeQ75EoOmDPGdgEn+pHZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 9, 2014 at 2:35 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Feb 25, 2014 at 07:44:46AM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add temporary include path in the mach-shmobile Makefile to
>> aid coversion from using <mach/something.h> to "something.h"
>> in the source files.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>
>> ---
>>
>>  Changes since V1:
>>  - Use += instead of := to avoid breaking MULTIPLATFORM
>>
>>  arch/arm/mach-shmobile/Makefile |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- 0001/arch/arm/mach-shmobile/Makefile
>> +++ work/arch/arm/mach-shmobile/Makefile      2014-02-25 07:41:56.000000000 +0900
>> @@ -4,6 +4,8 @@
>>
>>  ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
>>
>> +ccflags-y += -I$(srctree)/arch/arm/mach-shmobile/include/mach
>> +
>>  # Common objects
>>  obj-y                                := timer.o console.o
>>
>
> Hmm. Not a fan of doing this. Let's just do the include file move with
> the include string changes instead on each instance.

Sure, I'm open to anything here. How would you like me to write the
code to make it easy for Simon and you to merge it?

I'm asking because most header files are used by both SoC code and
board code, and because of that I went with different changes for
different topic branches. So to cope with the topic branch split my
current patches do this:

1) Introduce workaround to allow new header location
2) Convert SoC files to using new header location
3) Convert Board files to using new header location
4) Move header files
5) Remove recently introduced workaround
6) Remove existing multiplatform include path workaround

I'm happy to change things around, but please let me know how you guys
would like to consume this change so I can decide what to write
against.

Thanks,

/ magnus
