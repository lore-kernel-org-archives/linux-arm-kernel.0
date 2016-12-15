From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 15 Dec 2016 16:48:45 +0100
Subject: [PATCH] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <4bc9df75-1b67-2428-184e-ce52b5f95528@huawei.com>
References: <1481307042-29773-1-git-send-email-rrichter@cavium.com>
 <83d6e6d0-cfb3-ec8b-241b-ec6a50dc2aa9@huawei.com>
 <9168b603-04aa-4302-3197-00f17fb336bd@huawei.com>
 <20161214094542.GE5588@rric.localdomain>
 <4bc9df75-1b67-2428-184e-ce52b5f95528@huawei.com>
Message-ID: <20161215154845.GB8111@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.12.16 11:01:04, Yisheng Xie wrote:
> > I sent a V2 patch that uses pfn_present(). This only initilizes
> > sections with memory.
> hmm? maybe I do not quite catch what your mean, but I do not think
> pfn_present is right for this case.
> 
> IMO, The valid_section() means the section with mem_map, not section with memory.

Right, the section may be uninitialized with the present flag only.
valid_section() is better, this is also the pfn_valid() default
implementation.

Will rework. Thanks.

-Robert
