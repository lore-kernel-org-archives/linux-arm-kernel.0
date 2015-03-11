From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 11 Mar 2015 17:56:22 +0100
Subject: [PATCH 0/15] don't export static symbol
Message-ID: <1426092997-30605-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches remove EXPORT_SYMBOL or EXPORT_SYMBOL_GPL declarations on
static functions.

This was done using the following semantic patch:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
type T;
identifier f;
@@

static T f (...) { ... }

@@
identifier r.f;
declarer name EXPORT_SYMBOL;
@@

-EXPORT_SYMBOL(f);

@@
identifier r.f;
declarer name EXPORT_SYMBOL_GPL;
@@

-EXPORT_SYMBOL_GPL(f);
// </smpl>
