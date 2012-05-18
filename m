From: stigge@antcom.de (Roland Stigge)
Date: Fri, 18 May 2012 11:12:18 +0200
Subject: [PATCH RESEND v3 1/2] input: keyboard: Add keys driver for the
 LPC32xx SoC
In-Reply-To: <20120517173814.GA26948@core.coreip.homeip.net>
References: <1337199955-26441-1-git-send-email-stigge@antcom.de>
 <20120517173814.GA26948@core.coreip.homeip.net>
Message-ID: <4FB61272.5080700@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry!

thanks for your suggestions, will include them into the next patch update.

On 05/17/2012 07:38 PM, Dmitry Torokhov wrote:
>> +	of_property_read_u32(np, "keypad,num-rows", &rows);
>> +	of_property_read_u32(np, "keypad,num-columns", &columns);
>> +	if (!rows || rows != columns) {
>> +		dev_err(dev, "rows and columns must be specified and be equal!\n");
> 
> Why?

The LPC32xx key scanner hardware is always configured with a square
matrix (rows == columns). So I had the choice to force "keypad,num-rows"
== "keypad,num-columns" (as done currently) to show potential error to
the DTS/DTB provider, or ignore problems here and use
max("keypad,num-rows", "keypad,num-columns") for actual hardware setup.

(You can and will leave out unconnected keys in the keymap anyway.)

So do you think we should change my current approach here?

Thanks in advance,

Roland
