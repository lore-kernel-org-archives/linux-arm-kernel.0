From: andrew@ncrmnt.org (Andrew)
Date: Wed, 07 Oct 2015 00:30:11 +0300
Subject: [RFC][PATCH 2/2] staging: ion: Add files for parsing the
 devicetree (WIP)
In-Reply-To: <1444164433-9107-3-git-send-email-labbott@fedoraproject.org>
References: <1444164433-9107-1-git-send-email-labbott@fedoraproject.org>
 <1444164433-9107-3-git-send-email-labbott@fedoraproject.org>
Message-ID: <4336b2d38b1f92a5dddf979e63954470@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks a lot for starting again with dt bindings discussion.
I got carried away by work and never had a chance for a respin of my 
ion-physmem.

I'll try to test these on actual hardware next week and provide more 
detailed
feedback. For now just a small pick:

> -
> +obj-$(CONFIG_ION_DUMMY)   += ion_dummy_driver.o
> +obj-$(CONFIG_ION_PHYSMEM) += ion_physmem.o
> +obj-$(CONFIG_ION_TEGRA)   += tegra/
> +obj-$(CONFIG_ION_OF) +=	ion_of.o ion_physmem.o

ion_physmem.o looks like the one that shouldn't be here, right?

P.S. Anyone interested in a non-android port of libion with
a few helper utils? I had to call it liblinuxion, since libion is 
something
already present in repositories.

-- 
Regards,
Andrew
RC Module
