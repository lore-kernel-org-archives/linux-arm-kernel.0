From: david.engraf@sysgo.com (David Engraf)
Date: Mon, 30 Apr 2018 08:11:05 +0200
Subject: [PATCH v2] i2c: at91: Read all available bytes at once
In-Reply-To: <20180428123838.abxiht7k4egv7iel@ninjato>
References: <20180426082558.GX13305@rfolt0960.corp.atmel.com>
 <20180426095314.12758-1-david.engraf@sysgo.com>
 <20180428123838.abxiht7k4egv7iel@ninjato>
Message-ID: <d728f2ac-5763-48af-03b5-571a75265281@sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.04.2018 um 14:38 schrieb Wolfram Sang:
> On Thu, Apr 26, 2018 at 11:53:14AM +0200, David Engraf wrote:
>> With FIFO enabled it is possible to read multiple bytes
>> at once in the interrupt handler as long as RXRDY is
>> set. This may also reduce the number of interrupts.
>>
>> This patch polls RXRDY and reads all available bytes at
>> once.
>>
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> 
> checkpatch said twice:
> 
> WARNING: line over 80 characters
> 
> While I am not super-strict with this limit, it makes sense here IMO.
> The comment stays readable, and we don't even lose a line.

Sorry for that.

> Fixed it this time for you.

Thanks
- David

> Applied to for-next, thanks!
> 
