From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 30 Sep 2014 00:30:06 -0400 (EDT)
Subject: [PATCH 0/5] ARM: move #include <asm/cp15.h> into cacheflush.h
In-Reply-To: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <alpine.LFD.2.11.1409300016060.5311@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Sep 2014, Brian Norris wrote:

> There are several places where an explicit include of <asm/cp15.h> is needed
> just because cacheflush.h uses one of its macros in v7_exit_coherency_flush().
> Let's put the include in the proper header.
> 
> These obviously have some dependencies, so I'd focus on:
>   (1) Is patch 1 acceptable? If so, then:

Well, I'm wondering if it is really a gain to force a dependency for 
cp15.h on every user of cacheflush.h just because of the seldomly used 
v7_exit_coherency_flush(). But I don't mind either ways.


Nicolas
