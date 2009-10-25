From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 25 Oct 2009 04:40:32 +0200
Subject: Please advise on modifying defconfig for Amstrad Delta
Message-ID: <200910250340.34046.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm just working on a new, updated version of ams_delta_defconfig. Starting from the current version, created over 2 years ago for 2.6.22, I turned on a few device drivers that was added recently, turned on thumb instructions support, turned on EABI, kept old ABI compatibility and NWFPE, and got a resulting kernel that is ~170kB too large to be successfully booted using tools available at http://the.earth.li/pub/e3/.

Of course, I am able to trim that down, even adding a few more drivers for add-on hardware that I am using, and get a kernel that works perfectly for me, but since I have never prepared a default config, I'd like to get your advice on what I can remove and what should rather be kept untouched.

Instead of pasting sixteen hundred lines here, I'd rather ask about the simplest change I can see:

-# CONFIG_EMBEDDED is not set
-CONFIG_KALLSYMS=y
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set

That would give me a kernel that is small enough, but since only a few of arm defconfigs have CONFIG_KALLSYMS not set, I am not sure if it is generally acceptable.

Thanks,
Janusz
