From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 12:36:24 -0800
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0DF1E6.40602@freescale.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0DF1E6.40602@freescale.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timur Tabi wrote at Wednesday, January 11, 2012 1:33 PM:
> Stephen Warren wrote:
> > Well, the EDID needs to be read on every hotplug event, so it's certainly
> > not a one-time thing.
> 
> What is the hotplug event that triggers an EDID read?

For monitors attached to user-accessible connectors, whenever the user
physically plugs in a new monitor, you need to read the EDID since it
could be a new monitor. DVI and HDMI have explicit hotplug detect lines
to trigger this. I'm not sure how it works for VGA; perhaps you have to
manually reprobe.

Of course, if this thread is talking about built-in LCD displays where
the connectivity is fixed, this is a non-issue, but it's still a relevant
general design discussion; hopefully whatever solution that's picked would
work for DVI/HDMI even if you're dealing with LCDs right now.

-- 
nvpublic
