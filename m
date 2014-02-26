From: msalter@redhat.com (Mark Salter)
Date: Wed, 26 Feb 2014 09:59:20 -0500
Subject: [PATCH v4 4/6] arm: add early_ioremap support
In-Reply-To: <CAL_JsqLi=GhGy7dNf2BiAGd4EtzfqqYfbo0YhRhyhuwEp0w8HQ@mail.gmail.com>
References: <1392238575-10000-1-git-send-email-msalter@redhat.com>
 <1392238575-10000-5-git-send-email-msalter@redhat.com>
 <CAL_JsqLi=GhGy7dNf2BiAGd4EtzfqqYfbo0YhRhyhuwEp0w8HQ@mail.gmail.com>
Message-ID: <1393426760.26583.43.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-25 at 23:48 -0600, Rob Herring wrote:
> > +#define NR_FIX_BTMAPS          32
> > +#define FIX_BTMAPS_SLOTS       7
> > +#define TOTAL_FIX_BTMAPS       (NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> > +#define FIX_BTMAP_END          FIX_KMAP_BEGIN
> > +#define FIX_BTMAP_BEGIN                (FIX_BTMAP_END +
> TOTAL_FIX_BTMAPS - 1)
> 
> Why the different logic from arm64? Specifically, it doesn't make
> adding a permanent mapping simple.

I looked at adding support for permanent mappings but it was going to
take more time than I had. Also on ARM, we have to deal with kmap's
needs as well. Working that out was going to take more time than I
had. I think getting the patch in now to support early_ioremap is
the way to go. Adding support for permanent mappings can be done
later with the early console support for which it is needed.
