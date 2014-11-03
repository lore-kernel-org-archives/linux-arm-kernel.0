From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 3 Nov 2014 11:01:49 +0000
Subject: [Xen-devel] [PATCH v7 7/8] xen/arm/arm64: introduce
 xen_arch_need_swiotlb
In-Reply-To: <alpine.DEB.2.02.1411031044480.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>	<1414422568-19103-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1411031044480.22875@kaball.uk.xensource.com>
Message-ID: <5457609D.2000200@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/14 10:45, Stefano Stabellini wrote:
> On Mon, 27 Oct 2014, Stefano Stabellini wrote:
>> Introduce an arch specific function to find out whether a particular dma
>> mapping operation needs to bounce on the swiotlb buffer.
>>
>> On ARM and ARM64, if the page involved is a foreign page and the device
>> is not coherent, we need to bounce because at unmap time we cannot
>> execute any required cache maintenance operations (we don't know how to
>> find the pfn from the mfn).
>>
>> No change of behaviour for x86.
>>
>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>> Acked-by: Ian Campbell <ian.campbell@citrix.com>
> 
> Konrad, David, are you OK with the swiotlb-xen changes?

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

But swiotlb is Konrad's responsibility.

David
