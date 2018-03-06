From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 6 Mar 2018 09:26:38 +0000
Subject: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to memory map and
 unmap
In-Reply-To: <20180301212844.GU12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
 <20180301212844.GU12864@sirena.org.uk>
Message-ID: <58bce0b7-f7bc-59d7-bf75-503d95e13671@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review,

On 01/03/18 21:28, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:22PM +0000, srinivas.kandagatla at linaro.org wrote:
> 
>> +	num_regions = is_contiguous ? 1 : periods;
>> +	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;
> 
> Please write normal if statements, it's much easier to read.
> 

Sure, will fix it in next version.
>> +	buf_sz = PAGE_ALIGN(buf_sz);
> 
> I don't understand what this is doing, buf_sz is a length not an address
> so why are we attempting to align it?

Yes, this is a requirement form the DSP side that the size is multiple 
of 4KB. I will fix this properly in next version.

thanks,
srini
> 
