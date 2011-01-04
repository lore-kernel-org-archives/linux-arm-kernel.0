From: mina86@mina86.com (=?UTF-8?Q?Micha=C5=82_Nazarewicz?=)
Date: Tue, 4 Jan 2011 17:59:01 +0100
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <C832F8F5D375BD43BFA11E82E0FE9FE00829C13EB2@EXDCVYMBSTM005.EQ1STM.local>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<C832F8F5D375BD43BFA11E82E0FE9FE00829C13EB2@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <AANLkTim38-vyKzKg8UDzffX2jWAJrgQNJZd=rd7gbpCc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Russell King wrote:
>> Has anyone addressed my issue with it that this is wide-open for
>> abuse by allocating large chunks of memory, and then remapping
>> them in some way with different attributes, thereby violating the
>> ARM architecture specification?

2011/1/4 Johan MOSSBERG <johan.xx.mossberg@stericsson.com>:
> Where in the specification (preferably ARMv7) can I find
> information about this? Is the problem that it is simply
> forbidden to map an address multiple times with different cache
> setting and if this is done the hardware might start failing? Or
> is the problem that having an address mapped cached means that
> speculative pre-fetch can read it into the cache at any time,
> possibly causing problems if an un-cached mapping exists?

IIRC both apply.
