From: claudio@evidence.eu.com (Claudio Scordino)
Date: Mon, 22 Mar 2010 12:15:25 +0100
Subject: [PATCH] atmel_serial: Atmel RS485 support
In-Reply-To: <4BA695E4.70105@bluewatersys.com>
References: <4BA335A8.1000205@evidence.eu.com>
	<4BA695E4.70105@bluewatersys.com>
Message-ID: <4BA7514D.3020901@evidence.eu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

    first of all, thank you for your feedback.

To me, all comments seem to be reasonable, except maybe the following one:

>>  
>> +static void atmel_start_rx(struct uart_port *port);
>> +static void atmel_stop_rx(struct uart_port *port);
> 
> Can you move these functions, so that these declarations are not needed?

Actually, atmel_stop_rx is already defined, and I prefer to not move it 
(since I change it, people may get confused by the diff...).
I also think that atmel_start_rx (which is added by the patch) should be 
near to atmel_stop_rx...



>> +        UART_PUT_IDR(port, ATMEL_US_ENDRX | ATMEL_US_TIMEOUT |
>> port->read_status_mask);
> 
> This line, and a couple of others, extend over 80 characters. Could you
> please split them up.

Of course. I'm going to split them up and use a backslash at the end of 
  the original lines.


I will create a new patch according to your comments, test it and submit 
again to the mailing list.

Many thanks again,

                 Claudio
