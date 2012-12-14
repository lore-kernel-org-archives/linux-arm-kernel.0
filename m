From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 14 Dec 2012 12:43:10 +0200
Subject: [PATCH] clk: debug clock tree
In-Reply-To: <50CA17FB.9060606@wwwdotorg.org>
References: <1355370586-6600-1-git-send-email-pgaikwad@nvidia.com>
 <CAPtuhThBigSQMkNDf16Fo1tddTKo=rPEydHmzep0DqtgLrB+HA@mail.gmail.com>
 <50CA17FB.9060606@wwwdotorg.org>
Message-ID: <20121214104310.GW19258@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 07:01:31PM +0100, Stephen Warren wrote:
> On 12/13/2012 09:27 AM, Mike Turquette wrote:
> > On Wed, Dec 12, 2012 at 7:49 PM, Prashant Gaikwad <pgaikwad@nvidia.com> wrote:
> >> Adds debug file "clock_tree" in /sys/kernel/debug/clk dir.
> >> It helps to view all the clock registered in tree format.
> >>
> > 
> > Prashant,
> > 
> > Thanks for submitting this.  We've been talking about having a single
> > file for representing the tree for some time.
> > 
> > Regarding the output format had you considered using a well known
> > format which can be parsed using well known parsing libs?  This avoids
> > needing a custom parser just for this one file.  JSON springs to mind
> > as something lightweight and well-understood.
> 
> One advantage of the format below is that it's very easily
> human-readable, and it's not too hard to parse (although I guess you'd
> have to parse the indent level to get parent/child relation, which would
> suck a bit). Is there room to provide both? Otherwise, I guess the
> kernel could include a script to convert from JSON/whatever into the
> format below.

We already have the clk directory for an easy to parse version. So I think
this one should be focused on being human readable.

Cheers,

Peter.
