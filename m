From: jcm@redhat.com (Jon Masters)
Date: Sat, 3 Dec 2016 15:33:15 -0500
Subject: [SPCR] mmio32 iotype access requirements for X-Gene 8250(_dw) UART
In-Reply-To: <1480785308.4751.41.camel@redhat.com>
References: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
 <6d593615-e97f-8738-42be-1f8f4906d2f4@redhat.com>
 <CADaLNDkyCrheZLNG3_9BVgvGBW8WrA-VPWOCezz3U-g+nt5W9w@mail.gmail.com>
 <175F32B0-C73F-4250-9E60-3CE7409F0B0C@redhat.com>
 <CADaLNDmWRn+UKzF8PH2LmYCSF+NhHaw26RTN+QoaByh1wS7jfQ@mail.gmail.com>
 <7fa523de-3fbb-1566-f521-927143f73d1e@redhat.com>
 <1480785308.4751.41.camel@redhat.com>
Message-ID: <c6a0c134-2fde-21c2-03fb-6e1961161a26@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 12/03/2016 12:15 PM, Mark Salter wrote:
> On Sat, 2016-12-03 at 05:06 -0500, Jon Masters wrote:

>> There is a broader problem with X-Gene SPCR support. The problem is
>> that the 16550 UART in X-Gene requires the 32-bit access quirk (the
>> iotype is set to UPIO_MEM32 for the APMC0D08 device). This means
>> that when univ8250_console_match runs later, it will compare the
>> iotype (MEM32) with the type previously registered with the
>> kernel when the earlycon setup the preferred console.
> 
> Linaro has a kernel patch which looks at the bit_width field of the
> port address:
> 
> Author: Aleksey Makarov <aleksey.makarov@linaro.org>
> Date:   Thu Apr 28 19:52:38 2016 +0300
> 
>     serial: SPCR: check bit width for the 16550 UART
> 
> The SPCR in 3.06.25 firmware has a bit_width field set to 32 and with the
> above patch, I don't need to use console=. But HP firmware on m400 sets
> bit width to 8 so that needs a firmware fix to work with above.

Indeed, thanks. Graeme also mentioned that last night. I think this
a good solution for the moment, but still that it makes sense to
have a new 16650 UART type defined in the DBG2 spec for those
requiring 32-bit access (to mirror the type D for pl011). I
heard back from Microsoft this morning that they're looking.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
