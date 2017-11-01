From: eric@anholt.net (Eric Anholt)
Date: Wed, 01 Nov 2017 09:54:53 -0700
Subject: [GIT PULL 1/2] bcm2835-dt-fixes-2017-10-06
In-Reply-To: <CAJsfgeU5Zq-2zSfto8WUZ5Xud1Ksedu9XdLG9pWR7YBZGVaHBA@mail.gmail.com>
References: <20171006220504.7776-1-eric@anholt.net>
 <edb03edb-f2a6-549e-6060-eccfae554d92@gmail.com>
 <CAJsfgeU5Zq-2zSfto8WUZ5Xud1Ksedu9XdLG9pWR7YBZGVaHBA@mail.gmail.com>
Message-ID: <87wp3andlu.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt Hart <matt@mattface.org> writes:

> On 6 October 2017 at 23:14, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 10/06/2017 03:05 PM, Eric Anholt wrote:
>> > Hi Florian.  Here's a patch that's gone through a couple of revisions
>> > on the list, that seriously fixes up the default serial behavior --
>> > previously, without the right config.txt/cmdline bits, you'd often end
>> > up with a hang with no output before booting completed.  It would be
>> > great to get it into 4.14.
>> >
>> > The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
>> >
>> >   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://github.com/anholt/linux tags/bcm2835-dt-fixes-2017-10-06
>> >
>> > for you to fetch changes up to f08f58a2bf68900a84e782b8c7ad701c0654173c:
>> >
>> >   ARM: dts: bcm283x: Fix console path on RPi3 (2017-10-06 13:04:56 -0700)
>> >
>> > ----------------------------------------------------------------
>> > This pull request brings in a fix for default serial console setup on
>> > RPi3, so it now comes up with no config.txt/cmdline.txt settings in
>> > the firmware.
>> >
>> > ----------------------------------------------------------------
>>
>> Merged, thanks Eric
>>
>> --
>> Florian
>
> Hi all,
>
> I realise this patch has been in mainline for a more than a week, but
> I've only recently had time to bisect broken rpi-3 boots in kernelci
> and found f08f58a2bf68900a84e782b8c7ad701c0654173c as the cause.
>
> Kernelci boots the rpi3 using uboot, with console=ttyS0 in the command
> line which now fails:
> https://kernelci.org/boot/id/59f787f059b5147794ef1dcf/
>
> Is there an alias I can use for both before and after this patch?
>
> Mainline boots fine if I use console=ttyS1 or drop the console arg
> altogether, but as we don't currently support different boot args per
> tree, and we don't have the manpower to track this patch in all the
> trees we test, we will have to switch to only boot testing mainline
> from now on.
>
> It seems to me the patch is doing the right thing, so this is just an
> FYI, though I can imagine a few users getting caught by this.

Yeah, this matches my experience basically.  As far as I can tell, we
were just doing things wrong before, thus needing these custom boot args
that we can all now get rid of.  I wish I had a better answer.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171101/43c9b1b3/attachment.sig>
