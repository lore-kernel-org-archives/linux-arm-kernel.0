From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 9 May 2010 18:52:03 +0100
Subject: [alsa-devel] about ALC203 linux driver
In-Reply-To: <AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
	<20100509144940.GA7457@sirena.org.uk>
	<AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
Message-ID: <20100509175202.GA5826@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 09, 2010 at 11:34:28PM +0800, Wan ZongShun wrote:

> here, I used the file named ac97.c which is located in
> linux-2.6\sound\soc\codecs.
> I am sure that it can call the '\sound\pci\ac97ac97_codec.c' file and
> identify the
> ALC203 (like the log file shows 'nuc900 AC'97 codec is  ALC203',but sometimes
> the return value by reading one AC97 register, which is not same as
> the writing value to the
> AC97 register, that is not my expected result, but sometimes they are same.

> any suggestions?

Not all AC97 registers are writable so check that you're writing to
registers that the CODEC supports writing to but in general you're going
to need to debug your controller driver here.  Make sure you're
interacting well with any cache the controller has and that you are
properly synchronising with the controller during reads (which are
fairly slow operations on AC97).

Also make sure that the CODEC is properly clocked.
