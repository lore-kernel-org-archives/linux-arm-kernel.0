From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 18 Mar 2014 13:19:35 -0700
Subject: [V2] arm: pj4: check cpu id for pj4 cp0 access
In-Reply-To: <20140318201537.GA20942@beef>
References: <1371200637-20850-1-git-send-email-chao.xie@marvell.com>
 <20140318201537.GA20942@beef>
Message-ID: <CAGa+x86Nrt47eFMoH9UHwG502J+p-Q0fsc38WG13tNmpYqLE3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 1:15 PM, Matt Porter <mporter@linaro.org> wrote:
> On Fri, Jun 14, 2013 at 05:03:57AM -0400, Chao Xie wrote:
>> Check cpu id in pj4_cp0_init. So for no-PJ4 V7 cpus,
>> pj4_cpu0_init just return.
>> This fix will help to make the all the V7 cpus(pj4 and no-PJ4)
>> use same platform code.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> This patch fixes a boot failure in next now that ARCH_DOVE (and thus
> CPU_PJ4) are enabled in multi_v7_defconfig. I verified that boot works
> again in next with the BCM28155-AP board.
>
> Tested-by: Matt Porter <mporter@linaro.org>

I've also verified that this fixes the boot regression on the BCM28155-AP board.

Tested-by: Kevin Hilman <khilman@linaro.org>

Chao, can you collect the acks/tested-bys and submit this to Russell's
patch tracker[1] so he can apply it please?.  Thanks.

Kevin

[1] http://www.arm.linux.org.uk/developer/patches/
