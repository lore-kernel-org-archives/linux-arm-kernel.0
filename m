From: mpeg.blue@free.fr (Mason)
Date: Thu, 29 Jan 2015 17:43:19 +0100
Subject: RFC on cpufreq implementation
In-Reply-To: <54B7F7CD.7030903@free.fr>
References: <54B7F7CD.7030903@free.fr>
Message-ID: <54CA6327.5070707@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2015 18:24, Mason wrote:

> This is a follow-up to my previous thread.
> "How many frequencies would cpufreq optimally like to manage?"
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669

OK, so this is my TAKE 2 on the cpufreq driver, trying to remove
some dependencies on machine-specific definitions by getting the
virtual address at init via ioremap. (Is -EFAULT the right error
to return if ioremap fails?)

I'm not sure where machine-specific information is supposed to
be stored though? Such as register definitions, or the physical
addresses/offsets. What if they need to be shared among several
source files? I can't just duplicate them... (I've tentatively
called it temp.h for the time being.)

Regards.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpufreq.c
Type: text/x-csrc
Size: 2567 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/ee612bdc/attachment.bin>
