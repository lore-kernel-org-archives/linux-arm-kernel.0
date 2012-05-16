From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 16 May 2012 17:18:47 +0300
Subject: [PATCH v1 4/7] usb: chipidea: add imx driver binding
In-Reply-To: <20120516130823.GA30755@b20223-02.ap.freescale.net>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
 <1337090303-16046-5-git-send-email-richard.zhao@freescale.com>
 <878vgscq4b.fsf@ashishki-desk.ger.corp.intel.com>
 <20120516130823.GA30755@b20223-02.ap.freescale.net>
Message-ID: <87txzgb454.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> On Wed, May 16, 2012 at 02:38:44PM +0300, Alexander Shishkin wrote:
>> > +	plat_ci = platform_device_alloc("ci_hdrc", (int)res->start);
>> 
>> Regarding the instance id here: you probably want to use something more
>> meaningful than the starting address. I was thinking about stealing id
>> allocator from Felipe's dwc3 (dwc3_get_device_id()), but decided to
>> first deal with more important things.
> hmm... Is dwc3_get_device_id() really meaningful than base address?
> It just record the sequence number.

Well, if you indeed have more than one controller, you might want to
know, for example, which one registered first. Or, one might simply not
like the look of "/sys/bus/platform/devices/ci_hdrc.-5898240".

Regards,
--
Alex
