From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue, 3 Apr 2018 14:08:43 +0300
Subject: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
In-Reply-To: <20180403081041.3ully6bcyfwx2cx6@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
Message-ID: <4390604e-092b-a89d-3581-b57ee9cbb6a1@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 11:10 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
>> There is no need to handle 3/4 empty/full interrupts as the maximum
>> supported transfer length in PIO mode is 64 bytes for sun4i-family
>> SoCs.
> That assumes that you'll be able to treat the FIFO full interrupt and
> drain the FIFO before we have the next byte coming in. This would
> require a real time system, and we're not in one of them.
>
> Maxime
>
AFAIK in SPI protocol we send and receive at the same time. As soon as 
the transfer length

is <= FIFO depth then it means that@the moment we get TC interrupt 
all data for this transfer

sent/received already.

Is your point here that draining FIFO might be a long operation and we 
can lose next portion of data ?
