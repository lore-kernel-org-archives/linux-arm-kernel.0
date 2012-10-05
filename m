From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 5 Oct 2012 10:10:16 +0200
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data
 via platform data
In-Reply-To: <87r4pdst5n.fsf@deeprootsystems.com>
References: <1349369231-25204-1-git-send-email-j-pihet@ti.com>
 <87r4pdst5n.fsf@deeprootsystems.com>
Message-ID: <CAORVsuWmFrtH2WHCrnq6L=E-R2ndeGe76w_3hbwi4JdQSSxQBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2012 at 1:40 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> jean.pihet at newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Remove the device dependent code (ex. cpu_is_xxx()) and settings
>> from the driver code and instead pass them via the platform
>> data. This allows a clean separation of the driver code and the platform
>> code, as required by the move of the platform header files to
>> include/linux/platform_data.
>>
>> Note about the smartreflex functional clocks: the smartreflex fclks
>> are derived from sys_clk and have the same name as the main_clk from
>> the hwmod entry, in order for the SmartReflex driver to request the
>> fclk (using clk_get(dev, "fck")).
>>
>> Based on mainline 3.6.0. Boot tested on OMAP3&4 platforms.
>
> Thanks, queuing this version for v3.8 (branch: for_3.8/pm/sr)

Thanks!
Jean

>
> Kevin
>
> P.S. in the future, It helps reviewers and maintainers if there's some
> versioning in the patches (e.g. PATCH v3 0/2]), especially when updated
> versions come in quick succession.  Thanks.
>
