From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 07 Oct 2010 13:53:54 +1300
Subject: [PATCH 1/2] ASoC: Add CS4271 codec support
In-Reply-To: <20101007004940.GC30751@opensource.wolfsonmicro.com>
References: <4CAD16A5.1090501@bluewatersys.com>
	<20101007004940.GC30751@opensource.wolfsonmicro.com>
Message-ID: <4CAD1A22.7090306@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2010 01:49 PM, Mark Brown wrote:
> On Thu, Oct 07, 2010 at 01:39:01PM +1300, Ryan Mallon wrote:
>> From: Alexander Sverdlin <subaparts@yandex.ru>
>>
>> Added support for Cirrus CS4271 codec to ALSA SoC subsystem.
>>
>> Applies on: 2.6.36-rc6
> 

Ugh, I managed to miss Alexander from the CC list :-/. Alexander, can
you please update the patch as detailed below.

~Ryan

> Unfortunately there have been major changes in the ASoC APIs in -next
> for Liam's multi-component work so you'll need to update this before it
> can be applied.  You should always submit code against -next (except for
> bug fixes to be sent to Linus).
> 
> See
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> 
> for current code.
> 
> I gave the driver a quick review and it looks really good - it just
> needs to be updated for current APIs.
> 
>> +static const struct snd_kcontrol_new cs4271_snd_controls[] = {
>> +	SOC_DOUBLE_R("Master Playback Volume", CS4271_VOLA, CS4271_VOLB, 0, 0x7F, 1),
> 
> TLV information would be nice but isn't essential.
> 
>> +	SOC_SINGLE("Digital Loopback Switch", CS4271_MODE2, 4, 1, 0),
> 
> This should probably be done as part of DAPM.  Again probably not
> essential.


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
