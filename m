From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Mar 2012 20:17:52 +0000
Subject: [PATCH 6/6] ARM: mm: truncate memory banks to fit in 4GB space
 for classic MMU
In-Reply-To: <alpine.LFD.2.02.1203061448540.31242@xanadu.home>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
 <1331052846-19144-7-git-send-email-will.deacon@arm.com>
 <4F565230.6030800@ru.mvista.com>
 <20120306175853.GB17518@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1203061448540.31242@xanadu.home>
Message-ID: <20120306201752.GA18151@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Mar 06, 2012 at 07:49:43PM +0000, Nicolas Pitre wrote:
> On Tue, 6 Mar 2012, Will Deacon wrote:
> > On Tue, Mar 06, 2012 at 06:06:40PM +0000, Sergei Shtylyov wrote:
> > > On 03/06/2012 07:54 PM, Will Deacon wrote:
> > > 
> > > > +#ifndef CONFIG_LPAE
> > > > +	if (bank->start + size<  bank->start) {
> > > > +		printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
> > > > +			"32-bit physical address space\n", (long long)start);
> > > > +		size = ULONG_MAX - bank->start;
> > > 
> > >     I think you forgot to add one here.
> > 
> > No, I deliberately omit the last page because otherwise we end up with the
> > end address of the bank being calculated as 0, which leads to boot failure.
> 
> What this mentioned in the code, or at least in the patch log?

Good idea - I'll add a comment to the code when we assign size.

Will
