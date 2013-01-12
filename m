From: hechtb@gmail.com (Bastian Hecht)
Date: Sat, 12 Jan 2013 16:43:29 +0100
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: Add CPU sleep suspend
In-Reply-To: <Pine.LNX.4.64.1301111031220.2604@axis700.grange>
References: <1354709587-25288-1-git-send-email-hechtb+renesas@gmail.com>
 <CANqRtoQMweOU-Azfwu3-HXKx0Hr0seQYy1hi+arLHN-q=BSh+w@mail.gmail.com>
 <20121214134727.GL16382@verge.net.au>
 <Pine.LNX.4.64.1301111031220.2604@axis700.grange>
Message-ID: <CABYn4swp_DGZTSWm+Otc_xwx4pDS7quUop5RNMH+32mjuGZj5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi, hi Simon,

yes somehow a chunk is missing from my original patch in the patch of
the next branch that got merged from soc2. I've prepared a revert of
the bad patch and a corrected version, but now I'm unsure if that
helps at all. Finally you don't want to get that fixups pulled into
the mainline.

It seems to me to be a real mess to correct some patch somewhere in
the middle of merged patch stacks. If I can help Simon, please let me
know.

Cheers,

 Bastian


2013/1/11 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> Hi Simon
>
> On Fri, 14 Dec 2012, Simon Horman wrote:
>
>> On Fri, Dec 14, 2012 at 12:23:06PM +0900, Magnus Damm wrote:
>> > On Wed, Dec 5, 2012 at 9:13 PM, Bastian Hecht <hechtb@gmail.com> wrote:
>> > > From: Bastian Hecht <hechtb@gmail.com>
>> > >
>> > > Add the lighest possible sleep mode on Cortex-A9 cores: CPU sleep. It is
>> > > entered by a simple dsb and wfi instruction via cpu_do_idle(). As just
>> > > clocks are stopped there is no need to save or restore any state of the
>> > > system.
>> > >
>> > > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> >
>> > Acked-by: Magnus Damm <damm@opensource.se>
>>
>> Hi Bastian,
>>
>> could you please re-spin this series on top of the soc5 or next
>> branches of my renesas tree on kernel.org?
>>
>> Feel free to include Magnus's Ack unless you make any
>> non-trivial changes.
>
> It looks like this commit in your tree
>
> http://git.kernel.org/?p=linux/kernel/git/horms/renesas.git;a=commitdiff;h=1662b83628a0c6fd6d8a2a0dcf9b67577906e75b
>
> is broken, am I right?
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
