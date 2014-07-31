From: balbi@ti.com (Felipe Balbi)
Date: Thu, 31 Jul 2014 18:04:14 -0500
Subject: Bad Page dump (help)
In-Reply-To: <20140731153027.GG19512@saruman.home>
References: <20140729190700.GN17808@saruman.home>
 <20140729195547.GE30282@n2100.arm.linux.org.uk>
 <20140729201750.GO17808@saruman.home>
 <20140731145354.GM30282@n2100.arm.linux.org.uk>
 <20140731153027.GG19512@saruman.home>
Message-ID: <20140731230414.GA8920@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 31, 2014 at 10:30:27AM -0500, Felipe Balbi wrote:

<snip>

> > I'm suspecting that you either have badly a routed data bus connection
> > on bits 23:16, or you have a bad RAM chip which corrupts those bits.
> > 
> > It may be worth trying a simple assembly-level RAM test which pokes
> > all locations with alternating 0xffffffff, 0x00000000 and verifies
> > them.  By that I mean odd word addresses set to one value, even set
> > to the other, verify, reverse them, try again.
> > 
> > Alternatively, if there's a proper ARM memory checker around, I think
> > it would be well worth running it on this board to check the integrity
> > of the hardware.
> 
> I'll try u-boot's memtester and see what results it yields.

alright, stock u-boot's memtest didn't help much, so I modified it a bit
and started seen issues when I was testing only the first 4MiB of RAM.
Here's one small snippet of the output:

RET    ADDR            WR          RD

FAIL @ 80000010 exp fffffffd got ffeafffd
FAIL @ 80001c30 exp fffffe3b got fffbfe3b
FAIL @ 80000630 exp ffffff9b got fffbff9b
FAIL @ 80000430 exp ffffffbb got ff5bffbb

So what I just did is that I changed u-boot so it was test 768MiB and
I'll leave this running for the next 4 days or so, then I'll report
here. In any case, thanks for pointing me in the right direction.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/d598b84e/attachment.sig>
