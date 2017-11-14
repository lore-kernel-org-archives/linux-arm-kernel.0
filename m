From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 14 Nov 2017 13:27:41 +0000
Subject: [PATCH] arm64: perf: remove duplicated and unsupported events for
 Cortex-A73
In-Reply-To: <20171114124913.np2rtiyhghxipzzx@ukko.fi.intel.com>
References: <1510662479-9550-1-git-send-email-xuyiping@hisilicon.com>
 <20171114124913.np2rtiyhghxipzzx@ukko.fi.intel.com>
Message-ID: <e7909d3c-9e29-a89a-270d-1b6d455ae2a9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/11/17 12:49, Alexander Shishkin wrote:
> On Tue, Nov 14, 2017 at 08:27:59PM +0800, Xu YiPing wrote:
>> bus access read/write events are not supported in A73, and the definition
>> is duplicated, so delete it.
> 
> In the changelog, it would be nice to mention the commit that added these:
> 
> 5561b6c5e9813 ("arm64: perf: add support for Cortex-A73")
> 
> Also it's not clear what is this new statement based on. The original
> commit at least references a TRM document.
> 

I re-checked the TRM for this core and Xu is right, the BUS_ACCESS 
events are not available on Cortex-A73. Plus those entries are 
duplicated, I think something went wrong when I rebased the patch.

So I think this new patch is doing the right thing.

Thanks for catching that.

Cheers,

-- 
Julien Thierry
