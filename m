From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 7 Mar 2014 11:44:18 +0800
Subject: [PATCH 3/7] of: introduce of_dma_is_coherent() helper
In-Reply-To: <CAL_JsqJnG1c0=+UgOmNOGs7a5jv2f3O074-TsXibiHsXapXhcQ@mail.gmail.com>
References: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>	<1394097598-17622-4-git-send-email-santosh.shilimkar@ti.com>
 <CAL_JsqJnG1c0=+UgOmNOGs7a5jv2f3O074-TsXibiHsXapXhcQ@mail.gmail.com>
Message-ID: <53194092.7010809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 March 2014 11:13 AM, Rob Herring wrote:
> On Thu, Mar 6, 2014 at 3:19 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> The of_dma_is_coherent() helper parses the given DT device
>> node to see if the "dma-coherent" property is supported and
>> returns true or false accordingly.
>>
>> For the architectures which are fully dma coherent and don't need per device
>> property, it can enable CONFIG_ARCH_IS_DMA_COHERENT config option which
>> enables DMA coherent for all devices by default.
> 
> This worries me. I killed off arch_is_coherent() for arm. Now we're
> adding something back. Also, we already have HAVE_GENERIC_DMA_COHERENT
> which is different, but the names will be confusing. MIPS also has
> DMA_NONCOHERENT.
> 
Thanks for comments Rob. I will address them in next version.
Specifically about ARCH_IS_DMA_COHERENT, I wasn't very comfortable either
while adding it. But as Arnd mentioned, there is a need to have a way
for the arch's which are fully coherent to use coherent ops by default.

Am not sure whats the best way to have such support without imposing
any special updates on such arches.

Arnd, Any better alternative here ?

Regards,
Santosh
