From: olof@lixom.net (Olof Johansson)
Date: Thu, 23 Nov 2017 11:40:21 -0800
Subject: mainline boot: 8 passed 1 failed (mainline/v4.14)
In-Reply-To: <CAK8P3a1OWob9We9zfvhBRN=fQYsw+nkZpqMJ9z6Q_A-N9_V3rQ@mail.gmail.com>
References: <5a16144d.0be9620a.4490d.4375@mx.google.com>
 <CAK8P3a1OWob9We9zfvhBRN=fQYsw+nkZpqMJ9z6Q_A-N9_V3rQ@mail.gmail.com>
Message-ID: <CAOesGMgdqNrZbF5dOEdHKmuNVZiiFoV0_ipsPBi5HkGZUgYm_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 1:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Nov 23, 2017 at 1:20 AM, Olof's autobooter <build@lixom.net> wrote:
>>
>> Full logs are available at http://arm-soc.lixom.net/bootlogs/mainline/v4.14/
>>
>> Failed boards:
>>
>>     arndale            arm-multi_v7_nosmp_defconfig  :  FAILED          1:15.09
>>
>> Successful boards:
>>     cubie2             arm-multi_v7_nosmp_defconfig  :  warnings        0:46.50
>> ...
>>
>>         Last entries of failed logs below:
>
> It looks like Olof's boot bot came back after a time without running
> any tests, and found
> a regression on Arndale when running with CONFIG_SMP disabled. cubie2 did not
> run into the same problem.
>
> The backtrace looks a bit suspicous. I can see __switch_to() calling
> the notifiers, which would be vfp_notifier_block and contextidr_notifier_block
> on both those machines.

I was doing a trial run with just a few boards, it's a bit premature
to claim it's back. I didn't mean for the email to go out.

Looks like kernelci doesn't cover CONFIG_SMP=n boots, so I guess this
might be a new issue.

I haven't automated the new setup yet, so this was a one-off. I'll
bisect it over the weekend.


-Olof
