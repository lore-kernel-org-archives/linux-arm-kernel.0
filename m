From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 15 Apr 2010 09:58:31 +0200
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
In-Reply-To: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
References: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
Message-ID: <20100415075831.GL30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 02:02:47PM -0600, Badguy Badguy wrote:
>  I am attempting to boot the 2.6.33.2 Kernel on the LogicPD LiteKit iMX31.
> we have a board based on this one, and I am using it and the dev kit with no
> success.
> 
> I see a lot of support in the mainline kernel for this board, is it safe to
> assume someone is able to boot this board using it?
> 
> I am running the lolo bootloader from Logic, version 2.4.0.
> 
> I have compiled the kernel using a fairly new ltib environment.
> 
> Currently I run 2.6.19.2 from Freescale / Logic with success but now desire
> to upgrade the kernel to something with better MMC support, I am not stuck
> on 2.6.33.2 if someone can recommend a newer kernel that has some of the
> support I desire.
> 
> When I attempt to boot the kernel, It hangs and this is my only output:
>  Uncompressing Linux... done, booting the kernel.

Ah, one more thing: You need to pass a new variable to the kernel upon
startup: "mx31lite_baseboard=1". This was done in order to split module
code from baseboard code.

In case you're using the 2-stage loading mechanism, you need to teach
this to your first-stage loader.

Also make sure you're downloading the full image to RAM from LoLo. The
new kernel is certainly bigger than the version you currently use.

Daniel
