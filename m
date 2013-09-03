From: Russ.Dill@ti.com (Russ Dill)
Date: Tue, 3 Sep 2013 06:56:53 -0700
Subject: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
In-Reply-To: <1377598305-15539-3-git-send-email-rnayak@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
 <1377598305-15539-3-git-send-email-rnayak@ti.com>
Message-ID: <CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 3:11 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> Use drivers/misc/sram.c driver to manage SRAM on all DT only
> OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
> the existing private implementation.
>
> Address and size related data  is removed from mach-omap2/sram.c
> and now passed to drivers/misc/sram.c from DT.
>
> Users can hence use general purpose allocator apis instead of
> OMAP private ones to manage and use SRAM.
>
> Currently there are no users on SRAM on these platfoms.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

I was trying to experiment with this on am33xx, but I noticed that the
ioremap region is not marked exec, so it cannot be used to run code.
