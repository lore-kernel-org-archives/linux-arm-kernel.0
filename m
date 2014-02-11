From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:26:14 -0600
Subject: [PATCH 4/9] ARM: Select V6K instead of V6 by default for
 multi-platform
In-Reply-To: <1492617.b9HLFpaExO@wuerfel>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-5-git-send-email-robherring2@gmail.com>
 <1492617.b9HLFpaExO@wuerfel>
Message-ID: <CAL_JsqK0MfdaBfytkOY-abJ614NU9R6FR0rGOeFUx8ojanjZ3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 3:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 11 February 2014 15:11:54 Rob Herring wrote:
>> @@ -1,9 +1,9 @@
>>  config ARCH_CNS3XXX
>>         bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
>>         select ARM_GIC
>> -       select CPU_V6K
>>         select MIGHT_HAVE_PCI
>>         select PCI_DOMAINS if PCI
>> +       select CPU_V6
>>         help
>>           Support for Cavium Networks CNS3XXX platform.
>
> I thought we had concluded that CNS3xxx is V6K as well. Do you
> have newer information? Maybe Anton remembers.

I believe it is being MP, but I split this up so that changing the
default doesn't change any platform and each platform change is a
separate patch which can be applied or not.

Rob
