From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Sep 2013 12:14:08 +0100
Subject: [RFC 0/4] Create infrastructure for running C code from SRAM.
In-Reply-To: <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
 <52278F84.2080509@elopez.com.ar>
 <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
Message-ID: <20130906111408.GI25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 02:47:51PM -0700, Russ Dill wrote:
> I think this is already taken care of by the way sram.c is using
> genalloc. The allocation returned should be aligned to 32 bytes. The
> thumb bit shouldn't be an issue as code is copied based on the start
> and end makers made by the linker. I may need to add .align statements
> in the linker so that the start and end markers for the copied code
> are aligned to at least 8 bytes.

I think you need to read up on what fncpy does... there's more to it
than just merely copying code at an appropriate alignment.
