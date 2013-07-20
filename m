From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 20 Jul 2013 06:39:45 +0100
Subject: [PATCH v2] of: Specify initrd location using 64-bit
In-Reply-To: <51D1F5E2.6070609@gmail.com>
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com>
 <51D1F5E2.6070609@gmail.com>
Message-ID: <20130720053945.C7AC63E0C52@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Jul 2013 16:34:26 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On 07/01/2013 01:20 PM, Santosh Shilimkar wrote:
> > On some PAE architectures, the entire range of physical memory could reside
> > outside the 32-bit limit.  These systems need the ability to specify the
> > initrd location using 64-bit numbers.
> > 
> > This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> > use 64-bit numbers instead of the current unsigned long.
> > 
> > There has been quite a bit of debate about whether to use u64 or phys_addr_t.
> > It was concluded to stick to u64 to be consistent with rest of the device
> > tree code. As summarized by Geert, "The address to load the initrd is decided
> > by the bootloader/user and set at that point later in time. The dtb should not
> > be tied to the kernel you are booting"
> 
> That was quoting me. Otherwise:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> Unless Grant feels compelled to pick this up for 3.11, I think it has to
> wait for 3.12.

Nope, 3.12 is fine. Applied.

g.
