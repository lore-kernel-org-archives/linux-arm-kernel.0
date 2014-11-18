From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 18 Nov 2014 11:30:18 +0900
Subject: exynos boot falures in linux-next
In-Reply-To: <546A83D6.9060504@collabora.co.uk>
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>
 <7hoas54y7k.fsf@deeprootsystems.com> <7hlhn9zcse.fsf@deeprootsystems.com>
 <546A83D6.9060504@collabora.co.uk>
Message-ID: <546AAF3A.5090604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

On 2014? 11? 18? 08:25, Javier Martinez Canillas wrote:
> Hello Kevin,
> 
> On 11/17/2014 11:24 PM, Kevin Hilman wrote:
>>
>> As might have been expected, reverting the change that enables the
>> DRM/display options in exynos_defconfig fixes the problem.
>>
>> Kevin
>>
> 
> I'm sorry for causing a boot failure but when I first posted that patch,
> the Exynos DRM driver was working correctly (at least on the Exynos boards
> I've access to) so it seems the regression was introduced while the patch
> was posted but not yet picked.
> 
> I'm not sure what is the correct step in this case but I'm OK with
> reverting the patch until the Exynos DRM driver bug is fixed.

I found out a bug of Exynos DRM, which is infinite loop issue incurred
by -EPROBE_DEFER. I thought that we resolved this issue with some fixups
but not yet. The problem is because -EPROBE_DEFER is returned in case of
adding a component of a crtc device but one of a connector device. I
will fix it up soon.

Thanks for report,
Inki Dae

> 
> Best regards,
> Javier
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
