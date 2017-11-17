From: pbrobinson@gmail.com (Peter Robinson)
Date: Fri, 17 Nov 2017 12:16:22 +0000
Subject: [GIT PULL 1/2] bcm2835-dt-fixes-2017-10-06
In-Reply-To: <87k1yqq8j0.fsf@anholt.net>
References: <20171006220504.7776-1-eric@anholt.net>
 <edb03edb-f2a6-549e-6060-eccfae554d92@gmail.com>
 <CAJsfgeU5Zq-2zSfto8WUZ5Xud1Ksedu9XdLG9pWR7YBZGVaHBA@mail.gmail.com>
 <CALeDE9NsjYHpaR6kyHgABGr2eE=EhpJstttK60WwRkAj0u1m7Q@mail.gmail.com>
 <910a98ca-57f6-baca-73ac-f6c8c1ff04db@i2se.com>
 <CALeDE9Oi+DvoJ6X22ButaQxHNyqBzg=H1-mb69_g-rp4RR_fqw@mail.gmail.com>
 <F3464528-76E5-4F11-BD58-DEB56410687B@holtmann.org>
 <CALeDE9OySr2LpcedpTHnz89aFYAk2CknKGHeVx+4ecFCemYZPw@mail.gmail.com>
 <87k1yqq8j0.fsf@anholt.net>
Message-ID: <CALeDE9M9QQtJOhOjNdsAmpWkAFG9DvLOOiyPyqbbp00cuN+BMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>>>> Mainline boots fine if I use console=ttyS1 or drop the console arg
>>>>>>> altogether, but as we don't currently support different boot args per
>>>>>>> tree, and we don't have the manpower to track this patch in all the
>>>>>>> trees we test, we will have to switch to only boot testing mainline
>>>>>>> from now on.
>>>>>> Yes, I've seen the same in Fedora with that patch.
>>>>>>
>>>>>>
>>>>> could you please describe the issue more in detail.
>>>>>
>>>>> Does u-boot or Linux hang? Does u-boot select the wrong UART? Is there a
>>>>> pinmux conflict?
>>>>
>>>> Basically on the RPi3 you use to get ttyAMA0 and ttyS0 but now the
>>>> later is ttyS1
>>>
>>> which UART is which now. It should expose the Bluetooth UART correctly now. And also more importantly usable. The only missing piece with 4.14 would be the DT assigned for serdev. While 4.14 would still require a call to btattach, starting with 4.15 that should no longer be needed.
>>
>> Looks to be ttyAMA0
>>
>> [    4.480469] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 72,
>> base_baud = 0) is a PL011 rev2
>> [    4.497401] serial serial0: tty port ttyAMA0 registered
>>
>> With 4.14 I get the following, the address doesn't look right, do you
>> have a link to the serdev patch headed to 4.15?
>
> https://github.com/anholt/linux/commit/fd3372db18d3d44ae4579243a8eacb5247d8c03a

We already have that one included in the Fedora kernel, I wonder what
else I'm doing wrong.
