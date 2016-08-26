From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 26 Aug 2016 08:27:20 +0200
Subject: [PATCH 00/44] usb: don't print on ENOMEM
In-Reply-To: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
References: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
Message-ID: <20160826082720.39f1e394@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 25 Aug 2016 19:38:52 +0200 Wolfram Sang wrote:
> Here is my next series to save memory by removing unneeded strings. It removes
> in the usb subsystem all unspecific error messages after calling malloc-based
> functions, i.e. (devm_)k[zcm]alloc. kmalloc prints enough information in that
> case. If the message was specific (e.g. "can't save CLEAR_TT_BUFFER state"), I
> left it. This series saves ~4.5KB of "out of memory" permutations in .text and
> .rodata. For modified lines, (x == NULL) was replaced with (!NULL) as well.
s/!NULL/!x/


Lothar Wa?mann
