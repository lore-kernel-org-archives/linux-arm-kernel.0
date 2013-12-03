From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 03 Dec 2013 15:28:23 +0000
Subject: [Xen-devel] [PATCH] xen/block: Correctly define structures in
 public headers on ARM32 and ARM64
In-Reply-To: <529E039A02000078001097F5@nat28.tlf.novell.com>
References: <1386083382-7306-1-git-send-email-julien.grall@linaro.org>
 <529E039A02000078001097F5@nat28.tlf.novell.com>
Message-ID: <529DF897.1080303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 03:15 PM, Jan Beulich wrote:
>>>> On 03.12.13 at 16:09, Julien Grall <julien.grall@linaro.org> wrote:
>> --- a/include/xen/interface/io/blkif.h
>> +++ b/include/xen/interface/io/blkif.h
>> @@ -146,7 +146,7 @@ struct blkif_request_segment_aligned {
>>  struct blkif_request_rw {
>>  	uint8_t        nr_segments;  /* number of segments                   */
>>  	blkif_vdev_t   handle;       /* only for read/write requests         */
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> 
> Perhaps using
> 
> #ifndef CONFIG_X86_32
> 
> would be the better one, assuming that we won't add further
> non-64-bit-clean ABI variants?

I'm fine with this solution. I will resend the patch.

-- 
Julien Grall
