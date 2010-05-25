From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Tue, 25 May 2010 19:12:07 +0200
Subject: zImage works, but not vmlinux
In-Reply-To: <4BFC03CF.4070305@gmail.com>
References: <4BFBF015.6000008@gmail.com> <20100525165445.GB3085@boggieman>
	<4BFC03CF.4070305@gmail.com>
Message-ID: <20100525171207.GC3085@boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 01:07:27PM -0400, f. achkar wrote:
> On 05/25/2010 12:54 PM, Kristoffer Ericson wrote:
> > On Tue, May 25, 2010 at 11:43:17AM -0400, f. achkar wrote:
> >   
> >> Hi,
> >> I have tried to send this message some part of it was ignored, resending
> >> sorry ...
> >>
> >> greetings,
> >> I'm newbie to arm linux, so pls if my issue is already addressed just
> >> point me to that reference. I'm trying to learn, but couldn't pass the
> >> following stage:
> >> I have a s3c245 based board, I have a working compressed kernel image
> >> zImage, this image boots properly via u-boot-1.1.6, however I simply
> >> failed to load (i.e., boot vmlinux) via u-boot directly from SDRAM.
> >>
> >> more details:
> >>
> >>    1. I let the target boot until the message of "  Hit any key to stop
> >>       autoboot: " for which I hit enter, (this initialized the board
> >>       enables MMU, I-Cache, .. etc);
> >>    2. board info as seen by u-boot
> >>       # bdinfo
> >>       arch_number = 0x00000648
> >>       env_t       = 0x00000000
> >>       boot_params = 0x30000100
> >>       DRAM bank   = 0x00000000
> >>       -> start    = 0x30000000
> >>       -> size     = 0x04000000
> >>       DRAM bank   = 0x00000001
> >>       -> start    = 0x38000000
> >>       -> size     = 0x04000000
> >>       ethaddr     = ...:5B
> >>       ip_addr     = ...200
> >>       baudrate    = 115200 bps
> >>    3. laod vmlinux to SDRAM :
> >>       tftp 30008000 vmlinux
> >>       TFTP from server ...210; our IP address is ...200
> >>       Filename 'vmlinux'.
> >>       Load address: 0x30008000
> >>       Loading: T ############ .....
> >>    4. # bootm 30008000
> >>       ## Booting image at 30008000 ...
> >>       Boot with Image
> >>       do not support this address : 30008000
> >>
> >>       Starting kernel ...
> >>     
> > Is that kernel compiled with early printk? 
> >   
> the kernel version is 2.6.21-1, and there is no early_printk support yet
> for that version!
> thanks

Then you should add some ascii_printk output so you get more info.
I believe its described on arm wiki.


> >   
> >> and nothing happens it probably crashed somewhere, why zImage works
> >> while vmlinux does not?
> >> thanks,
> >> ferar
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>     
