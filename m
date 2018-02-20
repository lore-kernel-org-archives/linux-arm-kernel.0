From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 20 Feb 2018 09:33:39 +0000
Subject: [PATCH v3 02/25] soc: qcom: add support to APR bus driver
In-Reply-To: <20180219030819.qovj4swuvged6c24@rob-hp-laptop>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-3-srinivas.kandagatla@linaro.org>
 <20180219030819.qovj4swuvged6c24@rob-hp-laptop>
Message-ID: <6be00df2-de80-0d40-9603-8b0fd94efa41@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for review comments,

On 19/02/18 03:08, Rob Herring wrote:
> On Tue, Feb 13, 2018 at 04:58:14PM +0000,srinivas.kandagatla at linaro.org  wrote:
>> From: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>>
>> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
>> ARP driver is made as a bus driver so that the apr devices can added removed
>> more dynamically depending on the state of the services on the dsp.
>> APR is used for communication between application processor and QDSP to
>> use services on QDSP like Audio and others.
>>
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soc/qcom/Kconfig           |   9 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/apr.c             | 381 +++++++++++++++++++++++++++++++++++++
>>   include/dt-bindings/soc/qcom,apr.h |  27 +++
> This belongs in the binding patch.
> 
I agree, will fix it in next version.
>>   include/linux/mod_devicetable.h    |  11 ++
>>   include/linux/soc/qcom/apr.h       | 131 +++++++++++++
>>   6 files changed, 560 insertions(+)
>>   create mode 100644 drivers/soc/qcom/apr.c
>>   create mode 100644 include/dt-bindings/soc/qcom,apr.h
>>   create mode 100644 include/linux/soc/qcom/apr.h
> 
>> diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
>> new file mode 100644
>> index 000000000000..fb162ac4ca0e
>> --- /dev/null
>> +++ b/include/dt-bindings/soc/qcom,apr.h
>> @@ -0,0 +1,27 @@
> SPDX tag

Thanks for reminding this.. Will fix it in next spin.

> 
