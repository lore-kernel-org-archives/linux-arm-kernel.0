From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 11:58:20 +0100
Subject: [PATCHv3 2/5] ARM: mvebu: disable I/O coherency on non-SMP
 situations on Armada 370/375/38x/XP
In-Reply-To: <1582668.V5SXEARn2a@wuerfel>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <5650402.1KVMxKcjQn@wuerfel>
 <20141113111730.705f9ca1@free-electrons.com>
 <1582668.V5SXEARn2a@wuerfel>
Message-ID: <20141113115820.4a866523@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 13 Nov 2014 11:53:19 +0100, Arnd Bergmann wrote:

> > What do you think?
> 
> IIRC there is still an unsolved problem on mach-keystone that is somewhat
> related, they also have to change the page tables and the current method
> appears to be racy. Once that is solved, you might be able to do 2.

So maybe we need to invest time on this. I'll see how critical it is
for us to have HW I/O coherency working on non-SMP configurations, and
therefore if we can spend some time to work on this topic.

> The approach I had in mind was much simpler, introducing a compile-time
> option that hardcodes the behavior you need for Armada-370 when set,
> knowing that you should not set that on any kernel that is supposed to
> run on other platforms.

Yes, I understood it was a compile-time option.

Actually, switching to the write-allocate cache policy, and on SoCs
that support it, to shareable pages, will continue to work on other
platforms. So it does not break them, even though it might maybe cause
some performance penalties (even though I'm not even sure that it would
be the case). So it's not completely incompatible with doing a
multi-platform kernel.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
