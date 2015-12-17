From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 17 Dec 2015 11:55:15 +0800
Subject: block layer bug with 4.4-rc3+
In-Reply-To: <1885710.UNGYhDGGcI@wuerfel>
References: <566FF3ED.1000503@arm.com>
 <CACVXFVN3w0Y_8k3TiKoGytbayXiB+mRhgDn-OueV2+e93i=4AQ@mail.gmail.com>
 <56717B6F.2040008@arm.com> <1885710.UNGYhDGGcI@wuerfel>
Message-ID: <CACVXFVPmZmWt7wApP+dwE7MiJj4hM_eJthREN2Vd5uun2hxK7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 11:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 December 2015 14:55:43 Andre Przywara wrote:
>> Using the plain multi_v7_defconfig (which doesn't have LPAE and makes me
>> loose half of the RAM on that box) didn't show the bug so far.
>> One of the effects of turning on LPAE is that dma_addr_t and phys_addr_t
>> turn to 64-bit, with long, int and void* still being 32-bit. Can you
>> think of any issues that could be related to that?
>>
>
> Another difference between the platforms is highmem. On Midway,
> almost all of RAM is highmem, which needs a lot of special handling
> that we don't need on platform with less RAM.

Yeah, block bounce can be triggered for highmem generally.

>
> To rule out both of highmem and LPAE, it might be interesting to
> test again on Midway with CONFIG_HIGHMEM and CONFIG_LPAE disabled.
> This will limit the RAM to 768MB, but if the bug still shows up,
> you know it's something else.
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
