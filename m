From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Oct 2017 21:53:46 +0200
Subject: Stack protector kernel build error
Message-ID: <87tvz1y08l.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kees,

Today my linux-next build broke for the pxa architecture.
My specific setup is :
 - ARCH=arm make pxa_defconfig; ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make
 - my compiler is:
	rj at belgarion:~/mio_linux/kernel$ arm-linux-gnueabi-gcc --version
	arm-linux-gnueabi-gcc (Debian 6.3.0-18) 6.3.0 20170516

And the error message is :
rj at belgarion:~/mio_linux/kernel$ make -j 4
  CHK     include/config/kernel.release
CONFIG_CC_STACKPROTECTOR_AUTO: Compiler does not support any known stack-protector
Cannot use CONFIG_CC_STACKPROTECTOR_AUTO: not supported by compiler
Makefile:1097: recipe for target 'prepare-compiler-check' failed
make: *** [prepare-compiler-check] Error 1
make: *** Waiting for unfinished jobs....
make: *** wait: No child processes.  Stop.


Is this expected, as I was under the impression my compiler was not that
outdated ...

Cheers.

-- 
Robert
