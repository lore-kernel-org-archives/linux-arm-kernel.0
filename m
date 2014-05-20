From: aeikum@codeweavers.com (Andrew Eikum)
Date: Tue, 20 May 2014 14:29:58 -0500
Subject: [alsa-devel] [PATCH] Fix for possible null pointer dereference
 in dma.c
In-Reply-To: <537BAA2B.9090906@gmail.com>
References: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <5379E284.7030700@gmail.com>
 <CAFo99gZ3kVGn04we5OtRtbkceYRs6SiHXRyoX1Gb-SknJH=z=w@mail.gmail.com>
 <537BAA2B.9090906@gmail.com>
Message-ID: <20140520192958.GE6639@foghorn.codeweavers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 09:16:59PM +0200, Tomasz Figa wrote:
> To me having NULL as either data argument of buffer done callback or
> private_data would be a serious driver bug and IMHO it's better to let
> it crash with a NULL pointer dereference to let someone notice than mask
> it by adding a condition.
> 

Please, no.  Regardless of who is at fault, crashes in library code
are insanely frustrating to application developers.  Error codes can
be handled nicely and expressed to the user as an error message.
Crashes are hideous for end users and usually end up being support
nightmares for developers.

Related:
https://git.kernel.org/cgit/linux/kernel/git/kay/libabc.git/tree/README?id=0573b57c7bdb4c82d6acd62f7923a6503f4f679a#n126

Andrew
