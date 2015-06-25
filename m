From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 25 Jun 2015 13:12:38 +0200
Subject: [PATCHv5 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1435224937.16792.19.camel@tiscali.nl>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
 <1435178205.4528.77.camel@tiscali.nl> <558BA5D4.8060903@xilinx.com>
 <1435217491.16792.5.camel@tiscali.nl> <558BB217.5080200@xilinx.com>
 <1435224937.16792.19.camel@tiscali.nl>
Message-ID: <558BE226.2060907@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2015 11:35 AM, Paul Bolle wrote:
> On Thu, 2015-06-25 at 09:47 +0200, Michal Simek wrote:
>> It has to be platform_device somewhere for sure.
>> In past we had folder in arch/microblaze/platform folder.
>> Currently you can add this code to for example
>> arch/microblaze/kernel/platform.c
>>
>> But as I said I don't think it is really important. There will be a 
>> lot
>> of others drivers in the kernel which can be used as platform drivers
>> but you are not able to find out platform_device for it.
> 
> Because, like probably happens with this driver, the OF infrastructure
> makes sure the .probe and .remove functions will eventually called?
> 
>> The important part is that driver can work as is.
> 
> Sure.
> 
> But I was talking about the MODULE_ALIAS() macro. Trivial as it is,
> since I still don't see where a "MODALIAS=platform:xilinx-mailbox"
> uevent could come from I still don't see the point of this line. As I
> asked in my first message: what breaks if this line is dropped?

TBH probably nothing because all will just use OF because it is just
common for a long time on all xilinx platforms.

> 
>> Also it is quite common that users create own BSP for their custom
>> boards but they don't push it to mainline.
> 
> I can't recall what BSP means. Anyhow, why should we care about boards
> not pushed into mainline?

I am not the right person to answer this in general. For SoC tree I
maintain I tend to accept these patches if they are useful and
definitely don't want to have support for various platforms. But having
shared drivers is fine.

For this case if Moritz tested OF and platform device probes and both
work I am fine to keep it there. If only OF part is tested then I would
remove this line.

Thanks,
Michal
