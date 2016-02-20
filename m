From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 19:22:04 +0100
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <20160220171459.GA18327@sirena.org.uk> (Mark Brown's message of
 "Sun, 21 Feb 2016 02:14:59 +0900")
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
Message-ID: <871t87z1gz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Sat, Feb 20, 2016 at 03:37:56PM +0100, Robert Jarzmik wrote:
>
>> +WM9713 audio CODEC
>> +
>> +This devices supports I2C.
>
> No, it clearly doesn't...
Right, it supports AC97.

> The problem with doing this is that since AC'97 is an enumerable bus we really
> shouldn't need to list AC'97 CODECs in the device tree.
Ok, I understand that.

> Instead we should be probing at runtime (as the non-ASoC AC'97 code does) or
> something similar.
When you say "non-ASoC AC'97 code", which file are you referring to ? Is it
sound/pci/ac97/ac97_codec.c ?

If so is there already a table of tuples (AC97_VENDOR_ID1, AC97_VENDOR_ID2) ->
(platform device, platform device data) and a matching mechanism already
available to the ASoC drivers ?

Cheers.

-- 
Robert
