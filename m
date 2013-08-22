From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Aug 2013 00:45:24 -0700
Subject: [Suggestion] ARM: allmodconfig: about cross compiling failure
 under i386 ubuntu.
In-Reply-To: <52147E12.4060401@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com>
 <52147E12.4060401@asianux.com>
Message-ID: <20130822074524.GS7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chen Gang <gang.chen@asianux.com> [130821 01:53]:
> Hello Maintainers:
> 
> When build arm with allmodconfig under ubuntu i386 with arm-linux-
> gnueabi-gcc 4.7, as 2.22, it report the errors.
> 
> Please help check, thanks (the related config file in attachment).

It seems that some make flags may need to be specified separately
in some makefiles. See the following for some examples:

$ find arch/arm -name Makefile | xargs grep -i flags

I'm getting different errors though, I'm getting:

arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch

As probably my compiler does not support the cortex-a9 switch,
I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.

Regards,

Tony
