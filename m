From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 3 Mar 2017 17:59:06 +0100
Subject: No output on console despite ignore_loglevel earlyprintk
In-Reply-To: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
Message-ID: <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 03.03.2017 um 17:42 schrieb Marc Gonzalez:
> I'm confused about early consoles and earlyprintk, and all that good stuff.
> When my kernel panics, I don't get the expected output.
> 
> Using "mem=256M ignore_loglevel earlyprintk"
[...]
> [    0.014325] Console: colour dummy device 80x30
> [    0.018885] console [tty0] enabled
> [    0.022396] bootconsole [earlycon0] disabled
> 
> And it hangs there.
> 
> 
> If I use an explicit console= configuration, I do see the panic.
> Using "mem=256M ignore_loglevel console=ttyS0,115200 earlyprintk"
[...]
> [    0.014325] Console: colour dummy device 80x30
> [    0.018899] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.25 BogoMIPS (lpj=90000)
[...]

I have reported a similar phenomenon for multiple new SoCs.

> I suppose this is related to my DT description?
> 
> 	chosen {
> 		stdout-path = "serial:115200n8";
> 	};
> 
> Isn't stdout-path = "serial:115200n8" supposed to be equivalent to
> console=ttyS0,115200 ?

First of all, that should probably be serial0, and it needs to be
defined as an alias. In my case that's a given.

And yes, AFAIU stdout-path = "serialX:115200n8" should lead to
ttyFOOX,115200n8 being used, in your case it may be ttyS0.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
