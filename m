From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 5 May 2014 21:56:38 +0530
Subject: [PATCH v4 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <CAL1qeaHrP+i4EhOQKkSX7xFNyiyBiBfpsV3B0EHCFcrNzc6KLQ@mail.gmail.com>
References: <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <1399044359-15784-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405021347500.980@knanqh.ubzr>
 <CAL1qeaHrP+i4EhOQKkSX7xFNyiyBiBfpsV3B0EHCFcrNzc6KLQ@mail.gmail.com>
Message-ID: <CAM4voakV70=7S+nWoXDGg15JU5ig_Gkp8_o-rhZ0cBX4G4wnxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, May 2, 2014 at 11:53 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
>>> +     /*
>>> +      * TODO: Turn off the clusters when all cores in the cluster
>>> +      * are down to achieve significant power savings.
>>> +      */
>>
>> This comment should actually be located right after the
>> "if (exynos_cluster_unused(cluster))" above.  That is where the cluster
>> control should be applied, assuming it'll be effective only when WFI is
>> executed.
>
> Correct me if I'm wrong Samsung folks, but I thought it was not
> possible to apply cluster power control from a CPU within the cluster
> being powered down, i.e. a CPU in the other cluster must be the one to
> apply the cluster power control to power down the outbound cluster.
I was under the same impression until quite recently. However, based
on inputs from the hardware team, there are bits available (in the
*COMMON_OPTION register) that ensure "ARM_CORE0~3 are turned off
earlier and then ARM_COMMON_L2 is turned off finally". This allows us
to turn off the cluster from a cpu of the same cluster. We have used
these bits in our cluster power down cpuidle state implementation as
well.


Regards,
Abhilash
>
> -Andrew
