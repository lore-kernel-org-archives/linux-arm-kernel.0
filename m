From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 5 Oct 2015 16:00:32 +0100
Subject: Regression: at24 eeprom writing
In-Reply-To: <561238A9.1060406@lysator.liu.se>
References: <560F0DB1.2020101@lysator.liu.se> <561238A9.1060406@lysator.liu.se>
Message-ID: <20151005150032.GA12137@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

On Mon, Oct 05, 2015 at 10:45:29AM +0200, Peter Rosin wrote:
> On 2015-10-03 01:05, Peter Rosin wrote:

[...]

> Ok, I found the culprit, and I double and triple checked it this time...
> 
> If I move to the very latest on the linux-3.18-at91 branch, the bug is
> there too. Which made it vastly more palatable to bisect the bug.
> 
> The offender (in the 4.2 kernel) is 93563a6a71bb69dd324fc7354c60fb05f84aae6b
> "i2c: at91: fix a race condition when using the DMA controller"
> which is far more understandable. Ao, adding Cyrille Pitchen to the Cc list.
> 

Thanks for the bisecting effort. I am currently at ELCE where I have
met someone with the same kind of issue. Is it easily reproducible? It
doesn't seem to be the case for him.

I'll have a look once back.

> If I add that patch on top of my previously working tree, it behaves just
> as newer kernels, i.e. equally bad. The patch doesn't revert cleanly, but
> reverting the patch and quick-n-dirty-fixing the conflict on vanilla 4.2
> makes the problem go away.
> 
> I have attached what I actually reverted.
> 
> Cheers,
> Peter
> 

Ludovic
