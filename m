From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 6 Jan 2017 10:44:31 -0500
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <ac275374-2aa6-43ec-25c9-6a3fec4ceedc@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
 <ac275374-2aa6-43ec-25c9-6a3fec4ceedc@codeaurora.org>
Message-ID: <54ceb523-47ea-f137-293f-0da0166bb14b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2016 06:08 PM, Timur Tabi wrote:
> On 12/29/2016 04:43 PM, Christopher Covington wrote:
>> +config QCOM_FALKOR_E1003_RESERVED_ASID
>> +    int
>> +    default 1
>> +    depends on QCOM_FALKOR_ERRATUM_1003
> 
> Also, since this can't be changed via the menu, why bother putting it in?

I put it in in response to review comments asking for the magic number to
be clarified by a #define or variable. I could not find a suitably shared
header between the files in question, so I used the Kconfig machinery to
generate the #define.

Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
