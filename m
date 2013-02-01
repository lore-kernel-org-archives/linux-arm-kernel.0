From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 01:17:12 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130131145947.f62474a0600848df86548b96@freescale.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
 <1359541333.3529.186.camel@shinybook.infradead.org>
 <20130130200900.9d7cf7908caeaef4ecee1d61@freescale.com>
 <20130131092801.GV23505@n2100.arm.linux.org.uk>
 <20130131145947.f62474a0600848df86548b96@freescale.com>
Message-ID: <20130201011712.GF23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 02:59:47PM -0600, Kim Phillips wrote:
> On Thu, 31 Jan 2013 09:28:01 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Wed, Jan 30, 2013 at 08:09:00PM -0600, Kim Phillips wrote:
> > > v2:
> > > - at91 and lpd270 builds fixed by limiting to ARMv6 and above
> > >   (i.e., ARM cores that have support for the 'rev' instruction).
> > >   Otherwise, the compiler emits calls to libgcc's __bswapsi2 on
> > >   these ARMv4/v5 builds (and arch ARM doesn't link with libgcc).
> > 
> > Which compiler version?  gcc 4.5.4 doesn't do this, except for the 16-bit
> > swap, so I doubt that any later compiler does.
> 
> I've tried both gcc 4.6.3 [1] and 4.6.4 [2].  If you can point me to
> a 4.5.x, I'll try that, too, but as it stands now, if one moves the
> code added to swab.h below outside of its armv6 protection,
> gcc adds calls to __bswapsi2.

Take a look at the message I sent on the 29th towards the beginning of
this thread for details of gcc 4.5.4 behaviour.
