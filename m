From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 9 Dec 2016 08:45:41 +0100
Subject: [RESEND PATCH v2 0/7] drm/vc4: VEC (SDTV) output support
In-Reply-To: <68783643.33021.1481268157922@email.1und1.de>
References: <1480686493-4813-1-git-send-email-boris.brezillon@free-electrons.com>
 <68783643.33021.1481268157922@email.1und1.de>
Message-ID: <20161209084541.0e89e533@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Dec 2016 08:22:37 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi,
> 
> > Boris Brezillon <boris.brezillon@free-electrons.com> hat am 2. Dezember 2016 um 14:48 geschrieben:
> > 
> > 
> > Sorry for the noise, but I forgot to Cc the DT maintainers.
> > 
> > Here is the 2nd version of the VC4/VEC series.
> > 
> > We still miss the two clock patches mentioned by Eric in the first
> > version to make the encoder work no matter the setting applied by the
> > bootloader.  
> 
> are there any advices to test this feature?

Apply these patches [1][2][3][4] in addition to this series, and you
should see the SDTV output when running modetest (this is what I used
to test/debug the driver).

This is the command I use to test the SDTV output in NTSC mode

modetest -s 39:720x480

> 
> Is it possible to use an old Raspberry Pi B (256 MB RAM) for this?

I did most of my test on a RPi-2, but IIRC, Eric tested it on a RPi
(don't know which model).

> 
> Thanks
> 
> Stefan

[1]https://patchwork.kernel.org/patch/9442127/
[2]https://patchwork.kernel.org/patch/9456911/
[3]https://patchwork.kernel.org/patch/9456909/
[4]https://patchwork.kernel.org/patch/9456731/
