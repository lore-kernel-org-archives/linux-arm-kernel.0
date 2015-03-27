From: joe@perches.com (Joe Perches)
Date: Fri, 27 Mar 2015 00:32:43 -0700
Subject: String literals in __init functions
In-Reply-To: <CA+rthh9H4C6b=eGdNmFj3Vb+rHUCPOuaDL1h5i_WXWtNGZYS2A@mail.gmail.com>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
 <CA+rthh9H4C6b=eGdNmFj3Vb+rHUCPOuaDL1h5i_WXWtNGZYS2A@mail.gmail.com>
Message-ID: <1427441563.20980.7.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-03-27 at 08:05 +0100, Mathias Krause wrote:
> On 26 March 2015 at 22:40, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 26 Mar 2015 21:49:06 +0100 Mathias Krause <minipli@googlemail.com> wrote:
> >
> >> Andrew, what's your opinion on such a patch set? Do you too think it's
> >> useful? Or do you share Ingo's fear about the additional maintenance
> >> burden?
> >
> > I don't think the burden would be toooo high, although it will mess the
> > code up a bit.
[]
> > Did anyone ask the gcc developers?  I'd have thought that a function-wide
> >         __attribute__((__string_section__(foo))
> > wouldn't be a ton of work to implement.
> 
> The point is you cannot blindly mark all strings referenced from
> __init / __exit code to end up in a matching string section because
> strings in this code might have to live longer when passed to
> functions keeping a pointer on them.

This is the primary reason I support the pi_<level>/pe_<level>/
printk_init/printk_exit markings.  It's simple and not a large
burden to the coder/reader.  If a few formats aren't marked
appropriately, it's not generally a significant loss, but it
is easily correctable by scripts.
