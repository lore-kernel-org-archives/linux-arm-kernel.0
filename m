From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Sat, 10 Oct 2009 09:41:08 +0100
Subject: [PATCH 4/6] ARM: remove references to non-existent fastfpe
In-Reply-To: <20091009165513.GA5902@n2100.arm.linux.org.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
	<1255096942-10451-4-git-send-email-alan-jenkins@tuffmail.co.uk>
	<20091009165513.GA5902@n2100.arm.linux.org.uk>
Message-ID: <4AD048A4.1070805@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Oct 09, 2009 at 03:02:20PM +0100, Alan Jenkins wrote:
>   
>> 	# Do we have FASTFPE?
>> 	FASTFPE		:=arch/arm/fastfpe
>> 	ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
>> 	FASTFPE_OBJ	:=$(FASTFPE)/
>> 	endif
>> 	fastfpe
>>
>> We don't have FASTFPE.  If this code still exists out of tree, it can
>> surely maintain its own Makefile and Kconfig entries.  Let's not confuse
>> users by allowing them to select FASTFPE, and then silently not building
>> it.
>>     
>
> The code is not maintained anymore, but can just be slotted in (as per
> the recent request on the mailing list.)  I'd rather not have the
> hastle of maintaining fastfpe patches thank you.
>   

Urk. The fine balancing act of limbo. Another possibility would be to 
provide a stub

#error "fastfpe not included; disable it or download it"

But if you want to just leave it, that's obviously your decision to make.

Regards
Alan
