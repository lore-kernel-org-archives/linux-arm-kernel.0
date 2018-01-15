From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Jan 2018 08:44:25 +0000
Subject: [PATCH v2 1/3] crypto/generic: sha3 - fixes for alignment and big
 endian operation
In-Reply-To: <cad7b34c-ca50-f856-c3fa-221b4c937d3e@free.fr>
References: <20180114164118.18330-1-ard.biesheuvel@linaro.org>
 <20180114164118.18330-2-ard.biesheuvel@linaro.org>
 <cad7b34c-ca50-f856-c3fa-221b4c937d3e@free.fr>
Message-ID: <CAKv+Gu_-DFR6iORh_Y=_a6+juL9UuaS1+3dvactqy0vkA0pWLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2018 at 05:53, Chris Moore <moore@free.fr> wrote:
> Hi,
>
> Le 14/01/2018 ? 17:41, Ard Biesheuvel a ?crit :
>>
>> Ensure that the input is byte swabbed before injecting it into the
>
>
> Nitpick : s/swabbed/swapped/
>

Thanks Chris - byte swapping is often referred to as swabbing, but I
guess 'byte swabbing' is redundant regardless.

>> SHA3 transform. Use the get_unaligned() accessor for this so that
>> we don't perform unaligned access inadvertently on architectures
>> that do not support that.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
>
> Cheers,
> Chris
>
