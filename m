From: maxime.ripard@free-electrons.com (maxime.ripard)
Date: Thu, 19 Mar 2015 10:18:43 +0100
Subject: [linux-sunxi] Re: [PATCH 2/3] ARM: sun8i: Add SMP support for
 the Allwinner A23
In-Reply-To: <2015031912050362587032@gmail.com>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
 <1426649042-30547-3-git-send-email-wens@csie.org>
 <20150318102939.GP4638@lukather>
 <CAGb2v65qZBPcury1e-DXwmpJOyS97oWFVisGQKEbTZkc+Z60nQ@mail.gmail.com>
 <2015031912050362587032@gmail.com>
Message-ID: <20150319091843.GA4255@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Mar 19, 2015 at 12:05:06PM +0800, kevin.z.m.zh at gmail.com wrote:
> >> One question I couldn't find any answer to is that does the SMP bit is
> >> set in secondary_startup?
> >>
> >> I couldn't find where it was set, but it still looks like the right
> >> thing to do, so I would expect the code to do that.
> > 
> > I don't see it either. The sun8i code is just the sun6i code with the
> > power clamps removed. And sun6i secondary_startup was removed some time
> > ago in commit 1146b600044d ("ARM: sunxi: fix build for THUMB2_KERNEL").
> > 
> > ChenYu
>
> The SMP bit should be set in the function of "__v7_ca7mp_setup", which is located
> in the file:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mm/proc-v7.S?id=refs/tags/v4.0-rc4
> I'm not sure if this is your discussion.

It is, but I wasn't seeing it called anywhere in the secondary_startup
code path.

I was expecting a direct call, but it looks like it's a dynamic call,
with a function-pointer like call, that is indeed run both in the
kernel entry point and the secondary_startup.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/head.S?id=refs/tags/v4.0-rc4#n389

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/352e3468/attachment.sig>
