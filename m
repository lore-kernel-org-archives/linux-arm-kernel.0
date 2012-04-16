From: stigge@antcom.de (Roland Stigge)
Date: Mon, 16 Apr 2012 17:40:34 +0200
Subject: [PATCH v2 1/3] USB: Add driver for NXP ISP1301 USB transceiver
In-Reply-To: <201204161414.14624.arnd@arndb.de>
References: <1334582166-5485-1-git-send-email-stigge@antcom.de>
 <201204161414.14624.arnd@arndb.de>
Message-ID: <4F8C3D72.8040307@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2012 04:14 PM, Arnd Bergmann wrote:
>> This driver needs to be probe()d before the respective USB driver using it. For
>> modules, this is handled via the module dependency. When linking statically, it
>> is done via linking order in the Makefile (misc/ before host/ and the gadget/).
> 
> You can easily avoid the link order restriction now by returning -EPROBE_DEFER
> from the probe function of the device that needs this one.

That's exactly what I was looking for! :-)

Same for the phandle idea.

Will include the resp. changes in the next update

Thanks,

Roland
