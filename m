From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Dec 2014 16:57:53 +0000
Subject: ARM64 Crypto validation
In-Reply-To: <CA+ZZEcXCArW-6Fv9W=mLbEgQ_O2gMAwS1TLijovQPM+KU-3qeg@mail.gmail.com>
References: <CAD6G_RRFU_R6SHvc5C785qtJ1GTt_-HXhn83xXOxc=VAwPjdqQ@mail.gmail.com>
 <CA+ZZEcXCArW-6Fv9W=mLbEgQ_O2gMAwS1TLijovQPM+KU-3qeg@mail.gmail.com>
Message-ID: <CAKv+Gu8RqcEEjCFrnwq4kGcasDunWcZ4PgfE_GSL1aO4MNj9xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 December 2014 at 11:47, Jagannadha Teki <jteki@apm.com> wrote:
> + Yazen Ghannam
> + Herbert Xu
> + Steve Capper
>
> On Tue, Dec 23, 2014 at 3:45 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>> Hi,
>>
>> I need some information to validate arm64/crypto, do we have any
>> exact/defined way to validate this.
>>
>> Here are my findings:
>> 1. I see a dirty test module tcrypto.c where we need to give the sec
>> and mode module params as inputs.
>> 2. Validate through open crypto [1]
>>
>> Do we have any arm64 specific validations, Request for help.
>>
>> [1] http://sourceforge.net/projects/ocf-linux/
>
> thanks!
> --
> Jagan.
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,
> is for the sole use of the intended recipient(s) and contains information
> that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries.
> It is to be used solely for the purpose of furthering the parties' business relationship.
> All unauthorized review, use, disclosure or distribution is prohibited.
> If you are not the intended recipient, please contact the sender by reply e-mail
> and destroy all copies of the original message.
>

Let's forget you sent this email, so you can start over and:
- work on your tone; I find it hard to care about what *you* need if
you don't take the time to introduce yourself, explain what you are
trying to accomplish, for what purpose and how and to which extent
that purpose aligns with that of our community
- think carefully about what validation of a crypto algorithm
implementation means, and whether it makes sense to do it in an arm64
specific way
- familiarize yourself with the way crypto code is checked for
correctness before it gets merged by Herbert (hint: it is related to
the dirty test module)
- assuming that you are working on Xgene, find out which algorithms in
arm64/crypto can even run on that chip, as it does not have the Crypto
Extensions
- get rid of the legalese footer, it has no place on an open source mailing list

Regards,
Ard.
