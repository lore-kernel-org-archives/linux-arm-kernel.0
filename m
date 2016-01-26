From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 26 Jan 2016 11:22:11 -0800
Subject: mainline build: 137 builds: 0 failed, 137 passed,
 296 warnings (v4.4-10454-g3e1e21c7bfcf)
In-Reply-To: <2640068.aDOyd9eL7v@wuerfel> (Arnd Bergmann's message of "Mon, 25
 Jan 2016 21:52:43 +0100")
References: <56a1c8c2.6953c20a.25484.ffff85a9@mx.google.com>
 <CANMBJr7W5uooa5+1tbTSfToeM6tS69E80ZB0E1gdcSnVaTaDaQ@mail.gmail.com>
 <7hio2hr08f.fsf@kernel.org> <2640068.aDOyd9eL7v@wuerfel>
Message-ID: <7hoac8no2k.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 25 January 2016 10:18:56 Kevin Hilman wrote:
>> Tyler Baker <tyler.baker@linaro.org> writes:
>> 
>> > On 22 January 2016 at 05:19, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> On Thursday 21 January 2016 22:14:26 kernelci. org bot wrote:
>> >>> Warnings summary:
>> >>>
>> >>>     224  <stdin>:1307:2: warning: #warning syscall copy_file_range not implemented [-Wcpp]
>> >>
>> >> I don't think anyone has sent this so far, sending a patch now.
>> >>
>> >>>      29  drivers/tty/serial/amba-pl011.c:190:27: warning: 'vendor_zte' defined but not used [-Wunused-variable]
>> >>
>> >> Patch sent a couple of days ago, got an Ack and waiting to be applied.
>> >>
>> >>>      12  net/bluetooth/mgmt.c:5493:8: warning: 'r192' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> >>>      12  net/bluetooth/mgmt.c:5493:8: warning: 'h192' may be used uninitialized in this function [-Wmaybe-uninitialized]
>> >>
>> >> This happens only in gcc-4.7 and gcc-4.8
>> >>
>> >>>       5  crypto/wp512.c:987:1: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> >>>       1  crypto/wp512.c:987:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>> >>
>> >> and this one only in gcc-4.7
>> >>
>> >> Any chance we can update the toolchain on kernelci.org to 4.9 or higher?
>> >> I'm normally testing with gcc-5.2, which has a little better warnings.
>> >
>> > I'm ok with upgrading to 4.9 or higher. Kevin any issues with this?
>> 
>> No objection in principle, but we probably can't do this across the
>> board without fallout.
>> 
>> I suspect we'll have issues with older stable kernels that have never
>> been compiled with > 4.7, but I haven't actually tried.
>> 
>
> My guess is that there is very little of that. We had one issues with
> gcc-4.8 through 4.8.2 generating bad code, but aside of that I don't
> remember a recent case where a newer compiler broke stuff.
>
> There might be a couple of extra warnings in older kernels, but I've
> tried to ensure that all new warnings that got introduced from more
> recent gcc versions are fixed mainline kernels.

OK, and I guess if we find any breakage, fixes should be submitted to
stable anyways, so I'm OK with the change.

Kevin
