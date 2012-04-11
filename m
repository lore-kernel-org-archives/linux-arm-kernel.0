From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 11 Apr 2012 17:29:07 +0530
Subject: [PATCHv7 01/18] I2C: OMAP: make omap_i2c_unidle/idle functions
 depend on CONFIG_PM_RUNTIME
In-Reply-To: <20120411113254.GE12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-2-git-send-email-shubhrajyoti@ti.com>
 <20120411113254.GE12064@arwen.pp.htv.fi>
Message-ID: <CAM=Q2csMkvbVwSav8d4KCXkcNS=oQGpPY2R-hiVzZvVPEngrog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Wed, Apr 11, 2012 at 5:02 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Apr 11, 2012 at 04:42:39PM +0530, Shubhrajyoti D wrote:
>> The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_resume
>> and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME.
>> This patch removes the omap_i2c_unidle/idle functions and folds them
>> into the runtime callbacks.
>>
>> This fixes the below warn when CONFIG_PM_RUNTIME is not defined
>>
>> ?CC ? ? ?arch/arm/mach-omap2/board-ti8168evm.o
>> drivers/i2c/busses/i2c-omap.c:272: warning: 'omap_i2c_unidle' defined but not used
>> drivers/i2c/busses/i2c-omap.c:293: warning: 'omap_i2c_idle' defined but not used
>> ? CC ? ? ?net/ipv4/ip_forward.o
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> how about just moving them into the #ifdef ? /me thinks it's easier to
> read with the function. Matter of taste though, it's not that much code.

Kevin preferred folding into the  runtime functions.

http://www.spinics.net/lists/linux-omap/msg62764.html

Don't feel strongly though.

>
> --
> balbi
