From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 8 Aug 2011 10:28:49 +0800
Subject: [PATCH 1/2] drivers: create a pinmux subsystem v3
In-Reply-To: <CAGsJ_4yKHQGrY4kbwd+VPsg1ggj3wQqoN+uPLmh31RnhbroysQ@mail.gmail.com>
References: <1307984291-9774-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4yKHQGrY4kbwd+VPsg1ggj3wQqoN+uPLmh31RnhbroysQ@mail.gmail.com>
Message-ID: <CAGsJ_4yb4DNt4nSJHJcGMaL+U6KDRNj4sqkULu3jhwN2t_G6Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

>> diff --git a/Documentation/ABI/testing/sysfs-class-pinmux b/Documentation/ABI/testing/sysfs-class-pinmux
>> new file mode 100644
>> index 0000000..c2ea843
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-pinmux
>> @@ -0,0 +1,11 @@
>> +What:          /sys/class/pinmux/.../name
>> +Date:          May 2011
>> +KernelVersion: 3.1
>
> has this been ready for 3.1? we have been planning to write pinmux
> driver based on this framework.

What is the status of pincfg subsystem? what's the plan about merging
this subsystem?

>
>> +Contact:       Linus Walleij <linus.walleij@linaro.org>
>> +Description:
>> +               Each pinmux directory will contain a field called
>> +               name. This holds a string identifying the pinmux for
>> +               display purposes.
>> +
>> +               NOTE: this will be empty if no suitable name is provided
>> +               by platform or pinmux drivers.
>> diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
>> new file mode 100644
>> index 0000000..c4b6f48
>> --- /dev/null
>> +++ b/Documentation/pinctrl.txt
>> @@ -0,0 +1,397 @@
>> +PINCTRL (PIN CONTROL) subsystem
>> +This document outlines the pin control subsystem in Linux
>> +
>> +This subsystem deals with:
>> +
-barry
