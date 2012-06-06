From: cjb@laptop.org (Chris Ball)
Date: Wed, 06 Jun 2012 09:45:04 -0400
Subject: [PATCH] mmc: omap: Fix a section warning regression
In-Reply-To: <20120528082217.GI18918@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Mon, 28 May 2012 11:22:18 +0300")
References: <20120528065347.GR17852@atomide.com>
 <20120528082217.GI18918@arwen.pp.htv.fi>
Message-ID: <87ehps4krj.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 28 2012, Felipe Balbi wrote:
> On Sun, May 27, 2012 at 11:53:47PM -0700, Tony Lindgren wrote:
>> Commit b6e0703b (mmc: omap: make it behave well as a module) made some
>> __devinit changes but missed one function causing a section warning:
>> 
>> WARNING: vmlinux.o(.devinit.text+0x8604): Section mismatch in reference
>> from the function mmc_omap_probe)
>> The function __devinit mmc_omap_probe() references a function
>> __init mmc_omap_new_slot()
>> 
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
