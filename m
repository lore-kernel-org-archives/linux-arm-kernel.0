From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 16 Jul 2015 11:23:08 -0700
Subject: [PATCH v4 0/2] arm/arm64: KVM: Optimize arm64 fp/simd,
 saves 30-50% on exits for non-VHE
In-Reply-To: <20150716155253.GU7845@cbox>
References: <1436577547-5646-1-git-send-email-m.smarduch@samsung.com>
 <20150716155253.GU7845@cbox>
Message-ID: <55A7F68C.6020903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 08:52 AM, Christoffer Dall wrote:
> On Fri, Jul 10, 2015 at 06:19:05PM -0700, Mario Smarduch wrote:
>> This is a followp to previous iteration but implemented on top of VHE patches. 
>> Only non-VHE path is addressied by this patch. In second patch 32-bit handler 
>> is updated to keep exit handling consistent with 64-bit code, and nothing
>> has changed.
>>
> Why not simply preserve this the way it was in v3 and have it merged
> first - after all we have reviewed it and I thought it was more or less
> ready to be merged - I suspect the VHE patches may have a way to go
> still ?

Definitely, that's a better path. After looking at VHE patches,
I would probably leave V3 the way it is (keeping deactivate_xxxx:
symmetric). Marc has Reviewed V3 and you commented either way was
fine with you, so V3 should be ok.

Jumping on VHE is little too much at this time, thanks for the
alternative I kind of got myself into a jam here.

- Mario

> 
> -Christoffer
> 
