From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 21:28:21 +0000
Subject: [PATCHv2 1/6] ARM: ftrace: remove useless memory checks
In-Reply-To: <20120222141317.GB9031@debian>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-2-git-send-email-rabin@rab.in>
 <20120220161601.GH26840@n2100.arm.linux.org.uk>
 <20120222141317.GB9031@debian>
Message-ID: <20120222212821.GE7041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 07:43:17PM +0530, Rabin Vincent wrote:
> On Mon, Feb 20, 2012 at 04:16:01PM +0000, Russell King - ARM Linux wrote:
> > On Sat, Jan 28, 2012 at 07:05:20PM +0530, Rabin Vincent wrote:
> > > diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> > > index c0062ad..e9488ad 100644
> > > --- a/arch/arm/kernel/ftrace.c
> > > +++ b/arch/arm/kernel/ftrace.c
> > > @@ -125,11 +125,13 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
> > >  {
> > >  	unsigned long replaced;
> > >  
> > > -	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
> > > -		return -EFAULT;
> > > +	if (old) {
> > 
> > So, we're using the instruction value '0' to mean that we don't want to
> > check?  Wouldn'it it be better to pass a flag in to indicate this instead
> > of creating a magic value?
> 
> OK.  I think you applied this patch as-is anyway, so here is a follow-on
> patch:

I'd still much prefer it to be part of the original patch.  I can replace
the patch I've merged or augment it with another patch - whichever way
you prefer.
