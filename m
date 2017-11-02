From: gengdongjiu@huawei.com (gengdongjiu)
Date: Thu, 2 Nov 2017 16:52:37 +0800
Subject: [PATCH v1 1/3] arm64: add a macro for SError synchronization
In-Reply-To: <20171101141603.4ppgwup4grnmcswe@lakrids.cambridge.arm.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
 <1509563697-6359-2-git-send-email-gengdongjiu@huawei.com>
 <6dc82768-8564-a54e-041b-3b9965fa038b@arm.com>
 <d7b8b779-9e00-8e8f-b44e-48e3d7e37058@huawei.com>
 <20171101141603.4ppgwup4grnmcswe@lakrids.cambridge.arm.com>
Message-ID: <399edb73-ec0d-1f73-d244-0d10f0a9e169@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/11/1 22:16, Mark Rutland wrote:
>> it will report Error.
> Alternatives cannot be nested. You need to define a cap like:
> 
>   ARM64_HAS_RAS_NOT_IESB
> 
> ... which is set when ARM64_HAS_RAS_EXTN && !ARM64_HAS_IESB.
> 
> Then you can do:
> 
> alternative_if ARM64_HAS_RAS_NOT_IESB
> 	esb
> alternative_else_nop_endif
> 
> See ARM64_ALT_PAN_NOT_UAO for an example.
> 
> That said, as Robin points out we may not even need the alternative.

Ok, got it. thank you very much for your point and opinion


> 
> Thanks,
> Mark.
