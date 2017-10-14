From: keescook@chromium.org (Kees Cook)
Date: Sat, 14 Oct 2017 15:48:29 -0700
Subject: Stack protector kernel build error
In-Reply-To: <CAGXu5jLdBzv-SdVhJJ6AGrCV8TUEpK71S3FugEqxKRtYbcTbwQ@mail.gmail.com>
References: <87tvz1y08l.fsf@belgarion.home>
 <CAGXu5jLdBzv-SdVhJJ6AGrCV8TUEpK71S3FugEqxKRtYbcTbwQ@mail.gmail.com>
Message-ID: <CAGXu5jJ9Zcoo_Byb3LfLXJtueVmh1TuSE3LfPrM2Wy_YE2=AcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 14, 2017 at 3:45 PM, Kees Cook <keescook@chromium.org> wrote:
> On Sat, Oct 14, 2017 at 12:53 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Hi Kees,
>>
>> Today my linux-next build broke for the pxa architecture.
>> My specific setup is :
>>  - ARCH=arm make pxa_defconfig; ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make
>>  - my compiler is:
>>         rj at belgarion:~/mio_linux/kernel$ arm-linux-gnueabi-gcc --version
>>         arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516
>>
>> And the error message is :
>> rj at belgarion:~/mio_linux/kernel$ make -j 4
>>   CHK     include/config/kernel.release
>> CONFIG_CC_STACKPROTECTOR_AUTO: Compiler does not support any known stack-protector
>> Cannot use CONFIG_CC_STACKPROTECTOR_AUTO: not supported by compiler
>> Makefile:1097: recipe for target 'prepare-compiler-check' failed
>> make: *** [prepare-compiler-check] Error 1
>> make: *** Waiting for unfinished jobs....
>> make: *** wait: No child processes.  Stop.
>>
>>
>> Is this expected, as I was under the impression my compiler was not that
>> outdated ...
>
> Hmm, there's probably a bug in my attempt at making the ..._AUTO mode work.

(Specifically, that report about compiler support should be a
_warning_ not a _failure_ for _AUTO mode...)

-Kees

>
> What does "arm-linux-gnueabi-gcc -fstack-protector" say?
>
> -Kees
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
