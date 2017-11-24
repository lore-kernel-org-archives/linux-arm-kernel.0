From: andrea.adami@gmail.com (Andrea Adami)
Date: Fri, 24 Nov 2017 13:52:22 +0100
Subject: [PATCH 3/4] ARM: pxa/spitz: Remove hardcoded partitioning, use
 sharpslpart parser
In-Reply-To: <20171122230633.GC3623@amd>
References: <1511300631-1343-1-git-send-email-andrea.adami@gmail.com>
 <1511300631-1343-3-git-send-email-andrea.adami@gmail.com>
 <20171122230633.GC3623@amd>
Message-ID: <CAAQYJAs4H=8nUkP2fXzxk=RYfCyQkVBu-JfeqQh7SRc0BSoH0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 23, 2017 at 12:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2017-11-21 22:43:50, Andrea Adami wrote:
>> With the introduction of sharpslpart partition parser we can now read the
>> offsets from NAND: we specify the list of the parsers as platform data, with
>> cmdlinepart and ofpart parsers first allowing to override the part. table
>> written in NAND. This is done here in the board file.
>>
>> Emulators like qemu will need to pass the mtdparts in the cmdline.
>
> IOW this will be regression for people emulating zaurus in qemu.
>
> ...
>
> Is it good idea? Its not like this platform data is particulary big or
> changes very often...

Hello Pavel,

afais defining the partitions in the board file is today deprecated,
more than this the definitions are not totally correct,
e.g. ignoring the differences between 3100 and 3200 models.

The original Zaurus kernels did specify mtdparts= in the cmdline so I
don't see this being a big limitation for QEMU.

We are trying to clean out the board files and hopefully move the pxa
Zaurus to devicetree one day...
I think that removing the parttioning differences will ease the task.
Please correct me if I am wrong.

Cheers
Andrea


>
>> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
