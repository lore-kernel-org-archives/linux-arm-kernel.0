From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 17 Feb 2011 13:58:24 -0800
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <20110217100126.GD22961@pulham.picochip.com>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>	<1297872716-13353-2-git-send-email-john.linn@xilinx.com>	<1297872716-13353-3-git-send-email-john.linn@xilinx.com>	<e58673f5-2881-4820-b5cd-99e8ef294ed5@VA3EHSMHS024.ehs.local>
	<20110217100126.GD22961@pulham.picochip.com>
Message-ID: <4D5D9A00.7060609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2011 02:01 AM, Jamie Iles wrote:
>> +
>> +static void putc(char ch)
>> +{
>> +	/*
>> +	 * Wait for room in the FIFO, then write the char into the FIFO
>> +	 */
>> +	while (UART_STATUS(LL_UART_PADDR) & UART_SR_TXFULL)
>> +		;
>
> It might be worth adding a barrier() call to these loops to be explicit 
> about the volatility.

I think you want cpu_relax() then.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
