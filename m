From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 22 Dec 2015 16:13:18 +0200
Subject: [PATCH v2 2/2] ARM: dts: imx7d: sbc-imx7: add basic board support
In-Reply-To: <20151222121920.GC26290@tiger>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
 <1450772120-18131-1-git-send-email-ilya@compulab.co.il>
 <1450772120-18131-3-git-send-email-ilya@compulab.co.il>
 <20151222121920.GC26290@tiger>
Message-ID: <56795A7E.2000100@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/15 14:19, Shawn Guo wrote:
> On Tue, Dec 22, 2015 at 10:15:20AM +0200, Ilya Ledvich wrote:

[...]

>> +&iomuxc {
>> +	cl-som-imx7 {
> 
> This container should be dropped too.  Please check my imx/dt branch for
> the fixup I made.

Ahhh... Sorry, we've messed this up...
While removing the redundant container from the other patch,
this one was forgotten...
Sorry about this. Will pay more attention next time.

I've checked out your imx/dt branch and both patches look good.
Thanks for fixing this for us!

> 
> Shawn
> 
>> +		pinctrl_usdhc1: usdhc1grp {
>> +			fsl,pins = <
>> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
>> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
>> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
>> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
>> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
>> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
>> +				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
>> +				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
>> +			>;
>> +		};
>> +	};
>> +};
>> -- 
>> 1.9.1
>>
>>
> 

-- 
Regards,
Igor.
