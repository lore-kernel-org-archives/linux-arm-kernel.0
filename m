From: joelf@ti.com (Joel Fernandes)
Date: Fri, 18 Apr 2014 11:40:12 -0500
Subject: [patch 5/6] edma: Make reading the position of active channels
 work
In-Reply-To: <alpine.DEB.2.02.1404181123150.22697@ionos.tec.linutronix.de>
References: <20140417133737.892475126@linutronix.de>
 <20140417143249.889774979@linutronix.de> <5350761C.6010109@ti.com>
 <alpine.DEB.2.02.1404180834520.22697@ionos.tec.linutronix.de>
 <alpine.DEB.2.02.1404181123150.22697@ionos.tec.linutronix.de>
Message-ID: <5351556C.7000807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2014 04:24 AM, Thomas Gleixner wrote:
> On Fri, 18 Apr 2014, Thomas Gleixner wrote:
>> On Thu, 17 Apr 2014, Joel Fernandes wrote:
>>> Here's a thread that discusses it and the end conclusion is that it
>>> should be fine (Kyle Kastile is one of the EDMA hardware designers).
>>> http://e2e.ti.com/support/dsp/davinci_digital_media_processors/f/99/t/66011.aspx
>>
>> Gah, right I saw the issues with the original code, which does a
>> memcpy_fromio which copies byte by byte. Did not think about retrying
>> with the edma_read() based one.
> 
> Actually I did expect memcpy_fromio to be more clever. But you are
> right, using the 32bit wide read works like a charm.

Cool, glad it does :)

regards,
  -Joel
