From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Jun 2013 22:57:02 +0200
Subject: [PATCH 15/15] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <51AA59D0.7020805@gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <201306012203.39133.arnd@arndb.de> <51AA59D0.7020805@gmail.com>
Message-ID: <201306012257.02327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 June 2013, Rob Herring wrote:
> No, we still need empty functions. Here is what of_device.h looks like:
> 
> http://tinyurl.com/l2azz5m
> 
> BTW, it has your ack.
> 

Could you add a patch on top that only puts the function declarations
inside of #ifdef that don't have an inline wrapper?

It's really annoying to have to change the header file every time one
needs to call a function from a driver in the DT-only case.

	Arnd
