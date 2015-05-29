From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 12:09:41 -0700
Subject: [PATCH 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <55679085.6040402@wwwdotorg.org>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-3-git-send-email-eric@anholt.net>
 <55679085.6040402@wwwdotorg.org>
Message-ID: <87mw0ncia2.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 05/18/2015 01:43 PM, Eric Anholt wrote:
>> +	init.flags = CLK_IS_ROOT;
>
> Is it possible to add clock parent information to the driver, so the
> clocks are all hooked together into the correct tree, rather than all
> looking like root clocks?
>
> One of the many reasons I didn't do anything FW-wise for the kernel was
> the hope that such information would be forthcoming, and hence we could
> have complete kernel drivers.

As far as I can tell, none of these clocks are the parent of any other.

There's a layer of PLLs, then clockman almost always just dividing off
of those.  In response to a clockman request (which is what this
property tag quickly maps to), only PLLH ever gets changed as a result
of RPI_CLOCK_PIXEL.  PLLH feeds the HDMI and VEC (SDTV).  We don't have
an SDTV clock for us to control through these interfaces, so there are
no conflicts that I can see.  Only two clockman clocks I see divide off
of on other clockman clocks, and we don't have access to those.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/4f7dc2b5/attachment.sig>
