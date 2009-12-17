From: roel.kluin@gmail.com (roel kluin)
Date: Thu, 17 Dec 2009 22:20:18 +0100
Subject: [PATCH] ARM: Wrong size used in dump_mem()
In-Reply-To: <20091217211759.GB16520@n2100.arm.linux.org.uk>
References: <4B2A9F8E.5080508@gmail.com>
	<20091217211759.GB16520@n2100.arm.linux.org.uk>
Message-ID: <25e057c00912171320m3c596ecancafc568cedfd70b8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 10:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 17, 2009 at 10:15:58PM +0100, Roel Kluin wrote:
>> The sizeof the pointed to should be used rather than of the pointer
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>> ---
>> Unless I am mistaken?
>
> You are mistaken. ?sizeof(array) is the byte size of the array.
> sizeof(*array) is the size of one individual object of the array.
>
> The code is correct as is - which is to fill ?the entire array with
> space characters and then zero the last one.

hmm, I see. sorry for the noise
