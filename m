From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 28 Oct 2011 15:35:23 +0800
Subject: [PATCH] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <20111028071129.GA2362@tarshish>
References: <1319772453-1275-1-git-send-email-Barry.Song@csr.com>
	<20111028071129.GA2362@tarshish>
Message-ID: <CAGsJ_4z=VtU+RJ4c0Y2ruttWU6mTVtHMxzvCYWGz=5w6i7QJMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/28 Baruch Siach <baruch@tkos.co.il>:
> Hi Barry,
>
> On Thu, Oct 27, 2011 at 08:27:33PM -0700, Barry Song wrote:
>> From: Rong Wang <Rong.Wang@csr.com>
>>
>> SiRFprimaII is the latest generation application processor from CSR?s
>> multi-function SoC product family.
>> The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
>> 3.0.
>>
>> There are three dedicated UARTs in system. This patch adds basic driver
>> support for them.
>>
>> It has used the newest pinmux subsystem from Linus Walleij.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Rong Wang <Rong.Wang@csr.com>
>> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> ---
>
> [snip]
>
>> +config SERIAL_SIRFSOC
>> + ? ? ? ?tristate "SiRF SoC Platform Serial port support"
>> + ? ? ? ?depends on ARM && ARCH_PRIMA2
>> + ? ? ? ?select SERIAL_CORE
>> + ? ? ? ?help
>> + ? ? ? ? ?Support for the on-chip UART on the CSR SiRFprimaII series,
>> + ? ? ? ? ?providing /dev/ttyS0, 1 and 2 (note, some machines may not
>> + ? ? ? ? ?provide all of these ports, depending on how the serial port
>> + ? ? ? ? ?pins are configured.
>
> Unbalanced parentheses.

Hi Baruch,
Thanks for reviewing! I sent this mail for Torvalds to pick seperately
since it depends on pinctl tree, and it was not gone through tty tree
since tty has no pinctrl before linus merges it.
This patch has been reviewed and acked in linux-serial, unfortunately,
missed this error.
i am not sure whether i will make Linus confused if i send a new
version at this moment. how about i send a seperate patch to fix this
after the driver is applied?

>
> baruch
>
> --
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~. .~ ? Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
> ? - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

-barry
