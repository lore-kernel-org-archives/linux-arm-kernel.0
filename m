From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Nov 2015 09:04:33 +0100
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <56534212.3000302@redhat.com>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
 <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
 <5653387A.2000101@redhat.com> <565340C9.7010605@labbott.name>
 <56534212.3000302@redhat.com>
Message-ID: <CAKv+Gu8zDVreg4FmxE+069n-RGT7j4mfWN7LcH9vcgw9HTE62w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2015 at 17:42, Jeremy Linton <jlinton@redhat.com> wrote:
> On 11/23/2015 10:37 AM, Laura Abbott wrote:
>>
>> Which permissions still need to be cleaned up from your perspective?
>
>
> IMHO, the vast majority of the linear map should not be
> executable/read/write, which is what happens today.
>

IMHO, this should not be hidden under DEBUG_RODATA (which some people
may mistake for a debug option, while others may assume it affects
rodata only) since the kernel stacks are executable without it.
