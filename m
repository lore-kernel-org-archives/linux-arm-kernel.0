From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 25 Jun 2015 11:35:37 +0200
Subject: [PATCHv5 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <558BB217.5080200@xilinx.com>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
 <1435178205.4528.77.camel@tiscali.nl> <558BA5D4.8060903@xilinx.com>
 <1435217491.16792.5.camel@tiscali.nl> <558BB217.5080200@xilinx.com>
Message-ID: <1435224937.16792.19.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-25 at 09:47 +0200, Michal Simek wrote:
> It has to be platform_device somewhere for sure.
> In past we had folder in arch/microblaze/platform folder.
> Currently you can add this code to for example
> arch/microblaze/kernel/platform.c
> 
> But as I said I don't think it is really important. There will be a 
> lot
> of others drivers in the kernel which can be used as platform drivers
> but you are not able to find out platform_device for it.

Because, like probably happens with this driver, the OF infrastructure
makes sure the .probe and .remove functions will eventually called?

> The important part is that driver can work as is.

Sure.

But I was talking about the MODULE_ALIAS() macro. Trivial as it is,
since I still don't see where a "MODALIAS=platform:xilinx-mailbox"
uevent could come from I still don't see the point of this line. As I
asked in my first message: what breaks if this line is dropped?

> Also it is quite common that users create own BSP for their custom
> boards but they don't push it to mainline.

I can't recall what BSP means. Anyhow, why should we care about boards
not pushed into mainline?


Paul Bolle
