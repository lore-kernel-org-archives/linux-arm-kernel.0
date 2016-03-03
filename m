From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 07:47:51 -0600
Subject: [PATCH v13 4/6] arm64: Move unflatten_device_tree() call earlier.
In-Reply-To: <1456959362-2036-5-git-send-email-ddaney.cavm@gmail.com>
References: <1456959362-2036-1-git-send-email-ddaney.cavm@gmail.com>
 <1456959362-2036-5-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <CAL_JsqL0Mzgp_SkycmiZBbt2OoGtE7_rFgD41Jex4nDS7xXrHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 4:56 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> In order to extract NUMA information from the device tree, we need to
> have the tree in its unflattened form.
>
> Move the call to unflatten_device_tree() into paging_init().  This
> puts it before the call to bootmem_init(), which is where the NUMA
> information is extracted.

Can't you just move up unflatten_device_tree in setup_arch rather than
hiding in paging_init?

> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/kernel/setup.c | 7 +++----
>  arch/arm64/mm/mmu.c       | 5 +++++
>  2 files changed, 8 insertions(+), 4 deletions(-)
