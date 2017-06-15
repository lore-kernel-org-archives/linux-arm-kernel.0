From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 15 Jun 2017 11:53:34 +0800
Subject: [linux-sunxi] Re: [PATCH 1/2] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170615035407.GM13020@localhost>
References: <20170605123348.26137-1-icenowy@aosc.io>
 <20170605123348.26137-2-icenowy@aosc.io> <20170614083252.GK13020@localhost>
 <AD656BCC-5064-454F-9576-FA59283E0C45@aosc.io>
 <20170614084529.GL13020@localhost> <20170614090439.rkdaoo3uqzjqwuxq@flea.lan>
 <20170615035407.GM13020@localhost>
Message-ID: <29B06690-5F41-4417-8894-7B09ECAA578B@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?15? GMT+08:00 ??11:54:08, Vinod Koul <vinod.koul@intel.com> ??:
>On Wed, Jun 14, 2017 at 11:04:39AM +0200, Maxime Ripard wrote:
>> On Wed, Jun 14, 2017 at 02:15:29PM +0530, Vinod Koul wrote:
>> > > SoC info is in compatible, so there's no reason to make it a
>property.
>> > 
>> > that's why it would need to be optional for the SoC's that needs
>these..
>> 
>> There's nothing optional about that behaviour, it's mandatory for the
>> SoC that need it, and useless on the SoC that don't.
>
>And why should kernel put strings for each hw behaviour. I am expecting
>DT
>to tell me if this SoC is a special case or not and kernel shall handle
>accordingly

I don't think this kind of behavior should be described in DT.

Rob, do you agree?

>
>> Plus, that would require changing the DT binding, which isn't
>> something we can do.
>
>Any reason why bindings can't change..? I though this was support for
>new
>SoC...

This is a behavior that exists on a SoC that is already
supported (A23/A33).
