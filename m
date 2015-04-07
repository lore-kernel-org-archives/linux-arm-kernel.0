From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 07 Apr 2015 13:05:39 -0400
Subject: [PATCH v6 10/15] serial: stm32-usart: Add STM32 USART Driver
In-Reply-To: <55240B2C.3020102@suse.de>
References: <1428424234-28572-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1428424234-28572-11-git-send-email-mcoquelin.stm32@gmail.com>
 <55240B2C.3020102@suse.de>
Message-ID: <55240E63.3040502@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 04/07/2015 12:51 PM, Andreas F?rber wrote:
> Am 07.04.2015 um 18:30 schrieb Maxime Coquelin:
>> This drivers adds support to the STM32 USART controller, which is a
>> standard serial driver.
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  drivers/tty/serial/Kconfig       |  17 +
>>  drivers/tty/serial/Makefile      |   1 +
>>  drivers/tty/serial/stm32-usart.c | 735 +++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/serial_core.h |   3 +
>>  4 files changed, 756 insertions(+)
>>  create mode 100644 drivers/tty/serial/stm32-usart.c
> [...]
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
>> new file mode 100644
>> index 0000000..4adc430
>> --- /dev/null
>> +++ b/drivers/tty/serial/stm32-usart.c
> [...]
>> +#define DRIVER_NAME "stm32-usart"
>> +#define STM32_SERIAL_NAME "ttyS"
> 
> I'm surprised no one has complained about ttyS yet. Doesn't that need to
> be unique, such as ttySTM (efm32 uses ttyefm), to avoid clashes between
> serial drivers? ttyS was exclusive to the 8250 driver, I thought.

As long as this platform doesn't support 8250 h/w, I don't care; and
by the time this platform is ready for multiconfig, I'll have ttyS
coexistence fixed.

Regards,
Peter Hurley
