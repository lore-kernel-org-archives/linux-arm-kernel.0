From: stigge@antcom.de (Roland Stigge)
Date: Mon, 26 Mar 2012 18:48:23 +0200
Subject: uImage with integrated dtb file
In-Reply-To: <4F7085DA.6030402@wwwdotorg.org>
References: <4F6E5D5B.8050306@antcom.de> <4F7085DA.6030402@wwwdotorg.org>
Message-ID: <4F709DD7.2080606@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/12 17:06, Stephen Warren wrote:
>>  quiet_cmd_uimage = UIMAGE  $@
>> -      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
>> +      cmd_uimage = cat $< arch/arm/boot/*.dtb > $<.tmp ; \
> 
> That won't work well when multiple .dtb files are built.

That's completely correct! Therefore I called it "hack" (maybe
forgetting to prefix it "ugly"), so please don't use it. ;-)

Roland
