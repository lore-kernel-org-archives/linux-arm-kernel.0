From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 12 Jun 2012 10:30:23 -0700
Subject: [PATCH v2] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <alpine.LFD.2.02.1206121316190.23555@xanadu.home>
References: <1339470307-28223-1-git-send-email-tmac@hp.com>
 <20120612191804.4211462a@tukaani.org>
 <alpine.LFD.2.02.1206121316190.23555@xanadu.home>
Message-ID: <4FD77CAF.1020402@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 10:26 AM, Nicolas Pitre wrote:
> 
> Instead of copying, maybe this would be much better to make the content 
> of lib/string.c usable in a pre-boot environment.
> 

Not sure about that... a lot of it is #ifndef __HAVE_ARCH_* and you
*really* want those optimizations on some arches.

	-hpa
