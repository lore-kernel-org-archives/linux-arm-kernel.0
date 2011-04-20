From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 21 Apr 2011 08:41:01 +1200
Subject: [RFC PATCH 02/23] at91: Make Ethernet device common
In-Reply-To: <20110420083636.GU31131@pengutronix.de>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<1303261827-27730-3-git-send-email-ryan@bluewatersys.com>
	<20110420083636.GU31131@pengutronix.de>
Message-ID: <4DAF44DD.5040502@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2011 08:36 PM, Uwe Kleine-K?nig wrote:
> Hello Ryan,
> 
> On Wed, Apr 20, 2011 at 01:10:05PM +1200, Ryan Mallon wrote:
>> Replace the individual Ethernet device code for each at91 variant with
>> a single implementation in devices.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

<snip>

>> -
>>  /* --------------------------------------------------------------------
>>   *  MMC / SD
>>   * -------------------------------------------------------------------- */
>> @@ -1587,6 +1551,14 @@ void __init at91_set_serial_console(unsigned portnr) {}
>>  void __init at91_add_device_serial(void) {}
>>  #endif
>>  
>> +static struct at91_device_table __initdata at91sam9g45_device_table = {
> The more correct position for __initdata is just before the =, see
> include/linux/init.h.

Okay, thanks. I will go through and fix this up. I'm also wondering if
all the data structures should be const?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
