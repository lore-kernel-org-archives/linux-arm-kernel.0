From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 9 Apr 2018 13:28:29 +0200
Subject: SUN6I a31 OPP table clock issue
In-Reply-To: <8b797d9c-b2fb-e49b-daa2-e4e15753f3fa@orpaltech.com>
References: <c309c971-7559-e1d9-dc9f-2f7a7ad6f3cb@orpaltech.com>
 <20180409085356.goemvdy3ecyqoghp@flea>
 <8b797d9c-b2fb-e49b-daa2-e4e15753f3fa@orpaltech.com>
Message-ID: <20180409112829.dckferoj6n2j2sbj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 01:35:42PM +0300, Sergey Suloev wrote:
> On 04/09/2018 11:53 AM, Maxime Ripard wrote:
> > On Sat, Apr 07, 2018 at 10:53:10PM +0300, Sergey Suloev wrote:
> > > I was able to catch oops coming from OPP table on BananaPi M2.
> > > 
> > > https://pastebin.com/ZRaXTtEx
> > > 
> > > Let me know if need more detail.
> > Of course we do.
> > 
> > Which kernel version was this for? With which configuration? What
> > makes you say it's related to the OPP table, is it a regression or
> > something you just noticed?
>
> Ok, first of all, I am having the problem using linus tree, 4.16 as it is,
> with no extra patches.

Your kernel version is marked as dirty in your logs, which means you
have local changes. So it doesn't really qualify as "as is".

> My config file is here [1].
> The problem is easily avoided by just commenting all freqs out of the OPP
> table except for 1008 MHz, i.e. things work well when there is no freq
> switch at all.
> It makes me think that there might be an issue in A31 clocks driver as it is
> the only important component used by cpufreq-dt.
> As of cpufreq-dt driver it seems ok because works fine on other boards.

Could you add some printk's to ccu_mux_notifier_nb to see which
pointer is NULL?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/8f93bff4/attachment.sig>
