From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Thu, 7 Aug 2014 10:01:05 +0000
Subject: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <c9727eaf22dc40f796793c6b127dfb9e@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
 <14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
 <31f8f5504fc24d999f5af74338602bed@BLUPR03MB373.namprd03.prod.outlook.com>
 <c9727eaf22dc40f796793c6b127dfb9e@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <6537011f698c4c7faaf5b66b870afbd2@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao-B46683 Data: Thursday, August 07, 2014 4:05 PM
>To: Duan Fugang-B38611; wsa at the-dreams.de; marex at denx.de
>Cc: LW at KARO-electronics.de; mark.rutland at arm.com; shawn.guo at linaro.org;
>linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>i2c at vger.kernel.org; Li Frank-B20596
>Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c
>driver
>
>Hi Fugang,
>
>> >> >+	/* Waiting for Transfer complete. */
>> >> >+	while (timeout--) {
>> >> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>> >> >+		if (temp & I2SR_ICF)
>> >> >+			break;
>> >> >+		udelay(10);
>> >> >+	}
>> >> Whether there have better method like interrupt to avoid dead wait
>> >> here until timeout ?
>> >
>> >Can you give me more suggestion? We have discussed it with our team,
>> >It seems the short query wait is necessary.
>> >
>> At least, you can use schdule_timeout() instead of udelay() ?
>
>In fact, the waiting time normally is less than 10-50us, but the minimum
>time interval for schdule_timeout() is 1 jiffies.
>So maybe schdule_timeout() is not very necessary?
>
Oh, if the waiting time is 10 ~ 50us, you can use usleep_range(10, 50).
