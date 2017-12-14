From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 14 Dec 2017 13:03:42 -0600
Subject: [PATCH] arm64: fix CONFIG_DEBUG_WX address reporting
In-Reply-To: <20171213115835.pkt3fyqcbk7lgdeb@lakrids.cambridge.arm.com>
References: <bff5a2b3-0d93-5f55-c129-4b14a5a09b45@codeaurora.org>
 <680ec27a-1557-f2d9-8159-bd49326bd36c@redhat.com>
 <20171213115835.pkt3fyqcbk7lgdeb@lakrids.cambridge.arm.com>
Message-ID: <53e20df7-9b41-31ec-21fe-30786ae7a0a6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2017 05:58 AM, Mark Rutland wrote:
> Whoops; I think we forgot to apply the VA_START offset in
> ptdump_check_wx(), so we report the address wrong.
> 
> Does the below (untested) patch result in a sane-looking report?

[   10.977304] arm64/mm: Found insecure W+X mapping at address 
ffff190621232000/0xffff190621232000

I can reproduce the problem after 2-3 reboots.  When it happens, I get a 
different pair of addresses, but they all look like these.

I'm not sure what to do next, however.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
