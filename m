From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Sun, 1 Jul 2018 14:16:05 +0300
Subject: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
In-Reply-To: <CAE=gft7+S7MJHB2jw8SNewNcr2OvK+1a-PdJdcaonTphJX7c8A@mail.gmail.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-5-georgi.djakov@linaro.org>
 <CAE=gft7+S7MJHB2jw8SNewNcr2OvK+1a-PdJdcaonTphJX7c8A@mail.gmail.com>
Message-ID: <0b0f1afb-b356-f922-4685-6f0a5c86e0ec@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Evan,

On 06/26/2018 11:47 PM, Evan Green wrote:
> Hi Georgi,
> 
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> On some Qualcomm SoCs, there is a remote processor, which controls some of
>> the Network-On-Chip interconnect resources. Other CPUs express their needs
>> by communicating with this processor. Add a driver to handle comminication
>> with this remote processor.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---

[..]

>> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
>> new file mode 100644
>> index 000000000000..2a0c41db91c4
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-y += smd-rpm.o
> 
> This new file has an unexpressed dependency on CONFIG_QCOM_SMD_RPM due
> to qcom_rpm_smd_write. RPMh-based systems won't need this file, right?
> Maybe this file should live behind some config?

Right, I just made this a separate config, as the the kbuild bot also
reported an issue with the modular build.

[..]

>> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
>> new file mode 100644
>> index 000000000000..0f4a3da31cf6
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/smd-rpm.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __LINUX_INTERCONNECT_QCOM_RPM_H
>> +#define __LINUX_INTERCONNECT_QCOM_RPM_H
> 
> This doesn't really reflect the path, should this be something different?

Will update!

Thanks,
Georgi
