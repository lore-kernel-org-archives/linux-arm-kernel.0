From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 14 Feb 2013 15:47:50 +0100
Subject: i.MX6 Solo: maxcpus=1 vs. nosmp: Warning from smp_twd.c?
In-Reply-To: <CAOMZO5CTfzZxRNQF=x5-MkM4nGBOXRd0CN7OnO1p=ahHDoT8CQ@mail.gmail.com>
References: <511CF063.3010200@de.bosch.com>
 <CAOMZO5CTfzZxRNQF=x5-MkM4nGBOXRd0CN7OnO1p=ahHDoT8CQ@mail.gmail.com>
Message-ID: <511CF916.2060705@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.02.2013 15:40, Fabio Estevam wrote:
> Hi Dirk,
> 
> On Thu, Feb 14, 2013 at 12:10 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> Hi,
>>
>> working on a i.MX6 Solo SoC (one Cortex A9 core) we are usually booting with
>> maxcpus=1 a kernel built with CONFIG_NR_CPUS=4. This is done to be able to
>> boot the same kernel on the Solo and Quad version of that SoC.
>>
>> Now, we tried to switch from 'maxcpus=1' to 'nosmp'. With 'nosmp' we get the
>> warning [1] in the boot messages. This isn't there with 'maxcpus=1'.
> 
> maxcpus=1 and nosmp are not equivalent as per the comment from kernel/smp.c:
> 
> /*
>  * Setup routine for controlling SMP activation
>  *
>  * Command-line option of "nosmp" or "maxcpus=0" will disable SMP
>  * activation entirely (the MPS table probe still happens, though).
>  *
>  * Command-line option of "maxcpus=<NUM>", where <NUM> is an integer
>  * greater than 0, limits the maximum number of CPUs activated in
>  * SMP mode to <NUM>.
>  */

Yes, understood that both options are not equal.

But should both options work on a single ARM Cortex A9 SoC without a 
warning? Or should one of the both options be preferred on a single ARM 
Cortex A9 SoC?

Thanks

Dirk
