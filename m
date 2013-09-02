From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 13:48:28 +0100
Subject: [PATCH v2] ARM: highbank: fix debug uart virtual address for LPAE
In-Reply-To: <1376784748-31914-1-git-send-email-robherring2@gmail.com>
References: <1376784748-31914-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130902124828.GT6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 07:12:28PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Section entries are 2MB on LPAE, so the DEBUG_LL virtual address must
> have the same offset in the 2MB section as the physical address. This
> fixes async external aborts when DEBUG_LL is enabled on Midway.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> v2: Rebase on Russell's DEBUG_LL clean-up

Do you also want to do a patch for this for v3.11, because if it's wrong
in my series, it's wrong in mainline at the moment:

-               ldr     \rv, =0xfee36000
-               ldr     \rp, =0xfff36000
