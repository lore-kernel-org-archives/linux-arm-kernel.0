From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 12 Mar 2018 20:13:11 +0800
Subject: [RFC PATCH 0/4] add support for CommonLPIAff field
In-Reply-To: <3b6997c9-761f-3f5e-79ac-6b785a9a14d9@arm.com>
References: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
 <3b6997c9-761f-3f5e-79ac-6b785a9a14d9@arm.com>
Message-ID: <5AA66ED7.7080007@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/3/12 17:55, Marc Zyngier wrote:
> On 12/03/18 06:49, Yang Yingliang wrote:
>> This patch set adjust struct rdists to support CommonLPIAff field.
>> This field is described in spec:
>>
>> CommonLPIAff, bits [25:24]
>> The affinity level at which Redistributors share a LPI Configuration table.
>> 00 All Redistributors must share a LPI Configuration table.
>> 01 All Redistributors with the same Aff3 value must share an LPI Configurationt table.
>> 10 All Redistributors with the same Aff3.Aff2 value must share an LPI Configuration table.
>> 11 All Redistributors with the same Aff3.Aff2.Aff1 value must share an LPI Configuration
>> table.
>
> What are you trying to achieve here? We already share the same
> configuration table across all the redistributors, irrelevant the of
> CommonLPIAff. Why would we need to do anything else?

In some cases, such as "with the same Aff3.Aff2 value must share an LPI
Configuration table", redistributors will access local memory node
only, it may improve the performance. And I don't have any beneficial
data now. I may provide it later.

Regards,
Yang
>
> Thanks,
>
> 	M.
>
