From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 22:31:39 +0900
Subject: [PATCH v2 1/6] arm64: dts: Add symlinks for cros-ec-keyboard and
 cros-ec-sbs
In-Reply-To: <2579212.374vCSe9xi@phil>
References: <20170210010521.78872-1-briannorris@chromium.org>
 <1529949.5djtX72aeJ@phil>
 <CAOesGMirj2j5P7_Ri4CSCux+O3hH_wxvrra7-p33AdXO4Ej5Hg@mail.gmail.com>
 <2579212.374vCSe9xi@phil>
Message-ID: <CAOesGMhmX4pXpKpxhZLGUXFpFEba1qJM7CdK8GzpKmdSab1img@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 10:25 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Mittwoch, 19. April 2017, 21:54:09 CEST schrieb Olof Johansson:
>> Hi,
>>
>> On Tue, Feb 28, 2017 at 3:20 AM, Heiko Stuebner <heiko@sntech.de> wrote:
>> > Hi Olof,
>> >
>> > Am Dienstag, 21. Februar 2017, 15:47:31 CET schrieb Olof Johansson:
>> >> On Thu, Feb 9, 2017 at 5:05 PM, Brian Norris <briannorris@chromium.org> wrote:
>> >> > From: Douglas Anderson <dianders@chromium.org>
>> >> >
>> >> > We'd like to be able to use the cros-ec-keyboard.dtsi and
>> >> > cros-ec-sbs.dtsi snippets for arm64 devices.  Currently those files live
>> >> > in the arm/boot/dts directory.
>> >> >
>> >> > Let's follow the convention set by commit 8ee57b8182c4 ("ARM64: dts:
>> >> > vexpress: Use a symlink to vexpress-v2m-rs1.dtsi from arch=arm") and use
>> >> > a symlink.  Note that in this case we put the files in a new
>> >> > "include/common" directory since these snippets may need to be
>> >> > referenced by dts files in many different subdirectories.
>> >>
>> >> I'd rather have something like this:
>> >>
>> >> https://marc.info/?m=147547436324674&w=2
>> >>
>> >> Instead of having everybody move things over. I.e. make it easy to
>> >> refer to the arm version from arm64 instead of creating a "common"
>> >> layer inbetween.
>> >
>> > just so it gets noticed, I've done and tested [0], which hopefully should
>> > implement your suggestions above.
>> >
>> > If that looks ok, how do you want that picked up? Should I just include
>> > them in my regular rockchip branches or do you to pick them into some
>> > immutable branch, if other surprise-users turn up in time for 4.12?
>>
>> Sigh. I completely dropped the ball on this, and I didn't see it
>> included in any of your pull requests for 4.12 since I never actually
>> acked that approach.
>>
>> I've applied the patches onto a dt/include-paths stable branch, but
>> we're late for merging dependent code on top of it for 4.12.
>
> Didn't you merge the patches into a branch already and the rk3399-gru
> support on top of it?
>
> Aka
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=shared/dt-symlinks
>
> Which one of my previous pull requests was already based on.

Yeah, ignore the above (the original branch is the one to use). I must
be turning blind.

Adding Maxime on Cc since I asked him to move over to the new include
model post-rc1 for some of his stuff.


-Olof
