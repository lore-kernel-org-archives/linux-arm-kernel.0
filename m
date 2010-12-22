From: ext-srikar.1.bhavanarayana@nokia.com (Srikar)
Date: Wed, 22 Dec 2010 13:55:38 +0200
Subject: [PATCH] omap: rx51: Remove tvout code that plays with gpio 40
In-Reply-To: <1293012004.6829.2.camel@tubuntu>
References: <1292953561-22979-1-git-send-email-jhnikula@gmail.com>
	<1293012004.6829.2.camel@tubuntu>
Message-ID: <4D11E73A.8070009@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good, Now GPIO40 now supports switch between Headset and TV Out.
Now updated ASoc Driver is  already available in upstream kernel to
support the switching between Headset and TvOut ...

Srikar
 
On 12/22/2010 12:00 PM, Tomi Valkeinen wrote:
> On Tue, 2010-12-21 at 19:46 +0200, ext Jarkko Nikula wrote:
>> Commit 60d24ee "Added video data to support tvout on rx51" added code that
>> tries to assign gpio 40 as OMAP DSS reset_gpio for tvout. This is wrong
>> since this gpio has nothing to do with OMAP DSS but it is used to control
>> one switch that selects is the audio jack connected to tvout or audio
>> circuitry.
>>
>> This switch is already supported by the RX51 ASoC driver so there is no need
>> to control it elsewhere. Switch is contolled with ALSA control
>> 'Jack Function' and tvout can be selected with following example:
>>
>> 	amixer -D hw:0 set 'Jack Function' 'TV-OUT'
> Looks good. platform_enable/disable and reset_gpio fields should anyway
> be removed from the omap_dss_device struct, so this goes into right
> direction.
>
> Tony, can you take this patch also, as (I guess) it depends on the
> previous rx51 patches from Jarkko?
>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>
>  Tomi
>
>
