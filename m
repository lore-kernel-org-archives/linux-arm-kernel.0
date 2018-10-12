From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 12 Oct 2018 14:28:56 -0500
Subject: [PATCH v2] of: base: Change logic in of_alias_get_alias_list()
In-Reply-To: <1bc1488a4cbf21fafc64269958ba3ed04e0a3c1c.1539322989.git.michal.simek@xilinx.com>
References: <1bc1488a4cbf21fafc64269958ba3ed04e0a3c1c.1539322989.git.michal.simek@xilinx.com>
Message-ID: <CAL_JsqKTGmrQx+siHQprMAvX1M-p08Qkv0nEwAARK3NJz-wobg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 12:43 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Check compatible string first before setting up bit in bitmap to also
> cover cases that allocated bitfield is not big enough.
> Show warning about it but let driver to continue to work with allocated
> bitfield to keep at least some devices (included console which
> is commonly close to serial0) to work.
>
> Fixes: b1078c355d76 ("of: base: Introduce of_alias_get_alias_list() to check alias IDs")
> Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
>  - Use EOVERFLOW instead of EINVAL - Rob

Reviewed-by: Rob Herring <robh@kernel.org>
