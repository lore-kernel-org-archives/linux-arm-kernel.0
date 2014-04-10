From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Thu, 10 Apr 2014 23:15:07 +0100 (BST)
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410220650.GA10540@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com> <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140410220650.GA10540@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1404102313060.25712@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Thu, 10 Apr 2014, Jason Gunthorpe wrote:

>> I took your attached patch and extended it a bit to print out how
>> long it took. The delays also need to be much longer for me. I also
>> fixed a small typo you made where the bit wasn't being set again to
>> bring the link back up. I've attached the diff to your patch, as
>> well as the combined patch (hope that makes sense).
>
> Just to be clear you tried this alone without the above?

Yes I did.

>
> Thanks for fixing the patch, I think it also confirms the theory.
>

No problem!

> IMHO, both approaches are required.
>
> The first prevents messing up the PEX as was left by the bootloader
>
> The second allows the driver to startup a PEX that wasn't enabled by
> the bootloader, and recover from clock gating in the kernel (eg the
> modular case)
>
> Both seem valuable..
>
> Ideally I'd like to see the clk driver turn off the PEX PHY when it
> gates the clock, but I have no great idea how to accomplish that sort
> of cross register space adventure...
>
> Thomas, if we can figure out how to properly do __clk_is_enabled I
> can probably send a proper patch?

Let me know when you do and I will test it and add my Tested-by.

>
> Thanks,
> Jason
>

Cheers,
Neil
