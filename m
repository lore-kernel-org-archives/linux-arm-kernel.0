From: green@linuxhacker.ru (Oleg Drokin)
Date: Thu, 12 May 2011 23:52:08 -0400
Subject: [PATCH 1/2] Initial B&N Nook Color (encore) support.
In-Reply-To: <4DC791C9.9040709@compulab.co.il>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru>
	<1304891407-29364-2-git-send-email-green@linuxhacker.ru>
	<4DC791C9.9040709@compulab.co.il>
Message-ID: <8D96E746-8C8F-44B1-9AFE-8A71F8AF082D@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On May 9, 2011, at 3:03 AM, Igor Grinberg wrote:

>> Bare-bones board file, comes with serial console, gpio keys,
>> MMC/SDCard and USB support.
>> 
>> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>> ---
> 
> In general, here you should write the version history of your patch...

umm, ok.
Do you think the history of the changes is important in this case, though?
I mean it's mostly the case of "kill unneeded includes, fix style, fix incorrect mux package type" and so on.
Nothing of real interest to anybody.

>> +static void __init omap_encore_init(void)
>> +{
>> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> 
> You select CBP package in Kconfig, but pass CBB here?

Ah, indeed, thanks for catching this.

>> -nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
>> +encore			MACH_ENCORE		ENCORE			3284
>> hkdkc100		MACH_HKDKC100		HKDKC100		3285
>> ts42xx			MACH_TS42XX		TS42XX			3286
>> aebl			MACH_AEBL		AEBL			3287
> 
> You should contact Russell for this kind of stuff.

Yes, I already did.
I am carrying it as part of the patch so that it's actually buildable while
awaiting for the decision.

> I don't think you should be patching it directly...
> If you want to tell us that your patch should be applied with this
> change to mach-types, then it would be better to make a separate
> patch for it and describe it in your cover letter.

Hm, ok.

Thanks for the feedback.

Bye,
    Oleg
