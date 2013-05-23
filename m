From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Thu, 23 May 2013 17:05:21 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <20130523145835.GI8595@lukather>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
 <CACRpkdaWADjy1YZXTcRaXU+ZsS6_pG0hojQdnz=qeTgyVY7_Ww@mail.gmail.com>
 <519DCEE9.6070208@schinagl.nl> <20130523145835.GI8595@lukather>
Message-ID: <519E3031.8080604@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/13 16:58, Maxime Ripard wrote:
> On Thu, May 23, 2013 at 10:10:17AM +0200, Oliver Schinagl wrote:
>> Then, i'm not sure if the driver is the best for this to be loaded?
>> Maxime, what do you think? Personally I would feel more in having
>> this in the mach-sunxi/core.c bit, but then again, this is currently
>> a module and wouldn't be useful to have there. Maxime is far more
>> knowledgeable to answer that.
>
> Hmmm, I don't understand what you mean here. Could you explain what you
> have in mind?
I've thought about it a little, and don't think core.c is a good spot, 
since the module will have to be loaded, or available there. And that's 
really early.

So I guess, during probe, controlled by a parameter perhaps, load all 16 
bytes into the random pool as Linus suggested?
>
> Thanks,
> Maxime
>
