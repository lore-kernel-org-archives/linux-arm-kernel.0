From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 08 Oct 2010 15:51:10 +0200
Subject: AT91: Fix power-saving in idle-mode on 926T processors
In-Reply-To: <20101008122918.GA30252@game.jcrosoft.org>
References: <20101007194415.GA24709@alarsen.net>
	<20101008122918.GA30252@game.jcrosoft.org>
Message-ID: <4CAF21CE.5000901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Le 08/10/2010 14:29, Jean-Christophe PLAGNIOL-VILLARD :
> On 21:44 Thu 07 Oct     , Anders Larsen wrote:
>> According to Atmel, their 926T processors (AT91 post RM9200) requires
>> 'Wait for Interrupt' mode be entered right after disabling the processor clock
>> in order to minimise current consumption when idle, so do both provided we're
>> not running on a 920T (an RM9200).
>>
>> Furthermore, get rid of the #ifndef CONFIG_DEBUG_KERNEL, since arch_idle()
>> can be turned off completely with the kernel parameter 'nohlt'.
>>
>> Signed-off-by: Anders Larsen <al@alarsen.net>
>> Cc: Andrew Victor <avictor.za@gmail.com>
> please rebase against this branch
> 
> git://github.com/at91linux/linux-2.6-at91.git branch for-rmk

This patch seems already in your "master" branch
(5c189208b606a85b4e97109af70d59f10a42fdfd).

Do you want me to rebase this patch or do you mange merging with "AT91:
fix use of clock disable on idle for AT91x40 devices"
(cb809b1a5ebffca8cf0314b788919989e8e4ab5f) ?
already in your "devel" and "devel-stable" branches?

Best regards,
-- 
Nicolas Ferre
