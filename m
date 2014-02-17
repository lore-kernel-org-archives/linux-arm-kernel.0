From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Mon, 17 Feb 2014 11:42:33 -0300
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <53021BD2.3090301@free-electrons.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140205183457.GW8533@titan.lakedaemon.net>
 <20140217141336.GA2765@localhost> <53021BD2.3090301@free-electrons.com>
Message-ID: <53021FD9.2070406@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory, Ezequiel,

 >> Are we still in time to consider Emilio's oneline proposal?
>> (Emilio: would you mind preparing a suitable patch against dove,
>> kirkwood, armada370/xp, so we can see the real thing?).

The patch is in a common file, so it does not need patching anything for 
each platform.

> I am still strongly against this proposal because hard-coded the parent
> clock name in the driver seems very wrong

It is hardcoded already when the parent is registered, so I do not 
understand your concern.

http://lxr.free-electrons.com/source/drivers/clk/mvebu/common.c?v=3.13#L34

> and moreover in some circumstances
> (if there is no output-name, which is our default case) this proposal
> just ignored the parent clock given by the device tree and this looked
> more wrong.

I have sent a second patch addressing this comment, but you do not seem 
to have taken too serious a look at it.

http://www.spinics.net/lists/arm-kernel/msg305922.html

Cheers,

Emilio
