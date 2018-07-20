From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 20 Jul 2018 17:55:44 +0300
Subject: [PATCH v6 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
In-Reply-To: <8d2fd280-9cd7-f612-b663-ec4bcdd129cb@baylibre.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-7-georgi.djakov@linaro.org>
 <8d2fd280-9cd7-f612-b663-ec4bcdd129cb@baylibre.com>
Message-ID: <3f8fa550-f789-ac04-9d9a-186d596c98f7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 07/11/2018 06:42 PM, Alexandre Bailon wrote:
> On 07/09/2018 05:51 PM, Georgi Djakov wrote:
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig        |   5 +
>>  drivers/interconnect/Makefile       |   1 +
>>  drivers/interconnect/qcom/Kconfig   |  10 +
>>  drivers/interconnect/qcom/Makefile  |   2 +
>>  drivers/interconnect/qcom/msm8916.c | 499 ++++++++++++++++++++++++++++
>>  5 files changed, 517 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/msm8916>>

[..]

>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +			u32 avg, u32 peak)
>> +{
>> +	struct qcom_icc_provider *qp;
>> +	struct qcom_icc_node *qn;
>> +	struct icc_node *node;
>> +	struct icc_provider *provider;
>> +	u64 avg_bw = icc_units_to_bps(avg);
>> +	u64 peak_bw = icc_units_to_bps(peak);
>> +	u64 rate = 0;
>> +	int ret = 0;
>> +
>> +	if (!src)
> NIT: I think that src can't be NULL (there is a if statement to avoid it
> in apply_constraints()).

Yes, true!

Thanks,
Georgi
