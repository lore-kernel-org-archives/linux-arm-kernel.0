From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 9 May 2010 15:49:41 +0100
Subject: [alsa-devel] about ALC203 linux driver
In-Reply-To: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
Message-ID: <20100509144940.GA7457@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 09, 2010 at 10:40:07PM +0800, Wan ZongShun wrote:

> At present, there is a ALC203 AC97 codec in my Winbond ARM board, and
> I am programming
> the audio driver based on ALSA, Who can tell me whether the current
> ALSA is supporting
> the ALC203 driver?how to enable it?

You need a driver for the AC97 controller your system is using (for most
ARM systems this is part of the CPU).  Since AC97 provides a standard
register interface for CODECs Linux does not require specific support
for individual AC97 CODECs in order to get core functionality working.

You can check if there's any specific CODEC support in sound/pci/ac97.
