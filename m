From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 08 Nov 2014 22:01:37 +0100
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
In-Reply-To: <CALT56yNOXq-ssvsjafz=ae+uWv1GyscoQ3RQ_h--i740zm4trA@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Sat, 8 Nov 2014 23:55:49
 +0400")
References: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
 <CALT56yOCBN1NAfNw=vThVZ_o=ONGOTvzKHBH5tCTQShJY0wkrQ@mail.gmail.com>
 <87lhnlwqm4.fsf@free.fr>
 <CALT56yNOXq-ssvsjafz=ae+uWv1GyscoQ3RQ_h--i740zm4trA@mail.gmail.com>
Message-ID: <8761epwgni.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> 2014-11-08 20:26 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>>
>>> Hello,
>>> Tested in qemu (pxa25x target).
>>>
>>> 2) sa1100-rtc could not find a clock and thus failed to be probed.
>>> 4) Got an issue with IrDA driver - it gets -ENODEV for UARTCLK clock
>>
>> Hi Dmitry,
>>
>> Would you mind retesting with the patch in [1] applied to see if points 2 and 4
>> are fixed ? Alternatively you can refetch from the github tree, I included that
>> incremental patch there too.
>>
>> If it works correctly for you, could I have your Tested-by ? If not, tell me and
>> I'll try to figure out what's wrong.
>
> Tested in qemu, everything works fine. I will test on the real hardware
> tomorow.
Aha, the test.
Would you at that time do a "cat /sys/kernel/debug/clk/clk_summary" and send it
to me please ?

>
> BTW: It looks like pxa27x also shows the same behaviour wrt. sa1100-rtc and
> pxa2xx-ir (after reverting a revert).
Ah yes, you're very right about that.

Same as before, github updated and patch included in this mail.

Cheers.

-- 
Robert

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-clk-pxa-add-missing-clocks-for-Irda-and-sa1100-rtc.patch
Type: text/x-diff
Size: 1945 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141108/d3e8e121/attachment.bin>
