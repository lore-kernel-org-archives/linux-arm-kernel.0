From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 31 Jan 2013 13:48:47 -0800
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <alpine.LFD.2.02.1301301326530.6300@xanadu.home>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130128142510.68092e10.akpm@linux-foundation.org>
 <20130129101549.GP23505@n2100.arm.linux.org.uk> <51089523.3080804@zytor.com>
 <alpine.LFD.2.02.1301301326530.6300@xanadu.home>
Message-ID: <510AE6BF.4080303@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 10:33 AM, Nicolas Pitre wrote:
>>
>> The only concern I have with that is if someone paints themselves into a
>> corner and absolutely wants, say, LZO.
> 
> That would be hard to justify given that the kernel provides its own 
> decompressor code, making the compression format transparent to 
> bootloaders, etc.  And no one should be poking into the compressed 
> zImage.
> 

Some utterly weird things like the Xen domain builder do that, because
they have to.  That is why we explicitly document that the payload is
ELF and how to access it in the bzImage spec.

	-hpa
