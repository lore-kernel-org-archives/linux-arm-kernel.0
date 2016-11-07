From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 7 Nov 2016 02:30:08 +0200
Subject: [PATCH 13/22] mtd: nand: lpc32xx: return error code of
 nand_scan_ident/tail() on error
In-Reply-To: <20161106192743.00e401ec@bbrezillon>
References: <1478256190-7452-1-git-send-email-yamada.masahiro@socionext.com>
 <1478256190-7452-14-git-send-email-yamada.masahiro@socionext.com>
 <20161106192743.00e401ec@bbrezillon>
Message-ID: <c9983167-cedd-3246-ccb8-54aad229e275@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 11/06/2016 08:27 PM, Boris Brezillon wrote:
> On Fri,  4 Nov 2016 19:43:01 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> The nand_scan_ident/tail() returns an appropriate error value when
>> it fails.  Use it instead of the fixed error code -ENXIO.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---

[snip]

>> -	if (nand_scan_tail(mtd)) {
>> -		res = -ENXIO;
>> +	res = nand_scan_tail(mtd);
>
> You miss
>
> 	if (res)
>
> here.
>
> No need to resend, I'll fix it when applying the patches.
>
>>  		goto err_exit3;
>> -	}
>>

nice catch, thank you for noticing and fixing the overlooked bug!

--
With best wishes,
Vladimir
