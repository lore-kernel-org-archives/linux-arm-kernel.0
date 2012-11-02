From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Fri, 2 Nov 2012 12:04:45 +0100
Subject: [PATCH] i2c: at91: add a sanity check on i2c message length
In-Reply-To: <20121101222922.GD22956@pengutronix.de>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de>
Message-ID: <5093A8CD.60006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Le 11/01/2012 11:29 PM, Wolfram Sang a ?crit :
> On Wed, Oct 10, 2012 at 04:25:58PM +0200, ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> If the i2c message length is zero, i2c-at91 will directly return an error
>> instead of trying to send a zero-length message.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> What happens if you send a 0 byte message? Some hardware is able to do
> this and it will be used in SMBUS QUICK which the driver states to
> support according to at91_twi_func().

Without this I had some data corruption when writing to / reading from a 
serial eeprom (depending on the IP version).

Yes SMBUS quick command is supported but is not managed in the driver, 
we have to tell explicitly the IP that we want to send this command.


Regards

Ludovic

>
> Regards,
>
>     Wolfram
>
