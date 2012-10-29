From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Oct 2012 22:00:32 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
Message-ID: <20121029200032.GD30152@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 26, 2012 at 10:03:11PM +0000, Paul Walmsley wrote:
> Hi Felipe,
> 
> On Fri, 26 Oct 2012, Felipe Balbi wrote:
> 
> > On Thu, Oct 25, 2012 at 01:12:12PM +0300, Felipe Balbi wrote:
> > > On Tue, Oct 23, 2012 at 09:23:03PM +0200, Jean Pihet wrote:
> > > > On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > > > > On Mon, 22 Oct 2012, Jean Pihet wrote:
> > > > >
> > > > >> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> > > > >>
> > > > >> > Do you have CPU_IDLE enabled?
> > > > >> FYI the issue is not present with CPU_IDLE enabled.
> > > > >
> > > > > Hmm, how can you tell?  I thought you weren't able to reproduce it with
> > > > > CPU_IDLE disabled either?
> > > > I could not reproduce the issue, with and without CPU_IDLE enabled.
> > > > What puzzles me is that the PM QoS code only has influence on the
> > > > states chosen by cpuidle, so the change should not have any impact
> > > > with CPU_IDLE enabled. I reallt need to reproduce the issue.
> > > > Let me try with the same setup as yours (bootloader images,
> > > > omap2pus_defconfig, angstrom roots).
> > > 
> > > I just sent a patch to fix a bug I found on OMAP4 panda but while
> > > reading this thread again, I think it could be that it's the same bug
> > > which is just easier to reproduce on Paul's setup.
> > > 
> > > Paul, Aaro, can you see if [1] makes the problem go away ? that would be
> > > another reason to push [1] during this -rc cycle.
> > > 
> > > [1] http://marc.info/?l=linux-omap&m=135115602407925&w=2
> 
> Thanks for mentioning it, but this patch doesn't fix the I2C timeout 
> problem here.  Log fragment below from the 3530ES3 Beagle.

that's too bad :-(

Can you compile with:

CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=9

so that I can see all transfers ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/c02377b7/attachment-0001.sig>
