From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 8 Jan 2017 15:27:40 +0900
Subject: [PATCH v2 2/4] linux/const.h: move UL() macro to
 include/linux/const.h
In-Reply-To: <15496.1483699555@warthog.procyon.org.uk>
References: <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
 <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
 <15496.1483699555@warthog.procyon.org.uk>
Message-ID: <CAK7LNARMJVpd47L-3VRafZxdaBT09tA4Bq+V2yFAi_X+cCJsGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2017-01-06 19:45 GMT+09:00 David Howells <dhowells@redhat.com>:
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
>> index c872bfd..76fb0f9 100644
>> --- a/include/uapi/linux/const.h
>> +++ b/include/uapi/linux/const.h
>> @@ -1,7 +1,7 @@
>>  /* const.h: Macros for dealing with constants.  */
>>
>> -#ifndef _LINUX_CONST_H
>> -#define _LINUX_CONST_H
>> +#ifndef _UAPI_LINUX_CONST_H
>> +#define _UAPI_LINUX_CONST_H
>
> You need to be very careful doing this.  Some userspace stuff depends on the
> guard macro names on the kernel header files.

Oh...

>>  /* Some constant macros are used in both assembler and
>>   * C code.  Therefore we cannot annotate them always with
>> @@ -21,7 +21,10 @@
>>  #define _AT(T,X)     ((T)(X))
>>  #endif
>>
>> +#define _UL(x)               (_AC(x, UL))
>> +#define _ULL(x)              (_AC(x, ULL))
>
> How likely is this to collide with existing userspace code somewhere?  It
> looks like the sort of thing that could collide with a C library.

Sorry, I do not have enough insight to answer your questions.


Andrew,
If this seems dangerous, please feel free to drop the entire series
because it is not adding any value except some cleanups.



-- 
Best Regards
Masahiro Yamada
