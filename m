From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 7 Feb 2018 12:38:50 +0000
Subject: [PATCH v5 03/16] media: rkisp1: Add user space ABI definitions
In-Reply-To: <5b29d890-8c6b-18ff-ade1-1923c25143a0@xs4all.nl>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
 <5b29d890-8c6b-18ff-ade1-1923c25143a0@xs4all.nl>
Message-ID: <d29bc615-2359-86c6-db5a-27cc111bc275@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/18 13:14, Hans Verkuil wrote:
[...]
> The one thing that I worry about is if these structs are the same for
> 32 and 64 bit arm.

I see some enums and bools in there - in general the storage size of 
those isn't even guaranteed to be consistent between different compiler 
implementations on the same platform, let alone across multiple 
platforms (especially WRT things like GCC's -fshort-enums).

In practice, under the standard ABIs for 32-bit and 64-bit Arm[1], I'd 
expect basic types other than longs and pointers to be pretty much the 
same; it's the imp-def C stuff I'd be a lot less confident about.

Robin.

[1]:http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
