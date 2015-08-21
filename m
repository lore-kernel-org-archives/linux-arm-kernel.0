From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 21 Aug 2015 23:57:09 +0300
Subject: [PATCH v2] ARM: shmobile: silk: add SDHI1 DT support
In-Reply-To: <20150812012652.GH15957@verge.net.au>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <2757472.iuyUyRzJ3z@wasted.cogentembedded.com>
 <20150812012652.GH15957@verge.net.au>
Message-ID: <55D790A5.1050008@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2015 04:26 AM, Simon Horman wrote:

>> Define the SILK board dependent part of the SDHI1 (connected to micro-SD slot)
>> device nodes along with the necessary voltage regulators.
>>
>> Based on the original patch by Vladimir Barinov
>> <vladimir.barinov@cogentembedded.com>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against 'renesas-devel-20150810-v4.2-rc6' tag of Simon Horman's
>> 'renesas.git' repo plus the R8A7794/SILK QSPI patches just re-posted. It needs
>> the R8A7794 GPIO patches in order to compile.
>>
>> Changes in version 2:
>> - removed not working SDHI0 stuff, renamed the patch;
>> - replaced SDHI1's "wp-gpios" property with "disable-wp".
>
> I am wondering if you could explain the motivation for the "disable-wp"
> update

    Please see the comment in mmc_sd_get_ro().

> and weather it is appropriate for other r8a779* dts files.

    In case of micro-SD slots, yes.

> Thanks.

MBR, Sergei
