From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Nov 2012 01:04:37 -0800
Subject: [PATCH] mfd: vexpress-sysreg: Remove LEDs code
In-Reply-To: <20121121085539.GR7615@quad.lixom.net>
References: <1353332344-16754-1-git-send-email-pawel.moll@arm.com>
 <20121121085539.GR7615@quad.lixom.net>
Message-ID: <CAOesGMgJqPCXNxfEA+=NVE_yMtSKS_vnzNkT9Of9bqw0t5iMww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 12:55 AM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Nov 19, 2012 at 01:39:04PM +0000, Pawel Moll wrote:
>> As the current LEDs code breaks other platform, remove it.
>>
>> It shall be replaced by a generic "MMIO LEDs" driver.
>>
>> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
>> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
>> ---
>>  drivers/mfd/vexpress-sysreg.c |   77 -----------------------------------------
>>  1 file changed, 77 deletions(-)
>>
>> Hi Arnd,
>>
>> As I haven't managed to get any feedback on the generic MMIO
>> LEDs driver so far, I have to postpone it till next cycle and
>> completely remove the LED-related code from the vexpress-sysreg
>> driver, as it breaks other platforms today.
>>
>> Would you be so kind to apply this patch, please? Alternatively
>> you can pull it from here:
>>
>>   git://git.linaro.org/people/pawelmoll/linux.git vexpress-soc2
>>
>> (this branch is based on the vexpress-soc you already have)
>
> Applied the patch on top of vexpress/soc, and merged in that branch into
> next/soc again (it had been reverted due to the issues)

Actually, I replaced our current vexpress/soc with the latest one you
had sent a pull request from before, since it had the appropriate
dependencies with the clock tree sorted out
(git://git.linaro.org/people/pawelmoll/linux.git vexpress-clk-soc).


-Olof
