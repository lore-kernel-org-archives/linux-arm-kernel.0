From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 26 Apr 2016 21:09:08 +0200
Subject: [alsa-devel] [PATCH 3/3] ASoC: bcm2835: Register also as PCM
 device
In-Reply-To: <20160426180542.GA767@camel2.lan>
References: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
 <1461591580-7565-3-git-send-email-kernel@martin.sperl.org>
 <571E218A.7050508@metafoo.de> <20160425171515.GA10952@camel2.lan>
 <571F2B09.1000107@metafoo.de> <20160426130914.GA2015@delle.lan>
 <571F6B95.1000709@metafoo.de> <20160426151841.GA5433@camel2.lan>
 <571F89A4.6070008@metafoo.de> <20160426180542.GA767@camel2.lan>
Message-ID: <571FBCD4.3010407@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2016 08:05 PM, Matthias Reichl wrote:
[...]
> 
> Ok, I think I got you now and I have to say that solution is really elegant.
> I wouldn't have thought that it could be that simple. V2 of the patch
> is below.

Looks good. One minor thing inline below. Please split this into two
patches, one adding support for the flag and the other using it in the bcm
diver and then send them to the ASoC maintainers.

[...]
> +		hw.formats = GENMASK_ULL((int)SNDRV_PCM_FORMAT_LAST-1, 0);

setting it to 0 is OK. 0 is a special case that means all formats supported.
