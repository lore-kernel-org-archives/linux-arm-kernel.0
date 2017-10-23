From: james.morse@arm.com (James Morse)
Date: Mon, 23 Oct 2017 10:33:03 +0100
Subject: kdump: need help with kexec -p
In-Reply-To: <HE1PR04MB12413AEF2BF54623027FD22A97460@HE1PR04MB1241.eurprd04.prod.outlook.com>
References: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59DF54B3.1050404@arm.com>
 <HE1PR04MB124165F8510E983992B11EC797480@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59E095E1.5090706@arm.com>
 <HE1PR04MB12415392027297293D5FC07E97480@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <HE1PR04MB12413AEF2BF54623027FD22A97460@HE1PR04MB1241.eurprd04.prod.outlook.com>
Message-ID: <59EDB74F.4070302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar, Akashi,

On 23/10/17 06:37, Prabhakar Kushwaha wrote:
> After further analysis, it is figured out to be a data cache flush issue.   
> 
> After trying below patch(suggested by Takahiro). This problem looks to be resolved for now. 
> 
> ===
> commit 9b492cf58077
> Author: Xunlei Pang <xlpang@redhat.com>
> Date:   Mon May 23 16:24:10 2016 -0700
> 
>     kexec: introduce a protection mechanism for the crashkernel reserved memory
> ===

/me winces.

Yes, without the protection mechanism the code will still compile, and still
work, but be missing the kexec_segment_flush() calls.

This is the problem with backporting stuff. Glad you got it fixed!


Thanks,

James
