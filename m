From: jdl@jdl.com (Jon Loeliger)
Date: Fri, 25 Oct 2013 10:21:22 -0500
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <526A83B9.30800@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <20131024234340.ADF70C403B6@trevor.secretlab.ca>
 <526A83B9.30800@wwwdotorg.org>
Message-ID: <E1VZjCU-0005RE-Vt@jdl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 10/25/2013 12:43 AM, Grant Likely wrote:
> > On Thu, 24 Oct 2013 22:51:28 +0100, Stephen Warren <swarren@wwwdotorg.org> 
> wrote:
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

DTers,

I think the additional benefit of starting with a direct C
implementation is that it causes us to begin to actually
codify the schema requirements.  Sure, it may not be ideal
at first, but over time it may reveal consistent patterns
that can be extracted.  And it may reveal what a real schema
might look like and how it might be expressed better.  Which
is to say that perhaps we are letting "perfect" get in the
way of "good enough to start"?

In the meantime, someone has shown us the code and we can
get started.  It's a Small Matter of Refactoring later. :-)

Just a notion,
jdl
