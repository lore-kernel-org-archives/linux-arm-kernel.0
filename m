From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 16:23:51 +0530
Subject: Pinctrl crash on latest linux-next/master
Message-ID: <4F8BFA3F.5030409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I don't know if the issue is in my patches or something else, but i was
able to boot it earlier. Till my V3 for pinctrl. And nothing much changed
since then, i just rebased on latest kernel.

Now, kernel crashes like:

....

pinctrl core: initialized pinctrl subsystem
Registered protocol family 16
driver_bound: device b4000000.pinmux already bound
Unhandled fault: alignment exception at 0xffffffe
Internal error: ARM Modules linked in

...
...

next_device+0x10/0x1c
bus_for_each_dev+0x68/0x84
driver_attach
...
...
spear310_pinctrl_init+0x14/0x1c

[Sorry if crash log doesn't look nice.
I have written this crash log manually, as i didn't got this on console.
I copied it from log_buf global variable.]

-- 
viresh
