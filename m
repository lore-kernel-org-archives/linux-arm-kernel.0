From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Feb 2018 10:44:27 +0100
Subject: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
In-Reply-To: <nycvar.YSQ.7.76.1802202213560.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-4-arnd@arndb.de>
 <nycvar.YSQ.7.76.1802202213560.31644@knanqh.ubzr>
Message-ID: <CAK8P3a1Tnq=FgkqWhK7FKMSLyBrRxLhbQVP7o3hwBVa-Yx7A3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 4:15 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
>
>> We need some way to pass -mbig-endian to the linker during the
>> LTO link stage, otherwise we get a waning like
>>
>> arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian
>>
>> for each file we link in.
>>
>> There is probably a better method of passing that flag, I'm just
>> adding it to a different hack that I added earlier for x86 LTO
>> here.
>
> Didn't the patch below fix it for you already?

I think the problem here is that -mbig-endian is part of KBUILD_CPPFLAGS,
not KBUILD_CFLAGS. We add the latter to the gcc-ld command line, but not
the former.

      Arnd
