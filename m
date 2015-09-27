From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Sep 2015 10:20:58 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <20150925150558.184E66C8385C@dd34104.kasserver.com>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150818153631.GH2547@lukather>
 <CAMAWPa-Q7o+Ys2FjhLZt6Nwq=Ja6TTdWFDZFTCYLkoLGjpLpxw@mail.gmail.com>
 <20150925150558.184E66C8385C@dd34104.kasserver.com>
Message-ID: <20150927082058.GF7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 05:05:58PM +0200, Timo Sigurdsson wrote:
> Hi Kevin,
> 
> Kevin Hilman schrieb am 25. Sept 2015 01:57:
> 
> > On Tue, Aug 18, 2015 at 8:36 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> >> On Sun, Aug 02, 2015 at 06:18:25PM +0200, Timo Sigurdsson wrote:
> >>> sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209
> >>> PMU
> >>> driver, so add them to allow for voltage-scaling with cpufreq-dt.
> >>>
> >>> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> >>
> >> Queued, thanks!
> >> Maxime
> > 
> > kernelci.org started finding boot faiulres[1] on bananapi linux-next
> > around next-20150918, but it was only failing in some labs and not
> > others.  I finally bisected it down to this patch, which landed in
> > linux-next in the form of 2d665a8a8350 ARM: dts: sunxi: Add regulators
> > for LeMaker BananaPi.  Reverting that commit on top of next-20150923
> > gets my bananapi booting again.
> > 
> > Note it's kind of an interesting boot failure.  The kernel boots fully
> > to a shell, but panics after running a few commands.  In particular
> > 'dmesg -n1' seems to trigger it usually[2].
> > 
> > Kevin
> > 
> > [1]
> > http://kernelci.org/boot/sun7i-a20-bananapi/job/next/kernel/next-20150923/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=5602504359b514be146c326f
> > [2]
> > http://storage.kernelci.org/next/next-20150923/arm-multi_v7_defconfig/lab-khilman/boot-sun7i-a20-bananapi.html
> > 
> 
> Thanks for your feedback. I'm traveling at the moment, so I can't do
> any testing but just guess wildly. I know, though, that I used dmesg
> frequently when I did my own testing before submitting the patch and
> could not see such behavior.
> 
> Before this commit, the CPU of your BananaPi runs at 1.4 volts
> constantly. With this commit applied, the CPU voltage should vary
> between 1.0-1.4 volts depending on the frequency and defined
> operating points. Hence, one of my guesses would be that your CPU is
> not stable at the lower voltages. Could you modify the voltages for
> the defined frequencies in sun7i-a20.dtsi and test if that solves
> your issue? Say, raise the voltage by 0.1 volts for each operating
> point (but no higher than 1.4). I actually had a different patch
> that applied slightly higher voltages taken from the original fex
> for by LeMaker, but the feedback was, unless there are actual
> reports about boards not running stable at the current settings, we
> just keep them instead. So, I'm curious if you happen to have a
> board that requires slightly higher voltages to run stable.

I've dropped the patch waiting for you to come back from your holidays
when we will have more time to figure out what's wrong.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150927/e0f242f6/attachment-0001.sig>
