From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 07 Oct 2015 07:36:29 -0700
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <20151005173957.B1BD16C8150E@dd34104.kasserver.com> (Timo
 Sigurdsson's message of "Mon, 5 Oct 2015 19:39:57 +0200 (CEST)")
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150818153631.GH2547@lukather>
 <CAMAWPa-Q7o+Ys2FjhLZt6Nwq=Ja6TTdWFDZFTCYLkoLGjpLpxw@mail.gmail.com>
 <20151005173957.B1BD16C8150E@dd34104.kasserver.com>
Message-ID: <7hzizu924y.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Timo Sigurdsson" <public_timo.s@silentcreek.de> writes:

> Kevin Hilman schrieb am 24.09.2015 19:57:
>> kernelci.org started finding boot faiulres[1] on bananapi linux-next
>> around next-20150918, but it was only failing in some labs and not
>> others.  I finally bisected it down to this patch, which landed in
>> linux-next in the form of 2d665a8a8350 ARM: dts: sunxi: Add regulators
>> for LeMaker BananaPi.  Reverting that commit on top of next-20150923
>> gets my bananapi booting again.
>> 
>> Note it's kind of an interesting boot failure.  The kernel boots fully
>> to a shell, but panics after running a few commands.  In particular
>> 'dmesg -n1' seems to trigger it usually[2].
>> 
>> Kevin
>> 
>> [1]
>> http://kernelci.org/boot/sun7i-a20-bananapi/job/next/kernel/next-20150923/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=5602504359b514be146c326f
>> [2]
>> http://storage.kernelci.org/next/next-20150923/arm-multi_v7_defconfig/lab-khilman/boot-sun7i-a20-bananapi.html
>
> following up on my last email: I'm back from my vacation and I tried to
> reproduce your problem, but my board doesn't seem to be affected, so I
> cannot trigger it.
>
> I still think that the lower voltages may be the cause of your problem
> with that specific board, so could you please test the attached patch on
> top of my patch that you first experienced the problem with? Please let 
> us know whether this solves your issue or whether we need to dig deeper.

Thanks for the patch.  Looks like it's the OPPs.

I went back to next-20150923 and verified it still fails.  Then, I
applied your patch and saw that it boots just fine.

Kevin
