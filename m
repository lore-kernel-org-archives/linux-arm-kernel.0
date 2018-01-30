From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 30 Jan 2018 19:39:49 +0530
Subject: [PATCH v2 1/2] drm/bridge/synopsys: dsi: Add a warning msg on dsi
 read requests
In-Reply-To: <20180126004441.k4pymmsr6brcdzmq@ban.mtv.corp.google.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
 <20180125103800.1999-2-philippe.cornu@st.com>
 <20180126004441.k4pymmsr6brcdzmq@ban.mtv.corp.google.com>
Message-ID: <18888350-d764-f6bd-5285-a7fac3d300e0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/26/2018 06:14 AM, Brian Norris wrote:
> On Thu, Jan 25, 2018 at 11:37:59AM +0100, Philippe Cornu wrote:
>> The dcs/generic dsi read feature is not yet implemented so it
>> is important to warn the host_transfer() caller in case of
>> read operation requests.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Awesome, thanks.
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 

Queued to drm-misc-next.

Thanks,
Archit

>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index daec7881be6d..72ecaeb40822 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -405,6 +405,12 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   	struct mipi_dsi_packet packet;
>>   	int ret;
>>   
>> +	if (msg->rx_buf || msg->rx_len) {
>> +		/* TODO dw drv improvements: implement read feature */
>> +		dev_warn(dsi->dev, "read operations not yet implemented\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	ret = mipi_dsi_create_packet(&packet, msg);
>>   	if (ret) {
>>   		dev_err(dsi->dev, "failed to create packet: %d\n", ret);
>> -- 
>> 2.15.1
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
