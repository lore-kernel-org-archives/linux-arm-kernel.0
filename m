From: mpeg.blue@free.fr (Mason)
Date: Sat, 31 Jan 2015 00:44:15 +0100
Subject: RFC on cpufreq implementation
In-Reply-To: <CAKohponrzDb4ZGvRtJ5jtGTPAy4RCfRsYGvdjR5fx51K2=evCg@mail.gmail.com>
References: <54B7F7CD.7030903@free.fr> <54CA6327.5070707@free.fr>
 <CAKohponrzDb4ZGvRtJ5jtGTPAy4RCfRsYGvdjR5fx51K2=evCg@mail.gmail.com>
Message-ID: <54CC174F.10703@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/2015 02:15, Viresh Kumar wrote:

> What do you want to do with this driver? If you want to get it reviewed,
> please send it properly with git-send-email instead of attachments..
> 
> If its just an internal one, then sorry, the lists aren't for such reviews.

The long-term goal is to mainline the whole port, but it's rather
overwhelming, and I haven't found a way to divide-and-conquer, yet.
I've been reading guides and documentation for weeks, but nothing
has made my brain click.

Everything seems to involve DeviceTree, and AFAIU, going down that
rabbit-hole means making lots of changes all over. (But I probably
misunderstood that part too.)

Right now, all I have is this cleaned up cpufreq driver. And I don't
even know where to put it!

I see some platforms have it in their machine-specific folder, others
are in drivers/cpufreq. (When to use mach vs plat?)

If it's supposed to go in drivers/cpufreq, I suppose there are naming
conventions to follow?

Also, if it's in drivers/cpufreq, we are not supposed to include
any machine-specific includes? And I'm back to my original question
where am I supposed to store machine-specific information, such as
register descriptions and MMIO addresses and offsets?

Two months ago, Arnd wrote:
> I meant the IO_ADDRESS stuff. Modern code uses ioremap() instead
> since the IO_ADDRESS was platform specific, and drivers can no longer
> use platform headers on CONFIG_ARCH_MULTIPLATFORM, which is used
> for all new code now.

Regards.
