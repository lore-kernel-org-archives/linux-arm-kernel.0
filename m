From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Feb 2014 11:11:21 +0100
Subject: [RFC PATCH] arm64: add support for AES in CCM mode using Crypto
 Extensions
In-Reply-To: <20140225090835.GA11135@gondor.apana.org.au>
References: <1392106905-28709-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140225070252.GB9934@gondor.apana.org.au>
 <CAKv+Gu-HnTk5RCLRoCnae7-HH7C-Tq2YJF57Nc-hOEykdY52XA@mail.gmail.com>
 <20140225071626.GA10524@gondor.apana.org.au>
 <CAKv+Gu_A_04P=nOoPfxhJMC3bbEPTcpgZO0Ldw2H4BV7T_gTbw@mail.gmail.com>
 <20140225090835.GA11135@gondor.apana.org.au>
Message-ID: <CAKv+Gu97c46dxQK2vhbHUgD8i7x3OA5BhXbS=AdobB8_2ViTEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2014 10:08, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Feb 25, 2014 at 08:21:22AM +0100, Ard Biesheuvel wrote:
>>
>> For the authenticate-only data, this is manageable as you are only
>> dealing with input, but when dealing with both in- and output, as in
>> the core of CCM, it becomes very tedious.
>> So instead, I have opted for an inner blkcipher instance which takes
>> care of all of that. Could you suggest another approach that if
>> preferable?
>
> I don't think the walk helper actually needs the tfm apart from
> getting a couple of parameters out of it, so perhaps we can just
> change the helper to not depend on a tfm.
>

That seems like a less hacky approach.

I'll cook something up and put it on the list.

Cheers,
Ard.
