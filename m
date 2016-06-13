From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 13 Jun 2016 17:45:18 +0800
Subject: [v1,4/4] drm/rockchip: cdn-dp: add cdn DP support for rk3399
In-Reply-To: <20160608221354.GA25675@roeck-us.net>
References: <1464966911-18949-5-git-send-email-zyw@rock-chips.com>
 <20160608221354.GA25675@roeck-us.net>
Message-ID: <575E80AE.2050809@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter

Thanks for your comments

On 06/09/2016 06:13 AM, Guenter Roeck wrote:
>> +	if (ret < 0) {
>> >+		dev_err(dp->dev, "failed to request firmware %d\n", ret);
>> >+		return ret;
>> >+	}
>> >+
>> >+	hdr = (struct cdn_firmware_header *)fw->data;
>> >+	if (fw->size != le32_to_cpu(hdr->size_bytes))
>> >+		return -EINVAL;
>> >+
>> >+	ret = cdn_dp_clk_enable(dp);
>> >+	if (ret < 0) {
>> >+		dev_err(dp->dev, "cannot enable dp clk %d\n", ret);
>> >+		return ret;
>> >+	}
>> >+
>> >+	dp_clock_reset_seq(dp);
>> >+
>> >+	iram_data = (const u32 *)(fw->data + hdr->header_size);
>> >+	dram_data = (const u32 *)(fw->data + hdr->header_size + hdr->iram_size);
> No need for endianness conversion here ?
>
The firmware does need for endianness conversio.
And for the other comments, I have done them, v2 has been posted.
