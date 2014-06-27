From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 17:31:08 +0100
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
References: <C4A61A5CA4AD2246942F4BA6F20ACB804356534D@ALVA-EXMB04.alv.autoliv.int>
 <20140626140115.GQ32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>
 <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
Message-ID: <20140627163108.GP32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fredrik,

On Fri, Jun 27, 2014 at 04:16:57PM +0000, Fredrik Noring wrote:
> Please find below a trace that appeared once with 3.16-rc2. Perhaps it is of
> some interest?

It's not that serious... I know that the FEC ethernet driver is
horrendously racy (I have had a patch set for about the last six months
which fixes some of its problems) but as I've had a lot of patches to
deal with, and it's been pushed to the back of the queue...

The races don't lead to data corruption though, merely timeouts and
some lost packets.

Now because things have changed during the last merge window, I've got
an even bigger problem sorting through that patch set and getting it
back into a submittable state.  I've just sent out v2 for it onto the
netdev at vger.kernel.org mailing list.

The initial version (marked RFC) attracted very little interest from
testers, or acks.  I'd very much like to have some testing of it, so
if you want to try it out, I can provide you with a git URL, patches
or a combined patch.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
