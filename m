From: david@gibson.dropbear.id.au (David Gibson)
Date: Mon, 28 Oct 2013 21:17:37 +1100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <526A83B9.30800@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <20131024234340.ADF70C403B6@trevor.secretlab.ca>
 <526A83B9.30800@wwwdotorg.org>
Message-ID: <20131028101737.GC15114@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 25, 2013 at 03:44:09PM +0100, Stephen Warren wrote:
> On 10/25/2013 12:43 AM, Grant Likely wrote:
> > On Thu, 24 Oct 2013 22:51:28 +0100, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >>
> >> This is a very quick proof-of-concept re: how a DT schema checker might
> >> look if written in C, and integrated into dtc.
> > 
> > Thanks for looking at this.
> > 
> > Very interesting. Certainly an expedient way to start checking schemas,
> > and for certain bindings it may be the best approach. The downside is it
> > forces a recompilation of DTC to bring in new bindings and it isn't a
> > great meduim for mixing schema with documentation in the bindings.
> 
> This approach would certainly require recompiling something. I threw the
> code into dtc simply because it was the easiest container for the
> demonstration. It could be a separate DT validation utility if we
> wanted, although we'd need to split the DT parser from dtc into a
> library to avoid code duplication. The resultant utility could be part
> of the repo containing the DTs, so it didn't end up as a separate
> package to manage.
> 
> I think the additional documentation could be added as comments in the
> validation functions, just like IIRC it was to be represented as
> comments even in the .dts-based schema proposals.

Fwiw, I've been starting to do some hacking on the checks code, with a
view to making it accomodate the schema stuff better.  Branch
'checking' on the kernel.org tree.  In a state of flux, so expect
rebases.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131028/480ff28f/attachment-0001.sig>
