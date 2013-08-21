From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 21 Aug 2013 12:25:00 -0300
Subject: build warnings: multi_v7_defconfig + LPAE,
 printk with variable types
In-Reply-To: <87k3jfqdmp.fsf@linaro.org>
References: <87k3jfqdmp.fsf@linaro.org>
Message-ID: <CAOMZO5BNM1j0CNSqvbtrLz50kTtSkKratOgtNXq9qqrbgdzYpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 12:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
> I've started auto-building the multi_v7_defconfig with LPAE enabled, and
> noticed a handful of warnings[1]
>
> Several are due to using prink format on a type that changes with a
> config option (e.g several below use %x to print a resource_size_t,
> which is obviously different between 32- and 64-bit builds.
>
> So this got me to wondering if there is "one true way" for using printk
> on types that might change with config option (preferably without
> ifdef.)
>
> The one that comes to mind would be to just always cast to the larger of
> the types and use the correspondig format.  For the ones below, it would
> mean casting to (u64) and using '%llx'.
>
> Is there a better way?

Yes, according to Documentation/printk-formats.txt:

"Physical addresses:

    %pa    0x01234567 or 0x0123456789abcdef

    For printing a phys_addr_t type (and its derivatives, such as
    resource_size_t) which can vary based on build options, regardless of
    the width of the CPU data path. Passed by reference."

I can send a patch fixing these warnings if you want.

Regards,

Fabio Estevam
