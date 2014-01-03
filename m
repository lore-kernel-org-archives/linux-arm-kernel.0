From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 13:10:09 +0100
Subject: ARM: mm: Could I change module space size or place modules in
 vmalloc area?
In-Reply-To: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
References: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
Message-ID: <201401031310.09930.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014, Gioh Kim wrote:

> I run out of module space because I have several big driver modules.
> I know I can strip the modules to decrease size but I need debug info now.
> 
> The default size of module is 16MB and the size is statically defined in the
> header file. 
> But a description for the module space size tells that it can be
> configurable at most 32MB.
> 
> I have changed the module space size to 18MB and tested my platform.
> It has been looking good.
> 
> I am not sure my patch is proper solution.
> Anyway, could I configure the module space size?
> 
> Or could I place the modules into vmalloc area?
> 

Aside from the good comments that Russell made, I would remark that the
fact that you need multiple megabytes worth of modules indicates that you
are doing something wrong. Can you point to a git tree containing those
modules?

	Arnd
