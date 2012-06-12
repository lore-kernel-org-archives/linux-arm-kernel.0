From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 12 Jun 2012 10:48:02 -0700
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <alpine.LFD.2.02.1206121336060.23555@xanadu.home>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <20120612191804.4211462a@tukaani.org>
 <alpine.LFD.2.02.1206121316190.23555@xanadu.home>
 <4FD77CAF.1020402@zytor.com>
 <alpine.LFD.2.02.1206121336060.23555@xanadu.home>
Message-ID: <4FD780D2.603@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 10:44 AM, Nicolas Pitre wrote:
> On Tue, 12 Jun 2012, H. Peter Anvin wrote:
> 
>> On 06/12/2012 10:26 AM, Nicolas Pitre wrote:
>>>
>>> Instead of copying, maybe this would be much better to make the content 
>>> of lib/string.c usable in a pre-boot environment.
>>>
>>
>> Not sure about that... a lot of it is #ifndef __HAVE_ARCH_* and you
>> *really* want those optimizations on some arches.
> 
> Sure.  What about:
> 
> lib/boot/mem.c: lib/string.c
> 	sed 's/^#ifndef __HAVE_ARCH_/#ifndef __HAVE_PREBOOT_ARCH_/' < $< > $@
> 
> This is over simplified but you get the idea.  Maybe lib/string.c itself 
> should be split into several files to help with a finer grained 
> selection.
> 

The point is that I think we pretty much end up with a null usable set
in the end.

	-hpa
