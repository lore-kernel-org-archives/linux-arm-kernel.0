From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 17 Nov 2009 08:17:44 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OF409EDC40.B7ED8C90-ON65257671.001667E7-65257671.001667F5@tcs.com>
References: <20091110064900.GK14091@buzzloop.caiaq.de>
	<20091104131500.GZ14091@buzzloop.caiaq.de>
	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
	<OF409EDC40.B7ED8C90-ON65257671.001667E7-65257671.001667F5@tcs.com>
Message-ID: <20091117071744.GM14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 09:34:44AM +0530, Vadivelan M wrote:
>    As you have suggested we tried on main line kernel also. It is hanging at
>    the same point...
> 
>    Freeing init memory..
>    After this some junk characters.
> 
>    We have measured the baud rate through CRO. It shows 8.6 us (115200) which
>    is correct.

Did you measure the junk characters or the 'working' serial output. The
question is whether the baud rate really changes.

>    Platform dependent changes
>                 Platform : IMX27ads board
>                                 clock changes & memory changes
>
>    will there be any platform dependency with UART driver?
>                 We did not do any modification here. It seems both the lower
>    version kernel and higher version kernel is same.

Please send in patches of your modifications so people here can have a
look to what you did.

>    Already working lower version kernel is not taking the command line
>    arguments [ passed from the CONFIG ]
>                 its taking the boot loader arguments only. so we just did a
>    hack so that it will take our CONFIG command line arguments.
>                 [commented strlcpy() @ arch/arm/kernel/setup.c - fn :
>    parse_tag_cmdline ]
>                 we are getting error : kernel panic - not syncing VFS: unagle
>    to mount roof fs on unknown-block(1,0)

You seem to have omitted the root= parameter. But frankly, I don't
understand why you're doing all that. Why don't let the bootloader pass
the options? The hard-coded config is only a fallback for bootloaders
that don't provide a cmdline tag.

Daniel



>    -----Daniel Mack wrote: -----
> 
>      To: Vadivelan M <vadivelan.m@tcs.com>
>      From: Daniel Mack <daniel@caiaq.de>
>      Date: 11/10/2009 12:19PM
>      cc: linux-arm-kernel at lists.infradead.org, linux-arm at lists.infradead.org
>      Subject: Re: imx27 - hanging at freeing init memory -- getting some junk
>      characters here after on console ..
> 
>  On Fri, Nov 06, 2009 at 11:12:03AM +0530, Vadivelan M wrote:
>  >    I have checked the inittab. the baud rate is correct.
>  >
>  >    When i am passing command line arguments "init=bin/sh
>  >    consloe=ttymxc0,115200 root=/dev/ram rw ip=off"
>  >
>  >    same status. i can see the print Freeing init memory and some uart
>  >    function prints...
>  >
>  >    After that only junk characters are coming.
>  >
>  >    we have checked serial drivers . almost no changes between 2.6.19(working
>  >    kernel) and 2.6.27
>  >
>  >    Please help us to go forward.....
> 
>  Sorry, I don't know then. I was sure you're facing a baud rate issue,
>  which also is a common pitfall.
> 
>  Can you try using a current mainline git kernel and see if the problem
>  persists? Your machine type (MX27ADS) should be supported.
> 
>  Daniel
> 
>  =====-----=====-----=====
>  Notice: The information contained in this e-mail
>  message and/or attachments to it may contain
>  confidential or privileged information. If you are
>  not the intended recipient, any dissemination, use,
>  review, distribution, printing or copying of the
>  information contained in this e-mail message
>  and/or attachments to it are strictly prohibited. If
>  you have received this communication in error,
>  please notify us by reply e-mail or telephone and
>  immediately and permanently delete the message
>  and any attachments. Thank you
