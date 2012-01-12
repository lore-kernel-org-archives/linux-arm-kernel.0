From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 12 Jan 2012 08:49:54 -0800
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <20120112122406.GG7180@jl-vm1.vm.bytemark.co.uk>
References: <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0DF1E6.40602@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
 <20120112122406.GG7180@jl-vm1.vm.bytemark.co.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D1C9A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote at Thursday, January 12, 2012 5:24 AM:
...
> For all the above reasons I think the DDC/EDID support in the kernel
> should be moving gently towards a (very small) DDC/EDID mini-subsystem
> shared by video drivers.  I.e. it should be exposed as a well-known
> I2C bus name, and if it's GPIO bit-banging I2C, that should be exposed
> as well.

I don't think a single well-known bus name would work, since it's very
common for a system to have multiple DDC busses, since they have multiple
video connectors.

However, representing each physical connector as a jack object to user-
space (perhaps related to media controller, or a cross-subsystem extension
of the ALSA jack objects?) and associating the I2C bus ID (or some more
abstract display-oriented ID) with it would make sense.

-- 
nvpublic
