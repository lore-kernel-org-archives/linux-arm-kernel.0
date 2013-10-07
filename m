From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Oct 2013 11:27:28 -0600
Subject: Arm PCIe hotplugging
In-Reply-To: <CAFJTrDtw4v51_2XvOfNKnMaeVu5g_cT1KLuJNVufWQx50PiSsw@mail.gmail.com>
References: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
 <20131004165323.GB10315@obsidianresearch.com>
 <CAFJTrDtw4v51_2XvOfNKnMaeVu5g_cT1KLuJNVufWQx50PiSsw@mail.gmail.com>
Message-ID: <20131007172728.GB10426@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 10:30:37AM +0100, Matthew Minter wrote:
> Thanks for the help with this. Looking at the design of the board
> being worked on it seems that rescan should be enough hopefully (the
> pci bus is powered from a separate supply than the SOC so it should be
> possible to shut it down during changes.)

You only need to shut it down if you are making mechanical changes
that are electrically unsafe (eg a risk of shorting). Many specalized
connectors for backplanes and what not may not need this precaution.

The common beige card-edge connector absolutely requires power off. 

> However I might also look into the controls provided by PLX to see if
> there is anything simple to use to control power per slot.

If the board hasn't wired a per-slot power gate to the PLX chip then
the PLX controls are not going to be very usefull to you.

Jason
