From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Aug 2012 14:45:23 +0200
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120821135045.58e2a633@skate>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120816132839.GO22226@titan.lakedaemon.net>
 <20120816183708.GT22226@titan.lakedaemon.net>
 <20120817152156.4d91ba16@skate>
 <20120819012303.GX22226@titan.lakedaemon.net>
 <20120821114630.545fb771@skate>
 <CABJ1b_RVaSjsneDCvejSMot0ZHDr1dmeroVRDUNMF2y83UGXNA@mail.gmail.com>
 <20120821135045.58e2a633@skate>
Message-ID: <CABJ1b_Tg-O6HOnrLynJv33oFYAaqSKJ+XmvwW7TzY47Q4+MhDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/21/12, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Ok, I will look at your code, but the purpose of
> PLAT_ORION/PLAT_ORION_LEGACY was not only to re-use the addr-map code,
> but also to allow drivers to access the header files containing their
> platform_data structure and other stuff (i.e, all the header files from
> arch/arm/plat-orion/include/). How do you handle this problem if
> MACH_MVEBU is not a PLAT_ORION platform?

Hmm, ok I wasn't aware of that. But I have a bad feeling about joining
PLAT_ORION into MACH_MVEBU if you want to have ORION replaced
by MVEBU in the future. Maybe it is better here to put all you need into
mach-mvebu/include/mach/legacy.h that can be easily abandoned when
everything is ported to something more general.

I know it is code duplication but it is only for the purpose of removing
PLAT_ORION later on.

Sebastian
