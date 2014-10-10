From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Oct 2014 17:18:35 +0100
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141009214706.GC4606@drone.musicnaut.iki.fi>
References: <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com> <20141008171322.GH22688@saruman>
 <20141008175707.GI22688@saruman> <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org> <20141009162656.GE16002@saruman>
 <20141009204101.GA25955@debian>
 <20141009214706.GC4606@drone.musicnaut.iki.fi>
Message-ID: <20141010161835.GK12379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 12:47:06AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, Oct 09, 2014 at 10:41:01PM +0200, Rabin Vincent wrote:
> >   What GCC version are you using?
> >   
> >   4.8.1 and 4.8.2 are known to miscompile the ARM kernel and these
> >   find_get_entry() crashes with 0xffffffff involved smell a lot like the
> >   earlier reports from kernels build with those compilers:
> >   
> >   https://lkml.org/lkml/2014/6/25/456
> >   https://lkml.org/lkml/2014/6/30/375
> >   https://lkml.org/lkml/2014/6/30/660
> >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
> >   https://lkml.org/lkml/2014/5/9/330
> 
> Is it possible to blacklist those GCC versions on ARM somehow as it
> seems people are still using them?
> 
> This bug also ruined a file system on one of my boxes last year
> (see e.g. http://marc.info/?l=linux-arm-kernel&m=139033442527244&w=2).

Given that, why the fsck (pun intended) did you not shout a little louder
about getting it blacklisted.  Looking at your marc.info URL, there's
very little information there which hints at filesystem corruption, and
it's a thread of only *one* message according to marc.info.

Even _if_ I did read the message you point to above, that on its own did
not hint at filesystem corruption.

So, would you please mind passing on further details about this,
specifically which function in the ext4 code is affected, so it can
be properly written up.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
