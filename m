From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 16 Jun 2011 20:16:04 +0200
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <Pine.LNX.4.44L0.1106161308310.2204-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1106161308310.2204-100000@iolanthe.rowland.org>
Message-ID: <4DFA4864.2030900@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.06.2011 19:09, schrieb Alan Stern:
> On Thu, 16 Jun 2011, Alexander Holler wrote:
>
>> In commit 139540170d9d9b7ead3caaf540f161756b356d56 the attribute
>> packed is removed from the structs which are used to access the EHCI-registers.
>>
>> This is done to circumvent a problem with gcc 4.6, which might access members of
>> packed structs on a byte by byte basis. But using packed, aligned(4) fixes that
>> too and is imho the better solution. Otherwise (without packed) the compiler would be free
>> to choose whatever alignment he thinks fits best, which might be e.g. 8-byte on 64-bit machines.
>
> Is that really true?  I thought the compiler was not allowed to insert
> padding if the natural alignment of the data types didn't require any.
>
> Alan Stern

I wasn't sure and have searched c99 before posting the patch but I 
haven't found something which states what you are suggesting. Maybe I 
was too stupid to find it, I've searched for the words "alignment" and 
"padding".

The only statement I've found was

"There may be unnamed padding within a structure object, but not at its 
beginning."

in 6.7.2.1 13 and

"There may be unnamed padding at the end of a structure or union."

in 6.7.2.1. 15 in my copy of c99.

Regards,

Alexander
