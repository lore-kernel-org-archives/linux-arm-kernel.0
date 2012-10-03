From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Oct 2012 10:13:10 +0100
Subject: [PATCH] ARM: arch timer: Export 'read_current_timer' symbol
In-Reply-To: <20121003005218.GA23874@animalcreek.com>
References: <20121003005218.GA23874@animalcreek.com>
Message-ID: <20121003091310.GB22445@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Oct 03, 2012 at 01:52:18AM +0100, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Commit 923df96b9f31b7d08d8438ff9677326d9537accf
> (ARM: 7451/1: arch timer: implement read_current_timer and get_cycles)
> modifies get_cycles() such that it calls read_current_timer().
> Unfortunately, the 'read_current_timer' symbol is not exported so when
> a driver that calls get_cycles() is built as a module, an undefined
> reference error occurs.
> 
> A good example is the crypto/tcrypt.c (CONFIG_CRYPTO_TEST) driver
> because it calls get_cycles() and can only be built as a module.
> 
> Fix this error by exporting the 'read_current_timer' symbol.

This was already reported over on the kernel-janitors list, I assumed they'd
CC'd LAK, but it looks like it didn't happen.

  http://marc.info/?l=kernel-janitors&m=134910841909057&w=2

Anyway, I've got a fix in the works (I don't think you need the ifdef).

Will
