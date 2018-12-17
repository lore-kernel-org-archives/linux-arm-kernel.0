Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08752C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:35:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C476A206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ILUp9tVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C476A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZFawUnhqfLzvov2ewCDVC2I0JR15iQUcB5sUmzpqric=; b=ILUp9tVV4v7VU5
	ql7LI/EdygYemRozaBo6mjVzJfTLD6Sy93jh4T7e2du75MrCPlNZzAkl9bP908+LkN/pY6YX/z7xO
	pmk/yUBqCZWllbizYYfYDZdKZFFmSDbvUjQCaFtRKha1fnKQxKeUzozf9Y0aqyOJhw7yvkMLkXVaa
	aeozIh9ctyCEgE2GDyqa3UJQPJ+YYtCJ33KAUhFurOD1c6sepzI5o0vazfnhstBmHga3ZNU5/s7bs
	aSX8T15DJTqtDSjRMSZPJivIZAphziK4tp+EQlfdhKHly51/yB9VeZ4YsEc1vrBF/QvXn1gGlt8ce
	P6YmurbPCAQlJvloSuRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpJ4-00029Z-7C; Mon, 17 Dec 2018 09:35:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpJ0-0001ey-FB; Mon, 17 Dec 2018 09:35:20 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF83A8DA5B;
 Mon, 17 Dec 2018 09:35:04 +0000 (UTC)
Received: from [10.36.117.250] (ovpn-117-250.ams2.redhat.com [10.36.117.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EB7B60F8D;
 Mon, 17 Dec 2018 09:34:59 +0000 (UTC)
Subject: Re: [PATCH v1 9/9] mm: better document PG_reserved
To: Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org
References: <20181214111014.15672-1-david@redhat.com>
 <20181214111014.15672-10-david@redhat.com>
 <03f65c6f-1287-4c63-6705-16e58d659d94@infradead.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <affd050a-ae5d-f027-1cb8-0d30822f8f12@redhat.com>
Date: Mon, 17 Dec 2018 10:34:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <03f65c6f-1287-4c63-6705-16e58d659d94@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 17 Dec 2018 09:35:06 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_013518_557204_526DF064 
X-CRM114-Status: GOOD (  23.18  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, yi.z.zhang@linux.intel.com,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Miles Chen <miles.chen@mediatek.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15.12.18 01:12, Randy Dunlap wrote:
> On 12/14/18 3:10 AM, David Hildenbrand wrote:
>> The usage of PG_reserved and how PG_reserved pages are to be treated is
>> buried deep down in different parts of the kernel. Let's shine some light
>> onto these details by documenting current users and expected
>> behavior.
>>
>> Especially, clarify on the "Some of them might not even exist" case.
>> These are physical memory gaps that will never be dumped as they
>> are not marked as IORESOURCE_SYSRAM. PG_reserved does in general not
>> hinder anybody from dumping or swapping. In some cases, these pages
>> will not be stored in the hibernation image.
> 
> Hi,
> Thanks for the doc update.
> Comments below.
> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
>> Cc: Miles Chen <miles.chen@mediatek.com>
>> Cc: yi.z.zhang@linux.intel.com
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/linux/page-flags.h | 33 +++++++++++++++++++++++++++++++--
>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 808b4183e30d..9de2e941cbd5 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -17,8 +17,37 @@
>>  /*
>>   * Various page->flags bits:
>>   *
>> - * PG_reserved is set for special pages, which can never be swapped out. Some
>> - * of them might not even exist...
>> + * PG_reserved is set for special pages. The "struct page" of such a page
>> + * should in general not be touched (e.g. set dirty) except by their owner.
> 
>                                                                by its owner.

Indeed.

> 
>> + * Pages marked as PG_reserved include:
>> + * - Pages part of the kernel image (including vDSO) and similar (e.g. BIOS,
>> + *   initrd, HW tables)
>> + * - Pages reserved or allocated early during boot (before the page allocator
>> + *   was initialized). This includes (depending on the architecture) the
>> + *   initial vmmap, initial page tables, crashkernel, elfcorehdr, and much
> 
>                 VM map,

This should actually be vmemmap (aka struct pages).

> 
>> + *   much more. Once (if ever) freed, PG_reserved is cleared and they will
>> + *   be given to the page allocator.
>> + * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
>> + *   to read/write these pages might end badly. Don't touch!
>> + * - The zero page(s)
>> + * - Pages not added to the page allocator when onlining a section because
>> + *   they were excluded via the online_page_callback() or because they are
>> + *   PG_hwpoison.
>> + * - Pages allocated in the context of kexec/kdump (loaded kernel image,
>> + *   control pages, vmcoreinfo)
>> + * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
>> + *   not marked PG_reserved (as they might be in use by somebody else who does
>> + *   not respect the caching strategy).
>> + * - Pages part of an offline section (struct pages of offline sections should
>> + *   not be trusted as they will be initialized when first onlined).
>> + * - MCA pages on ia64
>> + * - Pages holding CPU notes for POWER Firmware Assisted Dump
>> + * - Device memory (e.g. PMEM, DAX, HMM)
>> + * Some PG_reserved pages will be excluded from the hibernation image.
>> + * PG_reserved does in general not hinder anybody from dumping or swapping
>> + * and is no longer required for remap_pfn_range(). ioremap might require it.
>> + * Consequently, PG_reserved for a page mapped into user space can indicate
>> + * the zero page, the vDSO, MMIO pages or device memory.
>>   *
>>   * The PG_private bitflag is set on pagecache pages if they contain filesystem
>>   * specific data (which is normally at page->private). It can be used by
>>
> 
> cheers.
> 

Thanks!

-- 

Thanks,

David / dhildenb

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
