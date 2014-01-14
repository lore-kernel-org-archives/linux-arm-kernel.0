From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jan 2014 09:19:18 -0800
Subject: AArch64 kernel image decompression
In-Reply-To: <20140114134732.F0A1C3821F2@gemini.denx.de>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <69dfcb9d142443638e4ccfedd92c4f05@BN1PR03MB220.namprd03.prod.outlook.com>
 <4250104.UfkPP3heXI@wuerfel> <201401141351.18988.marex@denx.de>
 <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140114134732.F0A1C3821F2@gemini.denx.de>
Message-ID: <CAOesGMj0HPWD=Mavt1ut+Oze4KQZHjhHmcKTcdKELaF=Or8XsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 5:47 AM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Bhupesh,
>
> In message <819346bb83b04348a266643afd5bd6f6@BN1PR03MB220.namprd03.prod.outlook.com> you wrote:
>>
>> I agree with Marek. Usually for non-cryptographic-secure (key based cryptography) boot
>> method the CRC protection is usually the best possible protection against Image
>> corruption. CRC check is usually used in a number of field-deployed solutions to ensure
>> linux image sanity.
>
> The FIT image approach as suggested by Marek also allows for secure
> boot methods (like cryptographically signed images); this is used in
> production for several systems, including the Google Chromebook.

This can very easily be misunderstood so I would like to clarify:
Chromebooks do not use the fitImage version of signatures and
verification, it is done independently from a separate library that
wraps either a zImage (x86) or a fitImage (ARM).


-Olof
