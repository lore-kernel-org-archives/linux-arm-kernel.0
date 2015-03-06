From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 6 Mar 2015 10:34:29 +0000
Subject: Intermittent efi libstub build errors on arm64
Message-ID: <20150306103428.GA8045@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I've run into some strange build errors with 3.19.

If I set a high number of parallel jobs, I sometimes get build errors
such as:

mv: cannot stat ?drivers/firmware/efi/libstub/.fdt.o.tmp?: No such file or directory
  AR      drivers/firmware/efi/libstub/lib.a
scripts/Makefile.build:257: recipe for target 'drivers/firmware/efi/libstub/fdt.o' failed
make[1]: *** [drivers/firmware/efi/libstub/fdt.o] Error 1
Makefile:939: recipe for target 'drivers/firmware/efi/libstub' failed
make: *** [drivers/firmware/efi/libstub] Error 2

and,

fixdep: error opening depfile: drivers/firmware/efi/libstub/.efi-stub-helper.o.d: No such file or directory
scripts/Makefile.build:257: recipe for target 'drivers/firmware/efi/libstub/efi-stub-helper.o' failed
make[1]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 2
Makefile:939: recipe for target 'drivers/firmware/efi/libstub' failed
make: *** [drivers/firmware/efi/libstub] Error 2
make: *** Waiting for unfinished jobs....


I think some dependency information/header includes may need tweaking
somewhere. Has anyone else come across this, or know more?

Cheers,
-- 
Steve
