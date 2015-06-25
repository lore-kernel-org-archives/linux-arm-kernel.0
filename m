From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 25 Jun 2015 08:55:16 +0200
Subject: [PATCHv5 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1435178205.4528.77.camel@tiscali.nl>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
 <1435178205.4528.77.camel@tiscali.nl>
Message-ID: <558BA5D4.8060903@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2015 10:36 PM, Paul Bolle wrote:
> On Tue, 2015-06-23 at 11:00 -0700, Moritz Fischer wrote:
>> +MODULE_ALIAS("platform:xilinx-mailbox");
> 
> So I think this MODULE_ALIAS() is only useful if, in short, there's a
> corresponding platform_device created. Ie, a platform_device with a
> name "xilinx-mailbox" that will fire of a "MODALIAS=platform:xilinx
> -mailbox" when it's created.
> 
> I couldn't spot such a platform_device. Provided git grep didn't let me
> down here: what breaks if this line is dropped?

IRC you don't need to have this platform_device in the kernel present.
Only one thing which should be check is that this driver can be used as
platform device driver.

The only one problematic part is devm_clk_get() and this should be
checked if you can use this as platform driver. From the first look it
looks like that this will break it.

Anyway if Moritz is able to use this a platform driver he can keep this
line there. If not, it should be removed.

Thanks,
Michal
