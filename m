From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 May 2013 09:54:27 +0100
Subject: [PATCH] ARM: map_init_section flushes incorrect pmd
In-Reply-To: <CANutaR-2gTP7ubiEdgjFyzVMc6=4t5GPjLkH8pkup=O882Hb-Q@mail.gmail.com>
References: <1369738100-11152-1-git-send-email-ratbert.chuang@gmail.com>
 <20130528130502.GA28971@mudshark.cambridge.arm.com>
 <51A4B938.7080708@ti.com>
 <20130528140705.GE28971@mudshark.cambridge.arm.com>
 <51A4FC08.3060906@ti.com>
 <CANutaR-2gTP7ubiEdgjFyzVMc6=4t5GPjLkH8pkup=O882Hb-Q@mail.gmail.com>
Message-ID: <20130529085426.GA13095@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 03:14:58AM +0100, Po-Yu Chuang wrote:
> Will,
> I guess nobody noticed this because the MMU of later v7 processors
> fetches page table
> from D-cache. It even doesn't need to clean pmd to PoU.

It does if it's UP. The walker is only guaranteed to read from L1 if you
have the multiprocessing extensions.

As for this function, looks like it's ok because it has precisely one
caller, so it might be worth prefixing it with some underscores to make it
clear that nobody else should be calling it!

Will
