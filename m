From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Wed, 25 Jul 2012 08:26:38 +0300
Subject: [alsa-devel] [PATCH 0/4] ASoC: fix saif record unwork issue
In-Reply-To: <20120724192125.GF3099@opensource.wolfsonmicro.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <500E992E.6090900@bluegiga.com>
 <20120724192125.GF3099@opensource.wolfsonmicro.com>
Message-ID: <500F838E.6050709@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2012 10:21 PM, Mark Brown wrote:
> On Tue, Jul 24, 2012 at 03:46:38PM +0300, Lauri Hintsala wrote:
>
>> 1. Recorded audio file is totally silent. Hexdump shows zeros.
>
> This one is commonly due to devices powering up muted by default and
> requiring that you set some controls to route the audio through - are
> you sure you've not missed anything there?

I tried to set gains and other settings with alsamixer. I didn't see any 
options for muting. Here is the output of amixer.

$ amixer
Simple mixer control 'Headphone',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 127
   Mono:
   Front Left: Playback 122 [96%] [9.50dB]
   Front Right: Playback 122 [96%] [9.50dB]
Simple mixer control 'Headphone Mux',0
   Capabilities: enum
   Items: 'DAC' 'LINE_IN'
   Item0: 'LINE_IN'
Simple mixer control 'Headphone Playback ZC',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'PCM',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 192
   Mono:
   Front Left: Playback 173 [90%]
   Front Right: Playback 173 [90%]
Simple mixer control 'Mic',0
   Capabilities: volume volume-joined penum
   Playback channels: Mono
   Capture channels: Mono
   Limits: 0 - 4
   Mono: 2 [50%] [30.00dB]
Simple mixer control 'Capture',0
   Capabilities: cvolume penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 15
   Front Left: Capture 14 [93%]
   Front Right: Capture 14 [93%]
Simple mixer control 'Capture Attenuate Switch (-6dB)',0
   Capabilities: volume volume-joined penum
   Playback channels: Mono
   Capture channels: Mono
   Limits: 0 - 2
   Mono: 2 [100%]
Simple mixer control 'Capture Mux',0
   Capabilities: enum
   Items: 'MIC_IN' 'LINE_IN'
   Item0: 'LINE_IN'
Simple mixer control 'Capture ZC',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]

The testing is not currently very reasonable. I have to reboot my 
machine after every single recording because of "busy" bug.

Regards,
Lauri
