From: Russ.Dill@ti.com (Russ Dill)
Date: Fri, 6 Sep 2013 11:40:09 -0700
Subject: [RFC 0/4] Create infrastructure for running C code from SRAM.
In-Reply-To: <20130906111408.GI25647@n2100.arm.linux.org.uk>
References: <1378226665-27090-1-git-send-email-Russ.Dill@ti.com>
 <52278F84.2080509@elopez.com.ar>
 <CA+Bv8XaHonrpeNZ6tRCyqpMK1bzgpDTqvLyrsLWEyMY_ky6apQ@mail.gmail.com>
 <20130906111408.GI25647@n2100.arm.linux.org.uk>
Message-ID: <CA+Bv8Xaw6KMu5MrjdjQfue7F1JtFfAMNyZhC1hyL-RpWz=wo+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 6, 2013 at 4:14 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Sep 04, 2013 at 02:47:51PM -0700, Russ Dill wrote:
>> I think this is already taken care of by the way sram.c is using
>> genalloc. The allocation returned should be aligned to 32 bytes. The
>> thumb bit shouldn't be an issue as code is copied based on the start
>> and end makers made by the linker. I may need to add .align statements
>> in the linker so that the start and end markers for the copied code
>> are aligned to at least 8 bytes.
>
> I think you need to read up on what fncpy does... there's more to it
> than just merely copying code at an appropriate alignment.

Yes, I need to add a pair of inlines that do the asm trickery to/from
function addresses. Thanks.
