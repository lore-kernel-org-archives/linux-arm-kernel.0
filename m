From: joe@perches.com (Joe Perches)
Date: Thu, 26 Mar 2015 14:58:40 -0700
Subject: String literals in __init functions
In-Reply-To: <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
Message-ID: <1427407120.15849.34.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding gcc at gcc.gnu.org)

On Thu, 2015-03-26 at 14:40 -0700, Andrew Morton wrote:
> On Thu, 26 Mar 2015 21:49:06 +0100 Mathias Krause <minipli@googlemail.com> wrote:
> 
> > Andrew, what's your opinion on such a patch set? Do you too think it's
> > useful? Or do you share Ingo's fear about the additional maintenance
> > burden?
> 
> I don't think the burden would be toooo high, although it will mess the
> code up a bit.

I think it's overall a pretty low cost one-time pass
that Mathias has nearly completely automated.

Even if a future version of gcc implements string
constants in specific sections, the code isn't
difficult to understand or maintain for older versions.

> The post-build checking for section reference mismatches will help,
> although that seems to have got itself turned off (what happened
> there?).

I think the modprobe message works well.
What do you think missing?

> Did anyone ask the gcc developers?

Not to my knowledge.

> I'd have thought that a function-wide
> 	__attribute__((__string_section__(foo))
> wouldn't be a ton of work to implement.

Maybe not.

Could some future version of gcc move string constants
in a function to a specific section marked in a manner
similar to what Andrew described above?
