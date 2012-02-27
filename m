From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Feb 2012 14:59:52 +0000
Subject: [GIT PULL] DaVinci cleanups for v3.4
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317D2DB9@DBDE01.ent.ti.com>
References: <DF0F476B391FA8409C78302C7BA518B6317D2DB9@DBDE01.ent.ti.com>
Message-ID: <201202271459.52216.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 February 2012, Nori, Sekhar wrote:
> Hi Arnd, Olof,
> 
> Can you please pull these DaVinci clean-up patches for
> the v3.4 merge window? I have made sure that these don't
> have any conflicts with the rmk/for-armsoc branch of
> the arm-soc tree.
> 
> These patches need the following two commits from linux-next
> (next-20120224) to keep the VPIF and CQ93VC drivers building.
> 
> 2e932f2  ASoC: CQ93VC: remove machine specific header file inclusion from codec
> db38951  [media] davinci: vpif: remove machine specific header file includes

In general, don't worry too much about conflicts that are easy to
resolve. However, having these extra dependencies is not good,
because it means that we cannot easily build-test the arm-soc
tree by itself and it breaks bisection through the git history.

In the future, please make sure that dependent commits show up
in the right order. For now, I've added the patch below on top
of your series.

	Arnd

commit 6ea96e111e6a7f06ef62227bf64e8cd65bd705b3
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Feb 27 14:55:22 2012 +0000

    ARM: davinci: add back dummy header files
    
    The mach/dm365.h and mach/dm646xh headers are currently being included
    in some device drivers. The removal of those includes is already merged
    in some subsystem trees, but adding the dummy files ensures that this
    branch can be built standalone.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
new file mode 100644
index 0000000..b9bf3d6
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -0,0 +1 @@
+/* empty, remove once unused */
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
new file mode 100644
index 0000000..b9bf3d6
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -0,0 +1 @@
+/* empty, remove once unused */
