From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 11 Jul 2011 22:38:21 +0800
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <4E1AB446.4000903@scram.de>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>
	<20110710092426.GR4812@n2100.arm.linux.org.uk>
	<4E1AB446.4000903@scram.de>
Message-ID: <CAK5ve-K5t2xWyXPjmFsrnxd472iyoFsWkWcuG5h3-VBn2EgESw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 4:28 PM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Russell,
>
>>> +fs_initcall(simpad_leds_init);
>>
>> Looks like simpad is similarly afflicted. ?I haven't gone through the
>> rest to check for similar issues.
>
> simpad is buggy in other means, as well (wrong bit, read of write-only
> register, missing locking). That's why I want to push my CS3 cleanup patch
> first, converting a custom IO to standard GPIO ;-)
>

if you can use this GPIO based gpio_led driver, there is not such
fs_initcall issue.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
