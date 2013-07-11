From: sr@denx.de (Stefan Roese)
Date: Thu, 11 Jul 2013 14:33:23 +0200
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DE9E62.9080406@ti.com>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
 <51DE8CBB.4000709@denx.de> <51DE9E62.9080406@ti.com>
Message-ID: <51DEA613.3010209@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 02:00 PM, Roger Quadros wrote:
>>> Could it be possible that the boot scripts on your filesystem are
>>> somehow shutting down
>>> the ethernet interface? Might be worth checking on a fresh filesystem.
>>
>> I'm pretty sure that its not a problem with the filesystem. I'm using
>> exactly this filesystem for multiple other ARM based boards as well.
>> And all other boards (most of them with buildin ethernet controller
>> instead of USB connected) have no problem mounting/booting from it.
> 
> OK, then it might be something to do with beagle.
> Is pandaboard working fine for you?

I don't have a pandaboard here. Sorry. Only a another OMAP3530-based
board which also fails to boot via NFS.

>> BTW: The filesystem is from the ELDK 5.3 [1][2]. You could download/install
>> it yourself.
> 
> OK. Will give it a try.
>>
>> From your log I can see, that you are using a slightly different board
>> than I am ("Beagle xM Rev C" vs. "Beagle Rev C1/C2/C3"). So its a
> 
> My board is a C2.

Mine too.

>> different OMAP variant. Could this perhaps make a difference? Do you
>> by chance have the "old" Beagleboard (non-xM) at hand for another test?
> 
> Sure. I have the old beagleboard with me. Let me know what to test.

Either your debian rootfs via NFS or the ELDK one. As you have done with
the Beagle-xM. And then please repeat the NFS booting (if successful)
again for at least 5 times. Or even better, setup the bootcmd to
autoboot via NFS and tune your NFS rootfs to reboot automatically. So a
hangup in NFS booting would be noticed after some time with this board
automatically rebooting.

Thanks,
Stefan
