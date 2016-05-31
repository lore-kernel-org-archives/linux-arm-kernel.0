From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 31 May 2016 11:21:37 +0200
Subject: [PATCH] ARM: uniphier: drop code for old DT binding
In-Reply-To: <1464682628-12163-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464682628-12163-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <4992506.m4GEHIOqdc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 31, 2016 5:17:08 PM CEST Masahiro Yamada wrote:
> Commit 307d40c56b0c ("ARM: uniphier: rework SMP code to support new
> System Bus binding") added a new DT binding for SMP code, but still
> kept old code for the backward compatibility.
> 
> Linux 4.6 was out with both bindings supported, so it should not
> hurt to drop the old code now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 

That explanation is in general not sufficient. Are you sure that
nobody is shipping a machine with their own dts file that is not
merged upstream, and that there are no bootloaders that have a
hardcoded dtb file that we need to support indefinitely?

	Arnd
