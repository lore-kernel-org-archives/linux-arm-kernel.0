From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 20 May 2014 21:31:57 +0200
Subject: [alsa-devel] [PATCH] Fix for possible null pointer dereference
 in dma.c
In-Reply-To: <20140520192958.GE6639@foghorn.codeweavers.com>
References: <1400191076-28279-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <5379E284.7030700@gmail.com>
 <CAFo99gZ3kVGn04we5OtRtbkceYRs6SiHXRyoX1Gb-SknJH=z=w@mail.gmail.com>
 <537BAA2B.9090906@gmail.com> <20140520192958.GE6639@foghorn.codeweavers.com>
Message-ID: <537BADAD.5070904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20.05.2014 21:29, Andrew Eikum wrote:
> On Tue, May 20, 2014 at 09:16:59PM +0200, Tomasz Figa wrote:
>> To me having NULL as either data argument of buffer done callback or
>> private_data would be a serious driver bug and IMHO it's better to let
>> it crash with a NULL pointer dereference to let someone notice than mask
>> it by adding a condition.
>>
> 
> Please, no.  Regardless of who is at fault, crashes in library code
> are insanely frustrating to application developers.  Error codes can
> be handled nicely and expressed to the user as an error message.
> Crashes are hideous for end users and usually end up being support
> nightmares for developers.

How is the related code a library?

Best regards,
Tomasz
