From: naresh.kamboju@linaro.org (Naresh Kamboju)
Date: Tue, 18 Feb 2014 20:00:21 +0530
Subject: [LTP] How to get the Linux kernel coverage data on ARM arch when
 I run LTP test?
In-Reply-To: <52FDE52A.4070002@linux.vnet.ibm.com>
References: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
 <52FDE52A.4070002@linux.vnet.ibm.com>
Message-ID: <CA+G9fYv9+Fhyz=nVZQZXxLU0YMTJadfr1XVVVb9P=inEfUaDuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 February 2014 15:13, Peter Oberparleiter
<oberpar@linux.vnet.ibm.com> wrote:
> On 14.02.2014 10:02, Naresh Kamboju wrote:
>> root at linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov kernel/gcov/base.c -o
>>  /sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gcov/
>> File 'kernel/gcov/base.c'
>> Lines executed:43.18% of 44
>> Creating 'base.c.gcov'
>>
>> root at linaro-developer:/tmp/linux-linaro-3.13-2014.01#
>>
>> The above experiment gives coverage of a single file base.c when i run
>> gcov manually.
>> Is there any way to get Linux kernel coverage of all files after
>> running LTP test cases ?
>
> 1. Reset coverage data: lcov -z
> 2. Run LTP (or any other test case)
> 3. Capture coverage data: lcov -c -o coverage.info
> 4. Generate HTML output: genhtml coverage.info -o out
> 5. View HTML output: <browser> out/index.html

It is working !!!
LTP executed on linux-linaro build on vexpress-tc2 target.
Please find results obtained
http://people.linaro.org/~naresh.kamboju/linux-linaro-coverage-by-ltp/

The plan is to run all linaro test suite and to get coverage date.

Peter Oberparleiter,
Thank you very much for your help.

Best regards
Naresh Kamboju

>
> More information on lcov can be found on the page behind the second URL
> your quoted in your mail.
>
>
> Regards,
>   Peter Oberparleiter
>
> --
> Peter Oberparleiter
> Linux on System z Development - IBM Germany
>
