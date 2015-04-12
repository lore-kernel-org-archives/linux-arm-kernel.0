From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Apr 2015 22:07:02 +0200
Subject: [PATCH 0/7] ARM: dts: Refactor Exynos5 boards for phandle notation
In-Reply-To: <1428841494-20769-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1428841494-20769-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <2603418.sEMfdEBYRq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 April 2015 21:24:47 Krzysztof Kozlowski wrote:
> 
> The phandle notation reduces possible mistakes when overriding nodes
> by child board files and reduces duplication of addresses.
> 
> The patchset refactors Exynos5 boards to use the phandle way.
> 
> Tested by comparison of decompiled DTB for each commit.

The patches look fine, but the description is wrong as you are not
using 'phandles' here, you are using 'labels'.

A phandle is a reference to another device node inside of a property,
and while that is normally done using labels like

	interrupt-parent = <&gic>;

you can just as well use the full path in a phandle.

	Arnd
