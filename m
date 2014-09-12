From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 12 Sep 2014 09:23:24 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de>
 <20140911151114.GD28458@ci00147.xsens-tech.local>
 <5411C810.7070906@linutronix.de>
 <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
Message-ID: <54129F6C.7040508@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2014 07:04 PM, Frans Klaver wrote:
> On 11 September 2014 18:04:32 CEST, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> On 09/11/2014 05:11 PM, Frans Klaver wrote:
>>
>>> I can still reproduce it on am335x. I can get out of it as soon as
>>> something else gets written to the console though.
>>>
>>> # echo "<3>something" >/dev/kmsg
>>
>> Is this to stall it or to get out of it?
> 
> This is to get out of it. I do this from an ssh connection after the console got stuck. The 3 kind of ensures the message is actually sent to ttyS0.

Interesting. This shouldn't do anything. If there is a TX operation in
progress then ->start_tx() will simply return and the xmit buffer will
be send once the current TX operation completes.

Is there anything I can do to reproduce this behavior?
This problem only pops-up if you use DMA. With disabled DMA you don't
see this, right?

Sebastian
