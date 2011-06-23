From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 Jun 2011 10:25:30 -0400 (EDT)
Subject: [PATCH] USB: ehci: use packed, aligned(4) instead of removing
	the packed attribute
In-Reply-To: <4E030BA6.8060407@ahsoftware.de>
Message-ID: <Pine.LNX.4.44L0.1106231022500.2033-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Jun 2011, Alexander Holler wrote:

> Sorry, I never wanted to talk about the issue itself (I've already said 
> that), I just wanted to bring in some additional clarity for people 
> looking at the code.
> 
> I think if there is a packed,aligned(4) most people reading that are 
> able to imaging how the struct looks like, whereas nothing (without 
> packed) might leave doubts which than requires to read compiler docs or 
> the generated code, if one searches a problem in that area.

I disagree.  If there are no annotations at all (no packed), there
should be no doubts.  The compiler will add padding wherever it is
needed for internal alignment and perhaps also at the end of the
structure.  Nowhere else.

Alan Stern
