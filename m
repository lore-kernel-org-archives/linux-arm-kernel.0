From: wangnan0@huawei.com (Wangnan (F))
Date: Mon, 21 Mar 2016 18:38:31 +0800
Subject: [PATCH 2/2] arm64: Fix watchpoint recursion when single-step is
 wrongly triggered in irq
In-Reply-To: <20160321102423.GB15150@dhcppc6.redhat.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
 <1458549470-124791-2-git-send-email-hekuang@huawei.com>
 <20160321102423.GB15150@dhcppc6.redhat.com>
Message-ID: <56EFCF27.3090903@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/21 18:24, Pratyush Anand wrote:
> On 21/03/2016:08:37:50 AM, He Kuang wrote:
>> On arm64, watchpoint handler enables single-step to bypass the next
>> instruction for not recursive enter. If an irq is triggered right
>> after the watchpoint, a single-step will be wrongly triggered in irq
>> handler, which causes the watchpoint address not stepped over and
>> system hang.
> Does patch [1] resolves this issue as well? I hope it should. Patch[1] has still
> not been sent for review. Your test result will be helpful.
>
> ~Pratyush
>
> [1] https://github.com/pratyushanand/linux/commit/7623c8099ac22eaa00e7e0f52430f7a4bd154652

Could you please provide a test program for your case so we can test
it on our devices? I guess setting breakpoint on a "copy_from_user()"
accessing an invalid address can trigger this problem?

Thank you.
