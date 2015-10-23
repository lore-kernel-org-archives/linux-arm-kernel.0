From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 23 Oct 2015 09:38:48 +0800
Subject: [PATCH] EDAC: Add AMD Seattle SoC EDAC
In-Reply-To: <20151021093536.GA3575@pd.tnic>
References: <1445282597-18999-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151019205236.GB453@leverpostej> <56266F7E.6030404@amd.com>
 <20151020165744.GE31130@pd.tnic> <20151020172654.GC4943@leverpostej>
 <20151020173639.GH31130@pd.tnic> <5626F09F.4050107@huawei.com>
 <20151021093536.GA3575@pd.tnic>
Message-ID: <56298FA8.2000406@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/21 17:35, Borislav Petkov wrote:
> On Wed, Oct 21, 2015 at 09:55:43AM +0800, Hanjun Guo wrote:
>> So I think the meaning of those error register is the same, but the way
>> of handle it may different from SoCs, for single bit error:
>>
>>  - SoC may trigger a interrupt;
>>  - SoC may just keep silent so we need to scan the registers using poll
>>    mechanism.
>>
>> For Double bit error:
>>   - SoC may also keep silent
>>   - Trigger a interrupt
>>   - Trigger a SEI (system error)
>>
>> Any suggestion to cover those cases?
> Well, I guess we can implement all those and have them configurable
> in the sense that a single driver loads, it has all functionality and
> dependent on the vendor detection, it does only what the vendor wants
> like trigger an interrupt or remain silent or ...

Hmm, so we need to keep the DT bindings for different SoCs which
have different ways of handling the errors.

Thanks
Hanjun
