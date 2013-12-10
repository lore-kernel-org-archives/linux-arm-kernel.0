From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 11 Dec 2013 02:36:39 +0400
Subject: [PATCH v2 0/5]
In-Reply-To: <CALT56yN5XkQhKENHwg56+B8-oirQ0k-dL7_Vx=RQHQsgcyNhaA@mail.gmail.com>
References: <1384639650-3919-1-git-send-email-dbaryshkov@gmail.com>
 <CALT56yN5XkQhKENHwg56+B8-oirQ0k-dL7_Vx=RQHQsgcyNhaA@mail.gmail.com>
Message-ID: <CALT56yNWF_OJG-VJapoSTotwo1R6W+uNdPmx6Uy+O2CAKT=C8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Tue, Nov 26, 2013 at 3:08 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> On Sun, Nov 17, 2013 at 2:07 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> Please apply the following patches that fix the sa1100 framebuffer and PCMCIA
>> timings calculation if CPU frequency driver is not available.
>>
>> Changes since V1:
>> * Corrected patch adding sa1111 pcmcia device - offset was wrong.
>>
>> ----------------------------------------------------------------
>> Dmitry Eremin-Solenikov (5):
>>       arm: sa1100: add cpu clock
>>       fbdev: sa1100fb: make use of device clock
>>       pcmcia: sa1100: make use of device clock
>>       arm: sa1100: add a clock alias for sa1111 pcmcia device
>>       pcmcia: sa1111: make use of device clock
>
> Ping. Tested on collie (except sa1111).

Ping again. Without these patches: it is impossible to get framebuffer
to work on collie. Also adding these patches make it possible to disable
cpu freq thus saving few kb, which is important for kexecboot kernels.

Can we get at least first two patches, so that collie can have working FB?

-- 
With best wishes
Dmitry
