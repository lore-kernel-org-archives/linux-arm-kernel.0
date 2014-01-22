From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Jan 2014 18:17:24 +0000
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <20140122162313.GE24288@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
 <20140121152358.GD28801@e102568-lin.cambridge.arm.com>
 <20140122115214.GG17314@sirena.org.uk>
 <20140122162313.GE24288@e102568-lin.cambridge.arm.com>
Message-ID: <20140122181724.GR17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 04:23:14PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 22, 2014 at 11:52:14AM +0000, Mark Brown wrote:

> > Actually looking at the OPP binding I do wonder if it might not be
> > better to have a v2/rich binding for them which is extensible - the fact
> > that it's not possible to add additional information seems like an
> > issue, this can't be the only thing anyone might want to add and lining
> > up multiple tables is never fun.

> On one hand OPP bindings need improvement and that's on the cards. I am not
> really following what you mean by "extensible", I only want to make sure
> that the C-state bindings do not become too complex.

By extensible I guess I mostly mean not just a list of numbers we can't
add additional information to without breaking compatibility.  Having to
look through tables and make sure they all use the same indexes gets
error prone and generally miserable.

> Do you mean extending OPP bindings to add eg C-state information there
> (or whatever piece of information that is OPP dependent) ?
> It seems a bit of a stretch but I can think about that.

> I think that C-state properties are better defined in the C-state bindings
> that was the idea but I am open to suggestions.

I think defining in these bindings makes total sense, it's just
providing an extension to the OPP binding (which is already being looked
at anyway).  The exensibility issue I see is that with the current OPP
binding it's inelegant for another binding to add extra information
about an operating point relevant to that binding.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/8bda54c7/attachment.sig>
