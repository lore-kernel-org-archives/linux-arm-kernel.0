From: stefan@agner.ch (Stefan Agner)
Date: Mon, 06 Apr 2015 11:33:53 +0200
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <20150406085443.GD12732@n2100.arm.linux.org.uk>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
 <20150403200931.GD13898@n2100.arm.linux.org.uk>
 <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
 <20150405161014.GG13898@n2100.arm.linux.org.uk>
 <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
 <20150405224455.GB12732@n2100.arm.linux.org.uk>
 <58bb3fd4f9e9b3acc7f8b83bd6664177@agner.ch>
 <20150406081523.GC12732@n2100.arm.linux.org.uk>
 <8737db3eea65563054df98c932870590@agner.ch>
 <20150406085443.GD12732@n2100.arm.linux.org.uk>
Message-ID: <f2b85e294afb55fdca85a16e6ad6c13c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-06 10:54, Russell King - ARM Linux wrote:
> On Mon, Apr 06, 2015 at 10:38:10AM +0200, Stefan Agner wrote:
>> We already prevent a kernel image which mixes V4/V4T/V5 and V6/V7. And
>> so we would do with V7M too. Just because it's in multiplatform doesn't
>> mean we need to mix things up.
> 
> I don't think you're getting what I'm saying at all... :(

It's not that I don't get it. I'm just arguing against it.

IMHO, it's wrong to create a parallel universe for v7M multiplatform...

Multiplatform as I understand it is mainly about selecting multiple SoC
_platforms_ but not necessarily multiple CPU platforms. It happens to
work well for V6/V7, but does not for others, and preventing
multiselection for incompatible CPU platforms is the way to prevent
creating such images.

> Please read the first bit of my replies again, where I say that we do
> _not_ want to remove the !MMU dependency from multiplatform.  This is
> something I feel _very_ strongly about, and something which I've written
> about many times on this list.

Ok, I don't have such a strong feel for multiplatform, it just feels a
bit better to me. I need a top level ARCH which is able to live with
!MMU. Will try the ARCH_SINGLE_ARMV7M approach then.

--
Stefan
