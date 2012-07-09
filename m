From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Jul 2012 09:41:38 -0700
Subject: [PATCH v2 1/2] ARM: OMAP: board-4430sdp: MUX configuration for
 sys_nirq2
In-Reply-To: <4FFAA6AF.2010004@ti.com> (Peter Ujfalusi's message of "Mon, 09
 Jul 2012 11:38:55 +0200")
References: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
 <1341580752-5501-2-git-send-email-peter.ujfalusi@ti.com>
 <874nplc6va.fsf@ti.com>
 <CAMQu2gx4927Ze9tRUFq9QPubGFWfK9bHqZhVCb7c39O=WeWA3Q@mail.gmail.com>
 <4FFAA6AF.2010004@ti.com>
Message-ID: <87d344x4xo.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> On 07/06/2012 04:33 PM, Shilimkar, Santosh wrote:
>>> Since this is TWL6030 specific, it should rather be done in TWL code
>>> like I did for sys_nirq1:
>>>
>>>    http://marc.info/?l=linux-omap&m=134090312118873&w=2
>>>
>>> That would avoid having to do this in both board files.
>>>
>> Though the pin is TWL specific, it need not be same on
>> different board with different SOCs. Especially when you need to
>> set MUX mode etc. So doing from board file is still better
>> since TWL6030/40 can be connected to non OMAP4 devices
>> where the muxing can be different.
>> 
>> With current know boards with TWL6030/40, this is not
>> a strong requirement though.
>
> There can be board which has twl6030 but does not have twl6040.
> The twl6040 is the recommended audio solution for OMAP4+ systems but it can be
> replaced by other codec on some boards.
> This is the reason I have put the mux configuration into the board files for
> sys_nirq2 (which is in these cases are used to handle the interrupt from twl6040).

OK, sounds right.  Thanks for the clarification.

Kevin
