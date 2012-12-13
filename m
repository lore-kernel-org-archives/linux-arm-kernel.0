From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 13 Dec 2012 19:14:49 +0100
Subject: [PATCH v4 0/7] enable support for AMBA drivers under x86
In-Reply-To: <50C93A83.8040106@zytor.com>
References: <50C93A83.8040106@zytor.com>
 <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <50C93718.2090706@zytor.com>
Message-ID: <20121213181449.GA15966@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> Build failure:
> 
> o.i386-allconfig/make.log:make[4]: *** [drivers/gpio/gpio-pl061.o] Error 1
> o.i386-allconfig/make.log:make[3]: *** [drivers/gpio] Error 2

This happens because the pl061 is not in this checkout.

I also got a message from the "kbuild test robot", which results from
the same kind of problem.

I'll check the details later, identifying the missing patches and whether
there are remaining warnings.

> /home/hpa/kernel/tip.x86-amba/arch/x86/pci/sta2x11-fixup.c:186:2: 
> warning: initialization from incompatible pointer type [enabled by default]

This is a long-standing problem, but with not practical effects. I
proposed a pair of different fixes quite some months ago. I'll respin
the problem tomorrow.

/alessandro
