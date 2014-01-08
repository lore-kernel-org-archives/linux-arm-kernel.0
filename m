From: msalter@redhat.com (Mark Salter)
Date: Wed, 08 Jan 2014 11:09:48 -0500
Subject: [PATCH v2 1/5] mm: create generic early_ioremap() support
In-Reply-To: <52CC89B4.4060300@zytor.com>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-2-git-send-email-msalter@redhat.com>
 <52CC89B4.4060300@zytor.com>
Message-ID: <1389197388.29144.37.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-01-07 at 15:11 -0800, H. Peter Anvin wrote:
> On 01/06/2014 06:35 PM, Mark Salter wrote:
> > 
> > There is one difference from the existing x86 implementation which
> > should be noted. The generic early_memremap() function does not return
> > an __iomem pointer and a new early_memunmap() function has been added
> > to act as a wrapper for early_iounmap() but with a non __iomem pointer
> > passed in. This is in line with the first patch of this series:
> > 
> 
> This makes a lot of sense.  However, I would suggest that we preface the
> patch series with a single patch changing the signature for the existing
> x86 function, that way this change becomes bisectable.

Ok, that sounds like a good idea. I'm uncertain how best to coordinate
with Dave Young's patch series to avoid conflicts. His first patch does
the signature change (and adds the early_memunmap function but that
isn't used anywhere):

 https://lkml.org/lkml/2013/12/20/143

Any thoughts on how best to avoid potential merge conflicts here?
