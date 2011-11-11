From: Pawel.Moll@arm.com (Pawel Moll)
Date: Fri, 11 Nov 2011 22:54:21 +0000
Subject: [PATCH 5/5] ARM: vexpress: DT-based support for CoreTiles
 Express A5x2 and A9x4
In-Reply-To: <4EBDA1FB.9040800@gmail.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-6-git-send-email-pawel.moll@arm.com>
 <4EBDA1FB.9040800@gmail.com>
Message-ID: <1321052061.1994.11.camel@rojo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +     dmc at 2a150000 {
> I missed this earlier, but the preferred generic name is
> "memory-controller"
> > +     smc at 2a190000 {
> same here.
>
Ok.

> > +config ARCH_VEXPRESS_V2P_CA5S_CA9
>
> You don't expect this to expand to A7 or A15?

A7/A15's SCUs are CP15 devices, not memory mapped ones. The same with
timers - A9-like TWD is no more, "taken over" by architected timers.
It's a different initialisation and SMP code, essentially. I wish it
wasn't... Also, in future I may be working on adding support for
MMU-less R-Class processors, which are going to be very very
different ;-)

Cheers!

Pawe?

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
