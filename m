From: stigge@antcom.de (Roland Stigge)
Date: Thu, 08 Mar 2012 23:01:00 +0100
Subject: [PATCH RESEND v3] USB: Support for LPC32xx SoC
In-Reply-To: <20120308211120.GB21058@kroah.com>
References: <1331068913-9321-1-git-send-email-stigge@antcom.de>
 <20120308211120.GB21058@kroah.com>
Message-ID: <4F592C1C.1050909@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/12 22:11, Greg Kroah-Hartman wrote:
>> -	pnx4008_unset_usb_bits();
>> +	if (machine_is_pnx4008())
>> +		pnx4008_unset_usb_bits();
> 
> How come some of these pnx4008_* functions you have wrapped in
> machine_is_pnx4008(), but not all of them?
> 
> Actually, why don't those functions do that kind of checking themselves,
> without having to do this before you call them each time?

Good idea, I moved the machine dependent execution of the bits()
functions into the functions.

The dependency is only in the bits functions because those are done via
interfaces not available on LPC. The other pnx4008 functions seem to be
mostly compatible.

Thanks for your notes!

Roland
