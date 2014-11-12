From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 12 Nov 2014 15:07:56 +0000
Subject: [PATCH] arm64: topology: Fix handling of multi-level cluster
 MPIDR-based detection
In-Reply-To: <20141008205628.GO4609@sirena.org.uk>
References: <1408462379-27968-1-git-send-email-broonie@kernel.org>
 <CAFpQJXWkL_ge8XT9y6vSNwgQgXcvQtUh4PaWxdH1dK0QhFWu2A@mail.gmail.com>
 <20141003163715.GB13939@e102568-lin.cambridge.arm.com>
 <20141008205628.GO4609@sirena.org.uk>
Message-ID: <20141112150756.GA30300@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 09:56:28PM +0100, Mark Brown wrote:
> On Fri, Oct 03, 2014 at 05:37:16PM +0100, Lorenzo Pieralisi wrote:
> 
> > To be honest with you all I would have preferred to sort this out with
> > DT, that's already doable now without this patch.
> 
> We'd still have to make sure there's a complete topology binding for
> ACPI and get through standardisation if any changes are needed.  I guess
> it's probably mostly OK as the scenarios should all be shared with x86
> systems but I've not looked to see if some of the subsetting that's
> being done for ACPI on ARMv8 causes issues.
> 
> > Having said that, for platforms setting MPIDR_EL1 to reasonable values,
> > I think that's what we should do, squash the upper MPIDR levels (for
> > the non SMT case too). Please stick a proper comment for that to the code.
> > We can always rely on DT to fix other cases that can't be treated
> > properly with code above.
> 
> OK, I'll send a patch.

Mark,

do you have time to send it ?

Please let me know.

Thanks,
Lorenzo
