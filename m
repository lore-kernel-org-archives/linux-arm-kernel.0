From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 23 Oct 2009 10:33:56 -0700
Subject: [PATCH v2 12/32] OMAP: PM: DMA context save/restore for off-mode
	support
In-Reply-To: <6ed0b2680910230132o3a193659g5526f8c9c479680f@mail.gmail.com>
	(Grazvydas Ignotas's message of "Fri\,
	23 Oct 2009 11\:32\:26 +0300")
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<6ed0b2680910230132o3a193659g5526f8c9c479680f@mail.gmail.com>
Message-ID: <871vkuggl7.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grazvydas Ignotas <notasas@gmail.com> writes:

>> ?static int __init omap_init_dma(void)
>> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
>> old mode 100644
>> new mode 100755
>
> ^^ whoops?
>

Good catch, I'll fix this up in my pm-off branch.

Kevin

>> index 72f680b..1c017b2
>> --- a/arch/arm/plat-omap/include/plat/dma.h
>> +++ b/arch/arm/plat-omap/include/plat/dma.h
>> @@ -633,6 +633,11 @@ extern void omap_set_dma_dst_endian_type(int lch, enum end_type etype);
>> ?extern void omap_set_dma_src_endian_type(int lch, enum end_type etype);
>> ?extern int omap_get_dma_index(int lch, int *ei, int *fi);
>>
>> +void omap_dma_global_context_save(void);
>> +void omap_dma_global_context_restore(void);
>> +
>> +extern void omap_dma_disable_irq(int lch);
>> +
>> ?/* Chaining APIs */
>> ?#ifndef CONFIG_ARCH_OMAP1
>> ?extern int omap_request_dma_chain(int dev_id, const char *dev_name,
>> --
>> 1.6.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>
