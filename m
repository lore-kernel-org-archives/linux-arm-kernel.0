From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 28 Nov 2014 12:58:36 +1100
Subject: linux-next: manual merge of the kbuild tree with the arm-soc tree
Message-ID: <20141128125836.2736fe99@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Today's linux-next merge of the kbuild tree got a conflict in
scripts/Kbuild.include between commit 9fb5e5372208 ("dts, kbuild:
Factor out dtbs install rules to Makefile.dtbinst") from the arm-soc
tree and commit 371fdc77af44 ("kbuild: collect shorthands into
scripts/Kbuild.include") from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc scripts/Kbuild.include
index 5374b1bdf02f,0f909814edfc..000000000000
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@@ -180,11 -180,17 +180,23 @@@ build := -f $(srctree)/scripts/Makefile
  modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
  
  ###
 +# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 +# Usage:
 +# $(Q)$(MAKE) $(dtbinst)=dir
 +dtbinst := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.dtbinst obj
 +
++###
+ # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.clean obj=
+ # Usage:
+ # $(Q)$(MAKE) $(clean)=dir
+ clean := -f $(srctree)/scripts/Makefile.clean obj
+ 
+ ###
+ # Shorthand for $(Q)$(MAKE) -rR -f scripts/Makefile.headersinst obj=
+ # Usage:
+ # $(Q)$(MAKE) $(hdr-inst)=dir
+ hdr-inst := -rR -f $(srctree)/scripts/Makefile.headersinst obj
+ 
  # Prefix -I with $(srctree) if it is not an absolute path.
  # skip if -I has no parameter
  addtree = $(if $(patsubst -I%,%,$(1)), \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/124d572e/attachment.sig>
