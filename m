From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 3 Jan 2017 11:18:15 +0000
Subject: [PATCH 1/2] arm64: setup: introduce kaslr_offset()
In-Reply-To: <4094c1ef-0a75-7076-58e0-52ece326188b@linux.com>
References: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
 <1481417456-28826-2-git-send-email-alex.popov@linux.com>
 <20161222061857.GA26502@yury-N73SV>
 <4094c1ef-0a75-7076-58e0-52ece326188b@linux.com>
Message-ID: <db9266fb-5c6e-5dfb-2aac-4165c6b2b337@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Catalin,

On 22/12/16 12:51, Alexander Popov wrote:
> On 22.12.2016 09:18, Yury Norov wrote:
>> On Sun, Dec 11, 2016 at 03:50:55AM +0300, Alexander Popov wrote:
>>> Introduce kaslr_offset() similarly to x86_64 for fixing kcov.
> 
> [...]
> 
>> Hi Alexander,
>>
>> I found today's linux-next master broken:
> 
> [...]
> 
>> It looks like you declare kaslr_offset() twice - in this patch, and in 7ede8665f
>> (arm64: setup: introduce kaslr_offset()). 
> 
> Hello Yury,
> 
> There was a race during applying this patch. So currently linux-next has 2 versions of it.
> 
> The first one is 1a339a14b1f2c7a0dfdd6db79eee1e55d3cec357, which is original.
> The second one is 7ede8665f27cde7da69e8b2fbeaa1ed0664879c5, updated by Will Deacon and
> applied to the mainline.
> 
> I'm sorry for that. The first one should be definitely dropped.

Looks like this is still broken in today's -next.

Cheers
Jon

-- 
nvpublic
