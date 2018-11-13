From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Tue, 13 Nov 2018 10:36:49 +0000
Subject: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
In-Reply-To: <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-8-vincenzo.frascino@arm.com>
 <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
Message-ID: <a9726884-70e5-bff4-555d-cd870a5bd6db@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

thank you for your review.

On 09/11/2018 18:09, Peter Collingbourne wrote:
> On Fri, Nov 9, 2018 at 4:38 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> -ccflags-y := -shared -fno-common -fno-builtin
>> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
> 
> This either needs to include -ffixed-x18 or
> https://patchwork.kernel.org/patch/10671685/ needs to appear earlier
> in this series.
> 

I did not add -ffixed-x18 to my flags because I was planning to cherry-pick your patch. It will be in v2.

> Peter
> 

-- 
Regards,
Vincenzo
