From: zswan@marvell.com (Vincent Wan)
Date: Sun, 9 May 2010 18:24:49 -0700
Subject: [alsa-devel] about ALC203 linux driver
In-Reply-To: <20100509175202.GA5826@sirena.org.uk>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
	<20100509144940.GA7457@sirena.org.uk>
	<AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
	<20100509175202.GA5826@sirena.org.uk>
Message-ID: <4737A960563B524DA805CA602BE04B305E4B5E450A@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,



Thanks for your help, and I think that is a true direction.

I will re-check my driver as soon as I come back to home.



Wan.



-----Original Message-----
From: Mark Brown [mailto:broonie at opensource.wolfsonmicro.com]
Sent: 2010?5?10? 1:52
To: Wan ZongShun
Cc: Vincent Wan; alsa-devel at alsa-project.org; linux-arm-kernel
Subject: Re: [alsa-devel] about ALC203 linux driver



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
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100509/c08c03fb/attachment-0001.htm>
