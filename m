From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Oct 2013 13:09:13 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v3.12
In-Reply-To: <20131002135112.GA2621@localhost>
References: <20130920034613.GB11119@titan.lakedaemon.net>
 <20131002135112.GA2621@localhost>
Message-ID: <CAOesGMiMKRMu18WJ6Nm1JiekwnBkgc0nZc6cfJh2p-c0wUOmjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 2, 2013 at 6:51 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Thu, Sep 19, 2013 at 11:46:13PM -0400, Jason Cooper wrote:
>> Guys,
>>
>> We have a relatively long list of fixes this time around.  The two
>> of_node_put()'s were left over from before the merge window (part of
>> mvebu/fixes-non-critical).
>>
>> The two for the Armada XP clocks are to fix booting v3.12-rc1 since the
>> corresponding driver changes were merged at the last minute.  These were
>> originally part of mvebu/dt for v3.12, but have since become fixes.
>>
>> The other two just cropped up since v3.12-rc1 dropped.
>>
>> thx,
>>
>> Jason.
>>
>> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>>
>>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/linux-mvebu.git tags/fixes-3.12
>>
>> for you to fetch changes up to ddf7e399024aa908573a08d6339cefa6253b83db:
>>
>>   ARM: kirkwood: Fix address of second XOR engine (2013-09-20 03:16:20 +0000)
>>
>> ----------------------------------------------------------------
>> mvebu fixes for v3.12
>>
>>  - mvebu
>>     - fix reference leaks by adding of_node_put()
>>     - update Armada XP DT clock properties to restore booting
>>
>>  - kirkwood
>>     - add missing reg property for cpu at 0
>>     - fix typo in address of second XOR engine
>>
>> ----------------------------------------------------------------
>> Andrew Lunn (1):
>>       ARM: Kirkwood: Add missing DT reg property to cpu at 0
>>
>> Ezequiel Garcia (2):
>>       ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
>>       ARM: mvebu: Add clock properties to Armada XP timer node
>>
>
> For some reason, I'm not seeing the above two in v3.12-rc3.
>
> Guys: what happened? We need these to boot successfully...

It's sitting in our fixes branch which I have not yet sent up. I will
do so in not all that long.


-Olof
