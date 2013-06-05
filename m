From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 05 Jun 2013 10:29:01 +0200
Subject: [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
In-Reply-To: <20130605070625.13311.17016.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
 <20130605070625.13311.17016.sendpatchset@w520>
Message-ID: <9933530.s16G7h846I@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013 16:06:25 Magnus Damm wrote:
> 
> +__ZRELADDR     := $(shell /bin/bash -c \
> +                    'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
> +

It's not important, but I think this can be written much simpler using
makefile syntax as

__ZRELADDR	:= $(sort $(loadaddr-y))

	Arnd
