From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 21 Sep 2018 12:11:33 +0200
Subject: Kernel memory leak on CDC-ACM device plug/unplug
In-Reply-To: <1537517304.15252.0.camel@suse.com>
References: <CAGkQfmP6o+e_nanviTfRt7Ej9U+4BdqDYvMM83FjHhSCECcH3w@mail.gmail.com>
 <1537517304.15252.0.camel@suse.com>
Message-ID: <CAGkQfmNYHtBwt14e-gqSKfg7iUQSpitxkCOo9m-q+rcSvp656w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-21 10:08 GMT+02:00 Oliver Neukum <oneukum@suse.com>:
> On Mi, 2018-09-19 at 16:11 +0200, Romain Izard wrote:
>> While trying to debug a memory leak problem, I encountered the following
>> problem:
>>
>> After plugging/unplugging an USB CDC-ACM device, kmemleak reports multiple
>> copies of the following leak. It is not necessary to open the port for the
>> leak to happen.
>
> Hi,
>
> nothing is immediately obvious to me. Could you compile a kernel with
> CONFIG_DEBUG_KMEMLEAK?
>


The fix for this issue is the following patch:
https://www.spinics.net/lists/linux-usb/msg172850.html

Best regards,
-- 
Romain Izard
