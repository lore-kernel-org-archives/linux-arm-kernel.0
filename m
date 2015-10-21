From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Wed, 21 Oct 2015 08:56:12 -0400
Subject: [PATCH v4 2/3] xen, cpu_hotplug: call device_offline instead of
 cpu_down
In-Reply-To: <1445428430-21567-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1510211251370.27957@kaball.uk.xensource.com>
 <1445428430-21567-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <56278B6C.7090608@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2015 07:53 AM, Stefano Stabellini wrote:
> When offlining a cpu, instead of cpu_down, call device_offline, which
> also takes care of updating the cpu.dev.offline field. This keeps the
> sysfs file /sys/devices/system/cpu/cpuN/online, up to date.  Also move
> the call to disable_hotplug_cpu, because it makes more sense to have it
> there.
>
> We don't call device_online at cpu-hotplug time, because that would
> immediately take the cpu online, while we want to retain the current
> behaviour: the user needs to explicitly enable the cpu after it has
> been hotplugged.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: konrad.wilk at oracle.com
> CC: boris.ostrovsky at oracle.com
> CC: david.vrabel at citrix.com

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
