From: stanley.miao@windriver.com (stanley.miao)
Date: Fri, 21 Jan 2011 18:11:45 +0800
Subject: [PATCH 1/3] Support BE8 mode kernel modules relocation
In-Reply-To: <20110121094446.GF13235@n2100.arm.linux.org.uk>
References: <1295419487-31185-1-git-send-email-stanley.miao@windriver.com>
	<1295419487-31185-2-git-send-email-stanley.miao@windriver.com>
	<20110121094446.GF13235@n2100.arm.linux.org.uk>
Message-ID: <4D395BE1.2050806@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Jan 19, 2011 at 02:44:45PM +0800, Stanley.Miao wrote:
>   
>> @@ -174,9 +186,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>>  			* other bits to re-code instruction as
>>  			* MOV PC,Rm.
>>  			*/
>> -		       *(u32 *)loc &= 0xf000000f;
>> -		       *(u32 *)loc |= 0x01a0f000;
>> -		       break;
>> +			write_instr32((read_instr32(loc) & 0xf000000f) |
>> +							0x01a0f000, loc);
>> +			break;
>>     
>
> Indentation error.
>
>   
Actually, The indentation of my code is right, and the original code is 
wrong.

Stanley.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110121/aaf41cba/attachment-0001.html>
