From: hustgqyang@gmail.com (yang gqyang)
Date: Sat, 10 Mar 2012 22:37:09 +0800
Subject: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
In-Reply-To: <CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com>
References: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
 <CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ@mail.gmail.com>
 <CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com>
Message-ID: <CAFawwkVuCTijwLr6UWVRh9XNGCt-8brr2f4aDrpM_YwkWSGP+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Thanks for your comment.
 Finally, i find out that i made a mistake.  The uart(8250) have not been
 restore after resume, instead, it use the configuration got from boot. The
 uart have not been restored correctly, so that "ls" can not output result
 correctly resulting in it seems that the busybox can not work correctly.
 Now, i still have a question about the uart: why the "printk" can work
 correctly, but the "printf" not?

 Before this, i believe that the "printk" work correctly, then the uart
 work ok. but now, i  need more reconsidaration about
 the relation between the "printk", "printf" and "uart".
 Can anyone give me some suggestion? Any comment is welcome, thanks a
 lot.


> ? 2012?3?9? ??10:08?Chenglie He <chengjie.he@linaro.org>???
>
>> Hi,
>>
>> I am doing this on A9, echo mem >/sys/power/state is right, will trigger
>> kernel to sleep.
>>
>> -jack

>
some recipient promote:
"The message contains HTML subpart, therefore we consider it SPAM or
Outlook Virus"
so i resend the email, hope it not disturb u. thanks a lot.
