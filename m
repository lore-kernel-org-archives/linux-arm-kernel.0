From: phil.carmody@partner.samsung.com (Phil Carmody)
Date: Thu, 20 Jun 2013 12:24:47 +0300
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <20130619192211.GH1403@sirena.org.uk>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk> <3697657.tZFV7pR81Q@flatron>
 <20130619192211.GH1403@sirena.org.uk>
Message-ID: <001201ce6d98$03d9b920$0b8d2b60$%carmody@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Apologies if this is mangled, fighting both Outlook and remote desktop :-(
)

linux-kernel-owner at vger.kernel.org wrote on Behalf Of Mark Brown
> On Wed, Jun 19, 2013 at 08:26:12PM +0200, Tomasz Figa wrote:
> > On Wednesday 19 of June 2013 18:40:47 Mark Brown wrote:
> 
> > > -		ret = pd->get_signal(plchan->cd);
> > > +		ret = (pd->get_signal)(plchan->cd);
> 
> > Hmm, that's strange. The former is a completely valid piece of
> code...
> 
> I know, hence...
> 
> > > to get it to build which makes me suspect the compiler a bit as
> well...
> 
> ...my comment about suspecting the compiler.

Can you just make that minimal change, and diff the objdump of the two .o's?
It would be worth a bug-report against the toolchain if different code was
being generated. If objdump spews huge numbers of diffs (due to one address
changing and pushing everything else out of kilter), then feel free to
forward both .o's or both objdumps to me, and I can run a script over them,
which knows to ignore unimportant address changes. 

Praying that this mail is readable to you, as it's not readable as I write
it,
Phil
