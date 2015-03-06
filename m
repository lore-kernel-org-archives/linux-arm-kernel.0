From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 6 Mar 2015 04:31:40 -0000
Subject: [PATCH 0/6] Add support for QCOM GDSCs
In-Reply-To: <54F88A8C.4080100@mm-sol.com>
References: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
 <54F88A8C.4080100@mm-sol.com>
Message-ID: <4e73dedd220f1079148b4b3b7a5aabdc.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 03/02/2015 09:02 AM, Rajendra Nayak wrote:
>> GDSCs (Global Distributed Switch Controllers) control switches
>> that supply power to an on-chip power domain and hence can be
>> programmed in SW to safely power collapse and restore power to the
>> respective PDs. They are part of a considerable number of recent QCOM
>> SoCs (This series adds support for msm8974, msm8916 and apq8084 devices)
>> and are part of the Clock control block.
>>
>> The series implements support for GDSC using the genpd framework
>> modelling these as SW controllable power domains.
>>
>> 8916 support has a dependency on the Global Clock controller support [1]
>> posted by Georgi Djakov.
>>
>> [1]
>> https://lkml.org/lkml/2015/2/25/416
>>
>> Rajendra Nayak (3):
>>   clk: qcom: gdsc: Prepare common clk probe to register gdscs
>>   clk: qcom: gdsc: Add GDSCs in msm8916 GCC
>>   clk: qcom: gdsc: Add GDSCs in apq8084 GCC
>>
>> Stephen Boyd (3):
>>   clk: qcom: Add support for GDSCs
>>   clk: qcom: gdsc: Add GDSCs in msm8974 GCC
>>   clk: qcom: gdsc: Add GDSCs in msm8974 MMCC
>>
>>  drivers/clk/qcom/Kconfig                      |   8 ++
>>  drivers/clk/qcom/Makefile                     |   1 +
>>  drivers/clk/qcom/common.c                     |  27 +++++-
>>  drivers/clk/qcom/common.h                     |   2 +
>>  drivers/clk/qcom/gcc-apq8084.c                |  38 ++++++++
>>  drivers/clk/qcom/gcc-msm8916.c                |  46 +++++++++
>>  drivers/clk/qcom/gcc-msm8974.c                |  14 +++
>>  drivers/clk/qcom/gdsc.c                       | 130
>> ++++++++++++++++++++++++++
>>  drivers/clk/qcom/gdsc.h                       |  43 +++++++++
>>  drivers/clk/qcom/mmcc-msm8974.c               |  54 +++++++++++
>>  include/dt-bindings/clock/qcom,gcc-apq8084.h  |   6 ++
>>  include/dt-bindings/clock/qcom,gcc-msm8916.h  |   8 ++
>>  include/dt-bindings/clock/qcom,gcc-msm8974.h  |   3 +
>>  include/dt-bindings/clock/qcom,mmcc-msm8974.h |   8 ++
>>  14 files changed, 387 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/qcom/gdsc.c
>>  create mode 100644 drivers/clk/qcom/gdsc.h
>>
>
> You missed a patch who adds appropriate changes in qcom,gcc.txt
> (qcom,mmcc.txt), at least #power-domain-cells property should be
> described.

Right, I also missed adding those in the dts files (for 8974 and 8084)
which caused failures which I caught after I posted these out.
Thanks for taking time to review, I will fix #power-domain-cells and also
address other concerns you had on PATCH 1/6 and 2/6 and post a v2 soon.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
