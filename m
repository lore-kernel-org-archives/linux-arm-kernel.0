From: lznuaa@gmail.com (Frank Li)
Date: Fri, 29 Jun 2012 17:20:59 +0800
Subject: How to use ARM ETM/ETB at linux?
In-Reply-To: <CAHrpEqQ35ut30VGBjJY+AMRkf0ufssepEwFJk4ALARdLMhc4fA@mail.gmail.com>
References: <CAHrpEqRk4SQ+8LHCOX0zwtZjnTe=k0c_GCJMqvYMZBUa-dJq=A@mail.gmail.com>
 <CACRpkdZv+Kp0apmLcZQgY07z1YQ3gC8r+d9Ed-c0OZLTo7DN6A@mail.gmail.com>
 <CAMP5Xgf=bxYJNpOp7od2jrG-SEKiVo=hGjMCMn6KVjKyw2+uJw@mail.gmail.com>
 <CAHrpEqQ35ut30VGBjJY+AMRkf0ufssepEwFJk4ALARdLMhc4fA@mail.gmail.com>
Message-ID: <CAHrpEqSd_pxxhtafRD5tYA411V+=diZui6hzP_AsUqMGFMy+=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Thank you for your reply. I will check trace-funnel with our IC team
> owner and update you.
> I have picked up below patch. Anything missed?
>
> * | 2d4660b ARM: etm: Power down etm(s) when tracing is not enabled
> * | 6e48ba5 ARM: etm: Support multiple ETMs/PTMs.
> * | c1db5d4 ARM: etm: Return the entire trace buffer if it is empty after reset
> * | 5b9dda1 ARM: etm: Add some missing locks and error checks
> * | 1a6825a ARM: etm: Configure data tracing
> * | 22a917b ARM: etm: Allow range selection
> * | 684b02b ARM: etm: Don't try to clear the buffer full status after reading th
> * | 86827c5 ARM: etm: Don't limit tracing to only non-secure code.
> * | 936c25b ARM: etm: Don't require clock control
>


Our SOC have trace-funnel. I config it and enable port. First time, I
dump etb and everything is 0xFFFFFF. After run the same command twice,
I get data 0000000000800c01000000000000000000000000

write 0x02144fb0 = 0xc5acce55 /unlock CSTF
write 0x02144000 = 0x31  //open port 1, I have tried open all ports
and same result.
write 0x02144fb0 = 0 //lock CSTF.

root at freescale /sys/devices/etm$ echo v >/proc/sysrq-trigger
SysRq : etm
Trace buffer contents length: 1
--- ETB buffer begin ---
ffffffff

--- ETB buffer end ---
root at freescale /sys/devices/etm$ echo v >/proc/sysrq-trigger
SysRq : etm
Trace buffer contents length: 1
--- ETB buffer begin ---
ffffffff

--- ETB buffer end ---
root at freescale /sys/devices/etm$ echo v >/proc/sysrq-trigger
SysRq : etm
Trace buffer contents length: 5
--- ETB buffer begin ---
0000000000800c01000000000000000000000000


>
>>
>>>>
>>>>
>>>> best regards
>>>> Frank Li
>>>
>>> Yours,
>>> Linus Walleij
>>
>>
>>
>> --
>> Arve Hj?nnev?g
