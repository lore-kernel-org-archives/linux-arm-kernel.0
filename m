From: pierre-louis.bossart@linux.intel.com (Pierre-Louis Bossart)
Date: Mon, 6 Aug 2018 14:59:03 -0500
Subject: [alsa-devel] [PATCH 9/9] ALSA: intel_hdmi: remove redundant
 variable cfg_val
In-Reply-To: <s5hwot3gub3.wl-tiwai@suse.de>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-10-colin.king@canonical.com>
 <s5hin4unyh0.wl-tiwai@suse.de>
 <a5a408bc-cc58-946e-5b36-496548a6316f@linux.intel.com>
 <s5hwot3gub3.wl-tiwai@suse.de>
Message-ID: <eba27606-0d1e-93d1-4eee-382595fa78f0@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Good to hear, applied the patch now.
>
>> BTW looking at the structures in intel_hdmi_lpe_audio.h, the field
>> format:3 in audio_ch_status_0 is misleading at best, it should be the
>> emphasis if I look at the SPDIF/AES docs. It's not used but I'll have
>> to relook at all this when I find some time... We should really set
>> the registers to mirror what the aes_bits are, not just the non_audio
>> and clock accuracy fields.
> A fix patch is always welcome ;)
This sort of fixes is straighforward, the hard part is to locate an HDMI 
analyzer to double-check that the changes result in something meaningful...
