From: ccross@android.com (Colin Cross)
Date: Mon, 11 Jul 2011 21:02:41 -0700
Subject: [PATCH 1/2] ARM: tegra: remove copy-and-pasted i2c platform data
	in boards
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049E834150@HQMAIL01.nvidia.com>
References: <1310336374-31727-1-git-send-email-ccross@android.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049E834150@HQMAIL01.nvidia.com>
Message-ID: <CAMbhsRQqv23cWBOCxhtA+U=tYxnGka_zNHHGLJbg3766ZYnD+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 8:02 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Colin Cross wrote at Sunday, July 10, 2011 4:20 PM:
>> Every board file includes the same platform data definition
>> for the i2c-tegra driver's bus speed. ?Move the platform data
>> into devices.c, and remove it from all the board files.
>
> For both these patches, it seems like pure luck that all current board
> happen to share the same platform data.

Partially luck, partially that every board here is based on nVidia's
reference designs.

> Given that they do, the change seems conceptually fine, but I wouldn't
> necessarily expect any future boards to be able to share the data, and
> so this change would make any differing future boards work differently
> to all the existing boards...
>
> I guess the idea is that by the time any new boards come along, Device
> Tree will be fleshed out enough that we wouldn't need to add code for
> the new boards, but just a Device Tree file, so my point isn't an issue?

Either device tree will solve all the world's problems, or I'll add a
function to initialize the device that takes whatever data needs to be
customized.  That can be solved if it ever becomes necessary.

Any other comments or testers?  Otherwise, I'll try to get this in the
arm-soc tree.
