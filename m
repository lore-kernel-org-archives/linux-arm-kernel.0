From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 24 Jul 2013 16:06:58 +0100
Subject: [PATCH 06/14] ARM: twd: data endian fix
In-Reply-To: <20130724144923.GO11072@mudshark.cambridge.arm.com>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-7-git-send-email-ben.dooks@codethink.co.uk>
 <20130724144923.GO11072@mudshark.cambridge.arm.com>
Message-ID: <51EFED92.2050408@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 15:49, Will Deacon wrote:
> On Wed, Jul 24, 2013 at 11:27:54AM +0100, Ben Dooks wrote:
>> Ensure the twd driver uses the correct calls to access the hardware
>> to ensure that we do not end up with data in the wrong endian format.
>>
>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>
> Reviewed-by: Will Deacon<will.deacon@arm.com>
>
> There are a bunch of other __raw_* users under arch/arm/, but I suppose we
> can let other people move those over as they see fit. It wouldn't hurt to
> fix arch/arm/include/asm/{cti,hardware/coresight.h} though.

I didn't think to look for things under there.

Do people think it would be worth just changing __raw_read/__raw_write
functions to also take into account endian-ness?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
