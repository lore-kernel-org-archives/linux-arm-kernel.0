From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 07:48:18 +0200 (CEST)
Subject: [PATCH] arch/arm/mach-pxa/stargate2.c: use ARRAY_AND_SIZE
 consistently
In-Reply-To: <20130810223338.GM5502@mwanda>
References: <1376148353-9699-1-git-send-email-Julia.Lawall@lip6.fr>
 <20130810223338.GM5502@mwanda>
Message-ID: <alpine.DEB.2.02.1308110745030.2072@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Aug 2013, Dan Carpenter wrote:

> ARRAY_AND_SIZE() macro is horrible, and I would like it if it were
> removed.  What I meant before was just that probably people will
> probably complain if we try to remove it.

Well, I could either wait for someone to defend it, or send a patch 
getting rid of it and see what happens...  I can't see what could go wrong 
with

f(...,
- ARRAY_AND_SIZE(e)
+ e, ARRAY_SIZE(e)
  , ...)

so it should be an easy patch to create.

julia
