From: jebediah.huang@gmail.com (Jebediah Huang)
Date: Mon, 8 Feb 2010 15:56:10 +0800
Subject: Using PXA arm board with MAX7319 GPIO expander input
In-Reply-To: <20100208073612.GV28972@buzzloop.caiaq.de>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
	<f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
	<bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
	<20100208073612.GV28972@buzzloop.caiaq.de>
Message-ID: <bf0eec9a1002072356x443c729fpa1c4a8c72209dfec@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2010 at 3:36 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Mon, Feb 08, 2010 at 03:02:14PM +0800, Jebediah Huang wrote:
>>
>> output if max732x enabled is:
>> # ./i2ctest
>> [ ?184.070025] i2c: error: exhausted retries
>> fd=3
>> t=-1
>> [ ?184.074256] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
>> [ ?184.080428] i2c: ICR: 000007e0 ISR: 00000002
>> [ ?184.080444] i2c: log: [00000006:00000000] [00000006:00000000]
>> [00000006:00000000] [00000006:00000000] [00000006:00000000]
>> [00000006:00000000] [00000006:00
>> 000000] [00000006:00000000] [00000006:00000000] [00000006:00000000]
>> [00000006:00000000] [00000007:00000000] [00000447:000007e0]
>> t=-1
>
> How do you enable/disable the chip? As Eric said, the error above
> indicates an eletrical issue with the bus.

I disable by doing menuconfig and disable max732x:

# CONFIG_GPIO_MAX732X is not set

>
>> disable max732x is:
>> # ./i2ctest no button pressed
>
> What are you testing without the chip?
>

I am testing the I2C from i2ctest application using I2C_PXA.
