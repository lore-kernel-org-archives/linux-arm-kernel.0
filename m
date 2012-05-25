From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 25 May 2012 12:49:46 +0300
Subject: [PATCH v3 05/12] usb: chipidea: add imx platform driver
In-Reply-To: <20120525085109.GB18733@b20223-02.ap.freescale.net>
References: <1337912665-16615-1-git-send-email-richard.zhao@freescale.com>
 <1337912665-16615-6-git-send-email-richard.zhao@freescale.com>
 <87k400ac6x.fsf@ashishki-desk.ger.corp.intel.com>
 <20120525085109.GB18733@b20223-02.ap.freescale.net>
Message-ID: <87hav4a8ud.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> On Fri, May 25, 2012 at 11:37:26AM +0300, Alexander Shishkin wrote:
>> Richard Zhao <richard.zhao@freescale.com> writes:
>> 
>> > This patch supports only the host-mode functionality so far.
>> >
>> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> > Signed-off-by: Marek Vasut <marex@denx.de>
>> > Cc: Peter Chen <peter.chen@freescale.com>
>> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> > Cc: Felipe Balbi <balbi@ti.com>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |   20 ++
>> >  drivers/usb/chipidea/Makefile                      |    3 +
>> >  drivers/usb/chipidea/ci13xxx_imx.c                 |  189 ++++++++++++++++++++
>> 
>> One comment: I was going to suggest dropping "13xxx" suffix from
>> everywhere in the driver, maybe module names too, since it doesn't
>> really add any value and people often mistype it, so maybe for the new
>> code it makes sense to avoid it? ci-imx looks better than ci13xxx-imx
>> anyway and same goes for ci_imx_probe() vs ci13xxx_imx_probe().
>> Does this make sense to you?
> I'm not clear with the history. Does Chipidea only have one IP?

As far as their USB controllers go, there are several versions with
different features and register layouts, but essentially similar. I want
to support all of them with this driver. As for the other IPs designed
by chipidea -- I have no idea about those, but I don't think we should
care.

Regards,
--
Alex
