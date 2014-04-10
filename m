From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Thu, 10 Apr 2014 19:20:37 +0100 (BST)
Subject: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410181953.50ccfcc3@skate>
References: <20140410181953.50ccfcc3@skate>
Message-ID: <alpine.DEB.2.10.1404101849270.1578@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, 10 Apr 2014, Thomas Petazzoni wrote:

> Can you test this stack of patches on your system and configuration, and
> let me know if that works for you? Of course, please do not include any
> other PCI related fix: the goal is to be aware of *all* the issues, and
> fix them in mainline.

I have tested this branch on my Mirabox. I still get the link up problem 
but if I work around that (see below) the igb driver works flawlessly.

Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>

> Remaining issues:
>
> * The link up problem. Unfortunately, I tried to reproduce it today,
>   and didn't manage to. It's weird, because I'm sure I was able to
>   produce it in the past, but I'm no longer able to, I don't know.
>   Therefore, it's not easy for me to work on this topic. Neil, Jason,
>   do you think this is a topic you could potentially handle?

Do you have earlyprintk enabled? I've found that if I have earlyprintk in 
my bootargs / command line then I don't get the issue. I assume that is 
because of timing, but it could be something else?

Cheers,
Neil
