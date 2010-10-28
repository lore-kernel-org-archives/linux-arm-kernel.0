From: chris@alcor.co.uk (Chris Down)
Date: Thu, 28 Oct 2010 17:30:39 +0100
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <4CC99761.5080602@evidence.eu.com>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>	<4CBD8EE4.5040808@evidence.eu.com>	<i9ka0s$4ua$1@dough.gmane.org>	<201010191727.53314.alexander.stein@systec-electronic.com>	<i9kk4o$svc$1@dough.gmane.org>
	<4CC418A9.6090602@evidence.eu.com> <4CC99259.6080300@alcor.co.uk>
	<4CC99761.5080602@evidence.eu.com>
Message-ID: <4CC9A52F.3040808@alcor.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/10/2010 16:31, Claudio Scordino wrote:
> Chris Down ha scritto:
>> Just a minor issue.
>>
>> On 24/10/2010 12:29, Claudio Scordino wrote:
>>> +4. USAGE FROM USER-LEVEL
>>> +
>>> +   From user-level, RS485 configuration can be get/set using the previous
>>> +   ioctls. For instance, to set RS485 you can use the following code:
>>> +
>>> +	#include <linux/serial.h>
>>> +
>>> +	/* Driver-specific ioctls: */
>>> +	#define TIOCGRS485      0x542E
>>> +	#define TIOCSRS485      0x542F
>>> +
>>> +	/* Open your specific device (e.g., /dev/mydevice): */
>>> +	int fd = open ("/dev/mydevice", O_RDWR);
>>> +	if (fd < 0) {
>>> +		/* Error handling. See errno. */
>>> +	}
>>> +
>>> +	struct serial_rs485 rs485conf;
>>> +
>>> +	/* Set RS485 mode: */
>>> +	rs485conf.flags |= SER_RS485_ENABLED;
>>> +
>>> +	/* Set rts delay before send, if needed: */
>> This comment is misleading as the delay must be set regardless.
>> If it is not used it should be set to 0.
>>
>>> +	rs485conf.flags |= SER_RS485_RTS_BEFORE_SEND;
>>> +	rs485conf.delay_rts_before_send = ...;
> 
> Hi.
> 
> What do you mean ?
> 
> The delay has not to be set regardless: if the
> SER_RS485_RTS_BEFORE_SEND flag is not set, then the value of
> delay_rts_before_send is ignored, whatever value is contained.
> 
> In other words, the value of delay_rts_before_send is used only when
> SER_RS485_RTS_BEFORE_SEND is set.
> 
> If you don't need a delay, you have to unset the
> SER_RS485_RTS_BEFORE_SEND flag rather than setting a delay equal to 0...
> 
> Best regards,
> 
> 	Claudio
 

In that case perhaps it is best to mention that in the comment.
i.e. if the delay is not needed unset the flag as it defaults to set.


Best regards

Chris
